/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.homeautomation.ui.editor

import com.google.inject.Inject
import java.util.List
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IStorage
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.runtime.CoreException
import org.eclipse.emf.common.util.URI
import org.eclipse.jface.viewers.ISelection
import org.eclipse.ui.IEditorPart
import org.eclipse.ui.IStorageEditorInput
import org.eclipse.ui.part.IShowInSource
import org.eclipse.ui.part.IShowInTargetList
import org.eclipse.ui.part.ShowInContext
import org.eclipse.xtext.ui.editor.XtextEditor
import org.eclipse.xtext.ui.generator.IDerivedResourceMarkers

/** 
 * The RuleEngineEditorEx class implements:
 * - the IShowInTargetList interface to provide the list of views that
 * 		should occur in the 'Show In' context menu of the Rule Engine Editor.
 * - the IShowInSource interface to customize the context that will be transfered
 * 		to the Show In Target View.
 */
class RuleEngineEditorEx extends RuleEngineEditor implements IShowInSource, IShowInTargetList {
	
	@Inject extension IDerivedResourceMarkers 

	override getShowInContext() {
		val dotFile = generatedDotFile
		if (dotFile !== null) {
			val input = dotFile.location.toFile
			val selection = null
			return new ShowInContext(input, selection)
		}
		// return the ShowInContext calculated on the usual way
		return getContext(this)
	}

	override String[] getShowInTargetIds() {
		val dotFile = generatedDotFile
		if (dotFile !== null) #["org.eclipse.gef.dot.internal.ui.DotGraphView"] else #[]
	}

	private def getGeneratedDotFile() {
		val storage = getStorage(this)
		val root = ResourcesPlugin.workspace.root
		val uri = URI.createPlatformResourceURI(storage.getFullPath().toString(), true)
		var List<IFile> generatedResources = null
		try {
			generatedResources = root.findDerivedResources(uri.toString)
		} catch (CoreException e) {
			e.printStackTrace
			return null
		}

		generatedResources.findFirst[fileExtension == "dot"]
	}

	private def IStorage getStorage(IEditorPart editor) {
		try {
			val editorInput = editor.editorInput
			if (editorInput instanceof IStorageEditorInput){
				return editorInput.storage
			}
			return null
		} catch (CoreException e) {
			return null
		}
	}

	// use the input of the Xtext editor
	private def getContext(XtextEditor xtextEditor) {
		var input = xtextEditor.editorInput
		var selectionProvider = xtextEditor.site.selectionProvider
		var ISelection selection = if(selectionProvider === null) null else selectionProvider.selection
		new ShowInContext(input, selection)
	}
}
