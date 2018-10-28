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
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScopeProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.example.domainmodel.domainmodel.Domainmodel
import org.example.domainmodel.tests.utils.UMLResourceSetHelper
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

import static org.example.domainmodel.domainmodel.DomainmodelPackage.Literals.*

import static extension org.junit.Assert.assertEquals

/**
 * Scoping deals with cross-references: references in EMF with the boolean attribute containment set to false.
 */
@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelScopingTest {

	@Inject extension ParseHelper<Domainmodel>
	@Inject extension IScopeProvider
	@Inject extension UMLResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def visible_elements_for_entity_feature_type() {
		'''
			datatype String
			entity UML {
				a : String
			}
		'''.parse.assertVisibleElements(FEATURE__TYPE, '''
			String
			UML
			UML.a
		''')
	}

	@Test def visible_elements_for_entity_feature_type_external_resource() {
		'''
			datatype String
			entity UML {
				a : String
			}
		'''.parse(resourceSet).assertVisibleElements(FEATURE__TYPE, '''
			String
			UML
			UML.a
			test
			test.A
			test.B
		''')
	}

	private def assertVisibleElements(EObject context, EReference reference, String expected) {
		val actual = context.getScope(reference).allElements.map[name].join(System.lineSeparator)
		expected.trim.assertEquals(actual)
	}
}
