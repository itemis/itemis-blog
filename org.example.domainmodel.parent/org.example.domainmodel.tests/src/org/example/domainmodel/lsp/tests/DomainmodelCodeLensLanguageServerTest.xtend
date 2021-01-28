package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Code Lens language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_codeLens
 */
class DomainmodelCodeLensLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testCodeLens [
			model = '''
				entity MyEntity {}
			'''
			expectedCodeLensItems = '''
				0 features [[0, 0] .. [0, 10]]
			'''
		]
	}

	@Test def test002() {
		testCodeLens [
			model = '''
				entity MyEntity1 {}
				entity MyEntity2 {}
			'''
			expectedCodeLensItems = '''
				0 features [[0, 0] .. [0, 10]]
				0 features [[1, 0] .. [1, 10]]
			'''
		]
	}

	@Test def test003() {
		testCodeLens [
			model = '''
				datatype d
				
				entity MyEntity {
					f : d
				}
			'''
			expectedCodeLensItems = '''
				1 feature [[2, 0] .. [2, 9]]
			'''
		]
	}

	@Test def test004() {
		testCodeLens [
			model = '''
				datatype d1
				datatype d2
				
				entity MyEntity {
					f : d1
					f : d2
				}
			'''
			expectedCodeLensItems = '''
				2 features [[3, 0] .. [3, 10]]
			'''
		]
	}
}