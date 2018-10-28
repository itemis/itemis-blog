/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel

import org.eclipse.xtext.resource.generic.AbstractGenericResourceRuntimeModule

/**
 * This class is used to configure the runtime dependency injection (DI) container for the UML language.
 */
class UMLRuntimeModule extends AbstractGenericResourceRuntimeModule {

	override protected getFileExtensions() {
		'uml'
	}

	override protected getLanguageName() {
		UMLLanguageConstants.ORG_ECLIPSE_UML2_UML
	}

	override bindIQualifiedNameProvider() {
		UMLQualifiedNameProvider
	}
}
