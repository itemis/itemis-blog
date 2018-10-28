/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractQuickfixTest
import org.example.domainmodel.tests.utils.UMLResourceSetHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.eclipse.xtext.diagnostics.Diagnostic.LINKING_DIAGNOSTIC

@RunWith(XtextRunner)
@InjectWith(DomainmodelUiInjectorProvider)
class DomainmodelQuickfix2Test extends AbstractQuickfixTest {

	@Inject extension UMLResourceSetHelper

	override protected dslFile(CharSequence content) {
		val dslFile = super.dslFile(content)
		initializeResourceSet(dslFile.project.fullPath.toString)
		dslFile
	}

	@Test def fix_invalid_feature_type() {
		'''
			entity UML {
				a : Foo
			}
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			new Quickfix("Change to 'a'", "Change to 'a'", '''
				entity UML {
					a : a
				}
			'''),
			new Quickfix("Change to 'UML'", "Change to 'UML'", '''
				entity UML {
					a : UML
				}
			'''),
			new Quickfix("Change to 'test'", "Change to 'test'", '''
				entity UML {
					a : test
				}
			'''),
			new Quickfix("Change to 'test.A'", "Change to 'test.A'", '''
				entity UML {
					a : test.A
				}
			'''),
			new Quickfix("Change to 'test.B'", "Change to 'test.B'", '''
				entity UML {
					a : test.B
				}
			''')
		)
	}
}
