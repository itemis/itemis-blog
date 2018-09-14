package org.eclipse.xtext.example.fowlerdsl.ui.editor

import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.presentation.EcoreEditor
import org.eclipse.ui.IEditorPart
import org.eclipse.xtext.ui.editor.LanguageSpecificURIEditorOpener

/*
 * This class is an editor opener that opens the EMF reflective tree editor when the user
 * follows a reference to an XMI-defined statemachine element in the Xtext editor.
 */
class EmfStatemachineReflectiveTreeEditorOpener extends LanguageSpecificURIEditorOpener {

	override protected void selectAndReveal( IEditorPart openEditor, URI uri,
		EReference crossReference, int indexInList, boolean select) {
		if (uri.fragment !== null) {
			if (openEditor instanceof EcoreEditor) {
				val eObject = openEditor.editingDomain.resourceSet.getEObject(uri, true)
				openEditor.setSelectionToViewer(#[eObject])
			}
		}
	}

	override protected String getEditorId() {
		return "org.eclipse.emf.ecore.presentation.ReflectiveEditorID"
	}
}
