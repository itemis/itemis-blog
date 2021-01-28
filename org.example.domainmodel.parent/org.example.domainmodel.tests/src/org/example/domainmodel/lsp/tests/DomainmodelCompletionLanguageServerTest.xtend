package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Completion language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_completion
 */
class DomainmodelCompletionLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testCompletion [
			model = ''
			expectedCompletionItems = '''
ллл				label	->	newText		[start[line, character]		end[line, character]]
				datatype -> datatype [[0, 0] .. [0, 0]]
				entity -> entity [[0, 0] .. [0, 0]]
				datatype template -> datatype ${1:name}
				 [[0, 0] .. [0, 0]]
				entity template -> entity ${1:name} {
				    
				}
				 [[0, 0] .. [0, 0]]
			'''
		]
	}

	@Test def test002() {
		testCompletion [
			model = 'entity E {'
			column = 10
			expectedCompletionItems = '''
				name (ID) -> name [[0, 10] .. [0, 10]]
				many -> many [[0, 10] .. [0, 10]]
				} -> } [[0, 10] .. [0, 10]]
				{ -> { [[0, 9] .. [0, 10]]
			'''
		]
	}

	@Test def test003() {
		testCompletion [
			model = '''
				entity A {}
				entity B extends 
			'''
			line = 1
			column = 17
			expectedCompletionItems = '''
				A (Entity) -> A [[1, 17] .. [1, 17]]
				B (Entity) -> B [[1, 17] .. [1, 17]]
			'''
		]
	}

	@Test def test004() {
		testCompletion [
			model = '''
				datatype T
				entity A {
					f : 
				}
			'''
			line = 2
			column = 5
			expectedCompletionItems = '''
				A (Entity) -> A [[2, 5] .. [2, 5]]
				T (DataType) -> T [[2, 5] .. [2, 5]]
			'''
		]
	}
}