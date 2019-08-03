package org.eclipse.xtext.example.fowlerdsl.ui.internal

import org.eclipse.xtext.example.fowlerdsl.EmfStatemachineRuntimeModule
import org.eclipse.xtext.example.fowlerdsl.LanguageConstants
import org.eclipse.xtext.example.fowlerdsl.ui.EmfStatemachineUiModule

class FowlerdslActivatorEx extends FowlerdslActivator {

	override getRuntimeModule(String grammar) {
		if (grammar.isEMFStatemachineLanguage) {
			return new EmfStatemachineRuntimeModule
		}
		super.getRuntimeModule(grammar)
	}

	override getUiModule(String grammar) {
		if (grammar.isEMFStatemachineLanguage) {
			return new EmfStatemachineUiModule(this)
		}
		super.getUiModule(grammar)
	}

	private def isEMFStatemachineLanguage(String grammar){
		LanguageConstants.ORG_ECLIPSE_XTEXT_EXAMPLE_FOWLERDSL_EMFSTATEMACHINE.equals(grammar)
	}
}