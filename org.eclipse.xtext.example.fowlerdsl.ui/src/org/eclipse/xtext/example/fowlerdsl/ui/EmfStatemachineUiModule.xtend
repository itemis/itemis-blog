package org.eclipse.xtext.example.fowlerdsl.ui

import com.google.inject.Binder
import org.eclipse.ui.plugin.AbstractUIPlugin
import org.eclipse.xtext.example.fowlerdsl.ui.editor.EmfStatemachineReflectiveTreeEditorOpener
import org.eclipse.xtext.ui.LanguageSpecific
import org.eclipse.xtext.ui.editor.IURIEditorOpener
import org.eclipse.xtext.ui.resource.generic.EmfUiModule

/**
 * This class is the DI config for all Eclipse-based services.
 */
class EmfStatemachineUiModule extends EmfUiModule {

	new(AbstractUIPlugin plugin) {
		super(plugin)
	}

	/*
	 * This binding adds an editor opener that opens the EMF (reflective) tree editor when the user
	 * follows a reference to an XMI-defined statemachine element in the Xtext editor.
	 */
	override configureLanguageSpecificURIEditorOpener(Binder binder) {
		binder.bind(IURIEditorOpener).annotatedWith(LanguageSpecific).to(EmfStatemachineReflectiveTreeEditorOpener)
	}
}