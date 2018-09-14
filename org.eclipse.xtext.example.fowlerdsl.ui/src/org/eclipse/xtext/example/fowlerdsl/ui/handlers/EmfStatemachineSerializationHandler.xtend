package org.eclipse.xtext.example.fowlerdsl.ui.handlers

import com.google.inject.Inject
import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IResource
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.ui.resource.IResourceSetProvider

import static extension org.eclipse.emf.common.util.URI.createPlatformResourceURI
import static extension org.eclipse.ui.handlers.HandlerUtil.getCurrentSelection

class EmfStatemachineSerializationHandler extends AbstractHandler {

	@Inject extension IResourceSetProvider
	@Inject extension FileExtensionProvider

	override execute(ExecutionEvent event) {
		val selection = event.getCurrentSelection
		
		val emfFile = (selection as IStructuredSelection).firstElement as IFile
		val project = emfFile.project
		val resourceSet = project.get
		
		val emfFileFullPath = emfFile.fullPath.toString
		val emfUri = emfFileFullPath.createPlatformResourceURI(true)
		val emfResource = resourceSet.getResource(emfUri, true)
		val emfRoot = emfResource.contents.head
		
		val xtextFileFullPath = emfFile.parent.fullPath + "/" + emfFile.name.replace(".emfstatemachine", '''.«primaryFileExtension»''') 
		val xtextUri = xtextFileFullPath.createPlatformResourceURI(true)
		val xtextResource = resourceSet.createResource(xtextUri)
		//val xtextRoot = EcoreUtil.copy(emfRoot)
		val xtextRoot = emfRoot
		xtextResource.contents += xtextRoot
		
		xtextResource.save(newHashMap)
		
		// refresh the IDE to make the new file visible
		project.refreshLocal(IResource.DEPTH_INFINITE, null)
		
		null
	}

}
