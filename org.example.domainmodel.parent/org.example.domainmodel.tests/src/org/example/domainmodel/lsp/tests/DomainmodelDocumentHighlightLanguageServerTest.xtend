package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Document Highlight language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_documentHighlight
 */
class DomainmodelDocumentHighlightLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testDocumentHighlight[
			model = '''
				datatype DataType
				entity Entity {
					f : DataType
				}
			'''
			column = 12
			// R : Read-access of a symbol, like reading a variable.
			// W : Write-access of a symbol, like writing to a variable.
			expectedDocumentHighlight = '''W [[0, 9] .. [0, 17]] | R [[2, 5] .. [2, 13]]'''
		]
	}

	@Test def test002() {
		testDocumentHighlight[
			model = '''
				datatype DataType
				entity Entity {
					f : DataType
				}
			'''
			line = 2
			column = 10
			expectedDocumentHighlight = '''W [[0, 9] .. [0, 17]] | R [[2, 5] .. [2, 13]]'''
		]
	}

	@Test def test003() {
		testDocumentHighlight[
			model = '''
				datatype DataType
				entity Entity {
					f1 : DataType
					f2 : DataType
				}
			'''
			column = 12
			expectedDocumentHighlight = '''W [[0, 9] .. [0, 17]] | R [[2, 6] .. [2, 14]] | R [[3, 6] .. [3, 14]]'''
		]
	}

	@Test def test004() {
		testDocumentHighlight[
			model = '''
				entity Entity1 {}
				entity Entity2 extends Entity1 {}
			'''
			line = 0
			column = 8
			expectedDocumentHighlight = '''W [[0, 7] .. [0, 14]] | R [[1, 23] .. [1, 30]]'''
		]
	}

	@Test def test005() {
		testDocumentHighlight[
			model = '''
				entity Entity1 {}
				entity Entity2 extends Entity1 {}
			'''
			line = 1
			column = 25
			expectedDocumentHighlight = '''W [[0, 7] .. [0, 14]] | R [[1, 23] .. [1, 30]]'''
		]
	}
}