package org.eclipse.xtext.example.fowlerdsl.ui

import org.eclipse.xtext.example.fowlerdsl.LanguageConstants
import org.eclipse.xtext.example.fowlerdsl.ui.internal.FowlerdslActivatorEx
import org.eclipse.xtext.ui.guice.AbstractGuiceAwareExecutableExtensionFactory

class EmfStatemachineExecutableExtensionFactory extends AbstractGuiceAwareExecutableExtensionFactory {

	override protected getBundle() {
		FowlerdslActivatorEx.instance.bundle
	}

	override protected getInjector() {
		FowlerdslActivatorEx.instance.getInjector(LanguageConstants.ORG_ECLIPSE_XTEXT_EXAMPLE_FOWLERDSL_EMFSTATEMACHINE)
	}

}