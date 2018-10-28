/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui

import com.google.inject.Binder
import org.eclipse.ui.plugin.AbstractUIPlugin
import org.eclipse.xtext.ui.LanguageSpecific
import org.eclipse.xtext.ui.editor.IURIEditorOpener
import org.eclipse.xtext.ui.resource.generic.EmfUiModule
import org.example.domainmodel.ui.editor.ReflectiveTreeEditorOpener

/**
 * This class is the DI config for all Eclipse-based services.
 */
class UMLUiModule extends EmfUiModule {

	new(AbstractUIPlugin plugin) {
		super(plugin)
	}

	/*
	 * This binding adds an editor opener that opens the EMF (reflective) tree editor when the user
	 * follows a reference to an XMI-defined UML element in the Domainmodel Xtext editor.
	 */
	override configureLanguageSpecificURIEditorOpener(Binder binder) {
		binder.bind(IURIEditorOpener).annotatedWith(LanguageSpecific).to(ReflectiveTreeEditorOpener)
	}
}
