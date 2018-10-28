/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui.tests

import java.util.List
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractContentAssistTest
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(DomainmodelUiInjectorProvider)
class DomainmodelContentAssistTest extends AbstractContentAssistTest {

	// cursor position marker
	val c = '''<|>'''

	@Test def empty() {
		'''
			«c»
		'''.testContentAssistant(#[
			'datatype',
			'entity'
		], 'datatype', '''
			datatype
		''')
	}

	@Test def datatype_name() {
		'''
			datatype «c»
		'''.testContentAssistant(#[
			'Name'
		], 'Name', '''
			datatype Name
		''')
	}

	@Test def entity_name() {
		'''
			entity «c»
		'''.testContentAssistant(#[
			'Name'
		], 'Name', '''
			entity Name
		''')
	}

	@Test def entity_superType() {
		'''
			entity HasAuthor {
			}
			
			entity Post extends «c»
		'''.testContentAssistant(#[
			'HasAuthor',
			'Post'
		], 'HasAuthor', '''
			entity HasAuthor {
			}
			
			entity Post extends HasAuthor
		''')
	}

	@Test def feature_name() {
		'''
			entity Blog {
				«c»
			}
		'''.testContentAssistant(#[
			'Blog',
			'Name',
			'many',
			'}'
		], 'Name', '''
			entity Blog {
				Name
			}
		''')
	}

	@Test def feature_many() {
		'''
			datatype String
			
			entity Blog {
				title: String
				«c»
			}
		'''.testContentAssistant(#[
			'Blog',
			'Name',
			'String',
			'many',
			'title',
			'}'
		], 'many', '''
			datatype String
			
			entity Blog {
				title: String
				many
			}
		''')
	}

	@Test def feature_type() {
		'''
			datatype String
			
			entity Blog {
				title: «c»
			}
		'''.testContentAssistant(#[
			'Blog',
			'String',
			'title'
		], 'String', '''
			datatype String
			
			entity Blog {
				title: String
			}
		''')
	}

	private def void testContentAssistant(CharSequence text, List<String> expectedProposals,
		String proposalToApply, String expectedContent) {
		
		val cursorPosition = text.toString.indexOf(c)
		val content = text.toString.replace(c, "")
		
		newBuilder.append(content).
		assertTextAtCursorPosition(cursorPosition, expectedProposals).
		applyProposal(cursorPosition, proposalToApply).
		expectContent(expectedContent)
	}
}
