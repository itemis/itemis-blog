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
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.example.domainmodel.domainmodel.Domainmodel
import org.example.domainmodel.domainmodel.Entity
import org.example.domainmodel.tests.utils.UMLResourceSetHelper
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

import static extension org.junit.Assert.assertEquals

/**
 * The actual cross-reference resolution (the linking) is performed by the LinkingService.
 * Usually, you do not need to customize the linking service, since the default implementation
 * relies on IScopeProvider, which is the component you would customize instead.
 * You can think of a scope as a symbol table, where keys are the names and the values are instances of IEObjectDescription.
 *
 * Both scopes and the index deal with object descriptions.
 * The crucial difference is that a scope also specifies the actual string with which you can refer to an object.
 * The actual string does not have to be equal to the object description's qualified name in the index.
 * Thus, the same object can be referred to with different strings in different program contexts.
 *
 * The index provides all the qualified names of the visible objects of a resource so that all these objects
 * can be referred to using their qualified names. The scope provides further information, that is, in a given program context,
 * some objects can be referred to even using simple names or using qualified names with less segments.
 */
@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelLinkingTest {

	@Inject extension ParseHelper<Domainmodel>
	@Inject extension UMLResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def linking_feature_type_definition_to_a_UML_class_1() {
		'''
			entity UML {
				a : test.A
			}
		'''.firstFeatureTypeIsLinkedTo(a)
	}

	@Test def linking_feature_type_definition_to_a_UML_class_2() {
		'''
			entity UML {
				b : test.B
			}
		'''.firstFeatureTypeIsLinkedTo(b)
	}

	@Test def void linking_feature_type_definition_to_a_UML_class_3() {
		'''
			entity UML {
				a : test.A
				b : test.B
			}
		''' => [
			firstFeatureTypeIsLinkedTo(a)
			secondFeatureTypeIsLinkedTo(b)
		]
	}

	private def firstFeatureTypeIsLinkedTo(CharSequence it, EObject expected) {
		val actual = parse(resourceSet).firstEntity.firstFeatureType
		expected.assertEquals(actual)
	}

	private def secondFeatureTypeIsLinkedTo(CharSequence it, EObject expected) {
		val actual = parse(resourceSet).firstEntity.secondFeatureType
		expected.assertEquals(actual)
	}

	private def firstEntity(Domainmodel it) {
		elements.filter(Entity).head
	}

	private def firstFeatureType(Entity it) {
		features.head.type
	}

	private def secondFeatureType(Entity it) {
		features.get(1).type
	}
}
