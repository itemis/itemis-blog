/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel

import com.google.inject.Guice
import com.google.inject.Inject
import org.eclipse.xtext.ISetup
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.resource.IResourceServiceProvider

/**
 * This class is needed for standalone runtime tests.
 */
class UMLStandaloneSetup implements ISetup {

	@Inject extension FileExtensionProvider 
	@Inject extension IResourceServiceProvider.Registry
	@Inject IResourceServiceProvider resourceServiceProvider

	override createInjectorAndDoEMFRegistration() {
		val injector = Guice.createInjector(new UMLRuntimeModule)
		
		injector.injectMembers(this)
		
		fileExtensions.forEach[extensionToFactoryMap.put(it, resourceServiceProvider)]
		
		injector
	}

}
