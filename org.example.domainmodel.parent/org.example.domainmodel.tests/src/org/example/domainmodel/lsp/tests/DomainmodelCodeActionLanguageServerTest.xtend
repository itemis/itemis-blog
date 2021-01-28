package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Code Action language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_codeAction
 */
class DomainmodelCodeActionLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testCodeAction [
			model = '''
				entity MyEntity {}
			'''
			expectedCodeActions = ''''''
		]
	}

	@Test def test002() {
		testCodeAction [
			model = '''
				entity myEntity {}
			'''
			expectedCodeActions = '''
				title : Change entity name to first upper
				kind : quickfix
				command : 
				codes : invalidName
				edit : changes :
				    MyModel.dmodel : MyEntity [[0, 7] .. [0, 15]]
				documentChanges : 
			'''
		]
	}

}