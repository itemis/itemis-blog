package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Document Symbols language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_documentSymbol
 */
class DomainmodelDocumentSymbolsLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testDocumentSymbol[
			model = '''
				datatype DataType
				entity Entity {}
			'''
			expectedSymbols = '''
				symbol "DataType" {
ллл					See org.eclipse.lsp4j.SymbolKind
				    kind: 7
				    location: MyModel.dmodel [[0, 9] .. [0, 17]]
				}
				symbol "Entity" {
				    kind: 7
				    location: MyModel.dmodel [[1, 7] .. [1, 13]]
				}
			'''
		]
	}

	@Test def test002() {
		testDocumentSymbol[
			model = '''
				datatype DataType
				entity Entity1 {
					f : DataType
				}
				entity Entity2 extends Entity1 {
					f1 : DataType
					f2 : DataType
				}
			'''
			expectedSymbols = '''
				symbol "DataType" {
				    kind: 7
				    location: MyModel.dmodel [[0, 9] .. [0, 17]]
				}
				symbol "Entity1" {
				    kind: 7
				    location: MyModel.dmodel [[1, 7] .. [1, 14]]
				}
				symbol "Entity1.f" {
				    kind: 7
				    location: MyModel.dmodel [[2, 1] .. [2, 2]]
				    container: "Entity1"
				}
				symbol "Entity2" {
				    kind: 7
				    location: MyModel.dmodel [[4, 7] .. [4, 14]]
				}
				symbol "Entity2.f1" {
				    kind: 7
				    location: MyModel.dmodel [[5, 1] .. [5, 3]]
				    container: "Entity2"
				}
				symbol "Entity2.f2" {
				    kind: 7
				    location: MyModel.dmodel [[6, 1] .. [6, 3]]
				    container: "Entity2"
				}
			'''
		]
	}
}