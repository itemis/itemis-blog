package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Find References language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_references
 */
class DomainmodelFindReferencesLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testReferences[
			model = '''
				datatype DataType
				entity Entity {
					f : DataType
				}
			'''
			column = 12
			expectedReferences = '''
				MyModel.dmodel [[2, 5] .. [2, 13]]
			'''
		]
	}

	@Test def test002() {
		testReferences[
			model = '''
				datatype DataType
				entity Entity {
					f1 : DataType
					f2 : DataType
				}
			'''
			column = 12
			expectedReferences = '''
				MyModel.dmodel [[2, 6] .. [2, 14]]
				MyModel.dmodel [[3, 6] .. [3, 14]]
			'''
		]
	}
}