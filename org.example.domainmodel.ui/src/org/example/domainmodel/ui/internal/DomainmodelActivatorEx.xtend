package org.example.domainmodel.ui.internal

import org.example.domainmodel.UMLRuntimeModule
import org.example.domainmodel.UMLLanguageConstants
import org.example.domainmodel.ui.UMLUiModule

class DomainmodelActivatorEx extends DomainmodelActivator {

	override getRuntimeModule(String grammar) {
		if (grammar.isUMLLanguage) {
			return new UMLRuntimeModule
		}
		super.getRuntimeModule(grammar)
	}

	override getUiModule(String grammar) {
		if (grammar.isUMLLanguage) {
			return new UMLUiModule(this)
		}
		super.getUiModule(grammar)
	}

	private def isUMLLanguage(String grammar){
		UMLLanguageConstants.ORG_ECLIPSE_UML2_UML.equals(grammar)
	}

}
