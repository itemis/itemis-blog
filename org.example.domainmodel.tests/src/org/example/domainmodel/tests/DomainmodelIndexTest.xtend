/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.tests

import com.google.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.resource.IResourceDescription
import org.eclipse.xtext.resource.impl.ResourceDescriptionsProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.example.domainmodel.tests.utils.UMLResourceSetHelper
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

import static extension org.junit.Assert.assertEquals

/**
 * The index stores information (IEobjectDescription objects) about all the objects in every resource.
 * This is the base for cross-reference resolution.
 *
 * The set of resources handled by the index depends on the context of the execution:
 *		- In the IDE, Xtext indexes all the resources in all Xtext projects. The index is kept up-to-date using the incremental building mechanism of Eclipse.
 *		- In a plain runtime context (where there is no workspace), the index is based on the EMF ResourceSet.
 *		- In both context, the index is global. Visibility across resources is handled by containers.
 *
 * The index is implemented by IResourceDescriptions and can be obtained through the injected ResourceDescriptionsProvider using the getResourceDescriptions(Resource) method.
 * The indexed object descriptions of a resource are stored in IResourceDescription, which is an abstract description of a resource.
 * We get the list of all the IEObjectDescription elements of a resource that are externally visible (globally exported) using the getExportedObject() method.
 */
@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelIndexTest {

	@Inject extension ResourceDescriptionsProvider
	@Inject extension UMLResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def uml_elements_in_external_resource() {
		umlPackage.assertExportedEObjectDescriptions('''
			test
			test.A
			test.B
		''')
	}

	private def assertExportedEObjectDescriptions(EObject it, String qualifiedNames) {
		#[index.getResourceDescription(eResource.URI)].assertVisibleQualifiedNames(qualifiedNames)
	}

	private def index(EObject it) {
		eResource.getResourceDescriptions
	}

	private def assertVisibleQualifiedNames(Iterable<IResourceDescription> it, String expected) {
		val actual = map[exportedObjects].flatten.map[qualifiedName].join(System.lineSeparator)
		expected.trim.assertEquals(actual)
	}
}
