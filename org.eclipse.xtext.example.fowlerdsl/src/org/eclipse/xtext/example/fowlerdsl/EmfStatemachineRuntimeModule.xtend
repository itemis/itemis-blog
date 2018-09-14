package org.eclipse.xtext.example.fowlerdsl

import org.eclipse.xtext.example.fowlerdsl.generator.EmfStatemachineSerializer
import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.resource.generic.AbstractGenericResourceRuntimeModule

/**
 * This class is used to configure the runtime dependency injection (DI) container for the EMF State-Machine language.
 */
class EmfStatemachineRuntimeModule extends AbstractGenericResourceRuntimeModule {

	override protected getFileExtensions() {
		'emfstatemachine'
	}

	override protected getLanguageName() {
		LanguageConstants.ORG_ECLIPSE_XTEXT_EXAMPLE_FOWLERDSL_EMFSTATEMACHINE
	}

	def Class<? extends IGenerator2> bindIGenerator() {
		EmfStatemachineSerializer
	}
}