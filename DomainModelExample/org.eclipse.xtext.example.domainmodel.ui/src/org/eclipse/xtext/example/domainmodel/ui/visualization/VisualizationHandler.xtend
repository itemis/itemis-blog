/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.domainmodel.ui.visualization

import com.google.inject.Inject
import com.google.inject.Provider
import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.core.resources.IFile
import org.eclipse.core.runtime.CoreException
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.xtext.builder.DerivedResourceMarkers
import org.eclipse.xtext.builder.EclipseResourceFileSystemAccess2
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.ui.resource.IResourceSetProvider

import static extension org.eclipse.emf.common.util.URI.createPlatformResourceURI
import static extension org.eclipse.ui.handlers.HandlerUtil.getCurrentSelection

class VisualizationHandler extends AbstractHandler {
	
	@Inject extension IGenerator

	@Inject extension DerivedResourceMarkers
	
	@Inject IResourceSetProvider resourceSetProvider
	
	@Inject Provider<EclipseResourceFileSystemAccess2> fileAccessProvider
	
	override execute(ExecutionEvent event) throws ExecutionException {
		val selection = event.currentSelection
		
		if (selection instanceof IStructuredSelection) {
			val file = selection.firstElement
			if (file instanceof IFile) {
				val project = file.project
				val outputFolderName = "src-gen"
				val srcGenFolder = project.getFolder(outputFolderName)
				if (!srcGenFolder.exists) {
					try {
						srcGenFolder.create(true, true, new NullProgressMonitor)
					} catch (CoreException e) {
						return null
					}
				}
				
				val fsa = fileAccessProvider.get
				fsa.monitor = new NullProgressMonitor
				fsa.project = project
				fsa.setOutputPath(outputFolderName)
				
				val uri = file.fullPath.toString.createPlatformResourceURI(true)
				val resource = resourceSetProvider.get(project).getResource(uri, true)
				
				// ensure that the derived markers are properly set after file generation
				fsa.addDerivedMarkerInstaller(uri.toString)
				
				resource.doGenerate(fsa)
				
			}
		}
		
		null
	}
	
	private def addDerivedMarkerInstaller(EclipseResourceFileSystemAccess2 fsa, String source) {
		fsa.postProcessor = new EclipseResourceFileSystemAccess2.IFileCallback() {
			
			override afterFileCreation(IFile file) {
				file.afterFileUpdate
			}
			
			override afterFileUpdate(IFile file) {
				file.installMarker(source)
			}
			
			override beforeFileDeletion(IFile file) {
				false
			}
		
		}
	}
}
