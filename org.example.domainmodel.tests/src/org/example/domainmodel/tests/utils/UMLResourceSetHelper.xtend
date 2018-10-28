/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.tests.utils

import com.google.inject.Inject
import com.google.inject.Provider
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import org.eclipse.uml2.uml.Package
import org.eclipse.uml2.uml.UMLFactory
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.testing.InjectWith
import org.example.domainmodel.UMLStandaloneSetup
import org.example.domainmodel.tests.DomainmodelInjectorProvider

@InjectWith(DomainmodelInjectorProvider)
class UMLResourceSetHelper {

	@Inject extension Provider<XtextResourceSet>
	extension UMLFactory = UMLFactory.eINSTANCE

	ResourceSet resourceSet
	Package umlPackage

	def void initializeResourceSet() {
		new UMLStandaloneSetup().createInjectorAndDoEMFRegistration
		
		resourceSet = get
		
		// register factories
		val resourceFactoryRegistry = resourceSet.resourceFactoryRegistry
		resourceFactoryRegistry.extensionToFactoryMap.put("uml", new XMIResourceFactoryImpl)
		
		createUMLPackage(URI.createURI("My.uml"))
	}

	def initializeResourceSet(String projectFullPath) {
		resourceSet = get
		
		createUMLPackage(URI.createPlatformResourceURI(projectFullPath + "/my.uml", true))
		
		resourceSet.resources.forEach[save(newHashMap)]
	}

	def resourceSet() {
		resourceSet
	}

	// UML package
	def umlPackage() { umlPackage }

	// UML classes
	def a() { umlPackage.packagedElements.get(0) }
	def b() { umlPackage.packagedElements.get(1) }

	private def createUMLPackage(URI uri) {
		umlPackage = createPackage => [
			name = 'test'
			packagedElements += createClass => [name='A']
			packagedElements += createClass => [name='B']
		]
		
		resourceSet.createResource(uri).contents += umlPackage
	}
}
