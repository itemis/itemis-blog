/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractQuickfixTest
import org.junit.Test
import org.junit.runner.RunWith

import static org.eclipse.xtext.diagnostics.Diagnostic.LINKING_DIAGNOSTIC

@RunWith(XtextRunner)
@InjectWith(DomainmodelUiInjectorProvider)
class DomainmodelQuickfixTest extends AbstractQuickfixTest {

	@Test def fix_invalid_entity_superType() {
		'''
			entity Blog {}
			entity HasAuthor {}
			entity Post extends Foo {}
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			new Quickfix("Change to 'Blog'", "Change to 'Blog'", '''
				entity Blog {}
				entity HasAuthor {}
				entity Post extends Blog {}
			'''),
			new Quickfix("Change to 'HasAuthor'", "Change to 'HasAuthor'", '''
				entity Blog {}
				entity HasAuthor {}
				entity Post extends HasAuthor {}
			'''),
			new Quickfix("Change to 'Post'", "Change to 'Post'", '''
				entity Blog {}
				entity HasAuthor {}
				entity Post extends Post {}
			''')
		)
	}

	@Test def fix_invalid_feature_type() {
		'''
			datatype String
			
			entity Blog {
				title: Foo
			}
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			new Quickfix("Change to 'title'", "Change to 'title'", '''
				datatype String
				
				entity Blog {
					title: title
				}
			'''),
			new Quickfix("Change to 'String'", "Change to 'String'", '''
				datatype String
				
				entity Blog {
					title: String
				}
			'''),
			new Quickfix("Change to 'Blog'", "Change to 'Blog'", '''
				datatype String
				
				entity Blog {
					title: Blog
				}
			''')
		)
	}
}
