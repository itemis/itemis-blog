/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui.editor

import org.eclipse.xtext.ui.editor.LanguageSpecificURIEditorOpener
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.presentation.EcoreEditor
import org.eclipse.ui.IEditorPart

/*
 * This class is an editor opener that opens the EMF reflective tree editor when the user
 * follows a reference to an XMI-defined UML element in the Domainmodel Xtext editor.
 */
class ReflectiveTreeEditorOpener extends LanguageSpecificURIEditorOpener {

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
