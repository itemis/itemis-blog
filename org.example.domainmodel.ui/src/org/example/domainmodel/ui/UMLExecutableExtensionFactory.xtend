/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui

import org.eclipse.xtext.ui.guice.AbstractGuiceAwareExecutableExtensionFactory
import org.example.domainmodel.ui.internal.DomainmodelActivatorEx
import org.example.domainmodel.UMLLanguageConstants

class UMLExecutableExtensionFactory extends AbstractGuiceAwareExecutableExtensionFactory {

	override protected getBundle() {
		DomainmodelActivatorEx.instance.bundle
	}

	override protected getInjector() {
		DomainmodelActivatorEx.instance.getInjector(UMLLanguageConstants.ORG_ECLIPSE_UML2_UML)
	}

}
