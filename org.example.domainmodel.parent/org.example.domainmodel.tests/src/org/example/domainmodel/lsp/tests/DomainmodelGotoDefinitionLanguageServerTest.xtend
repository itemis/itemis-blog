package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Goto Definition language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition
 */
class DomainmodelGotoDefinitionLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testDefinition[
			model = '''
				datatype DataType
				entity Entity {
					f : DataType
				}
			'''
			line = 2
			column = 6
			expectedDefinitions = '''
				MyModel.dmodel [[0, 9] .. [0, 17]]
			'''
		]
	}

	@Test def test002() {
		testDefinition[
			model = '''
				entity Entity1 {}
				entity Entity2 extends Entity1 {}
			'''
			line = 1
			column = 27
			expectedDefinitions = '''
				MyModel.dmodel [[0, 7] .. [0, 14]]
			'''
		]
	}

	@Test def test003() {
		testDefinition[
			filesInScope = #{
				('MyModel2.' + fileExtension) -> '''
					datatype DataType
				'''
			}
			model = '''
				entity Entity {
					f : DataType
				}
			'''
			line = 1
			column = 6
			expectedDefinitions = '''
				MyModel2.dmodel [[0, 9] .. [0, 17]]
			'''
		]
	}
}