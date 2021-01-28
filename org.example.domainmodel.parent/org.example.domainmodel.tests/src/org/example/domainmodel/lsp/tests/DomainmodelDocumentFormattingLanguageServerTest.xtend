package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Document Formatting language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_formatting
 */
class DomainmodelDocumentFormattingLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testFormatting [
			model = '''
				entity E {}
			'''
			expectedText = '''
				entity E {
				}
			'''
		]
	}

	@Test def test002() {
		testFormatting [
			model = '''
				datatype DataType
				entity E {f:DataType}
			'''
			expectedText = '''
				datatype DataType
				entity E {
					f : DataType
				}
			'''
		]
	}

}