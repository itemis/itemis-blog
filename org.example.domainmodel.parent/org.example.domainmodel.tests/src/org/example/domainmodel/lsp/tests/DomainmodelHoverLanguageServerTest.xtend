package org.example.domainmodel.lsp.tests

import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Test

/**
 * Test cases for the LSP Hover language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_hover
 */
class DomainmodelHoverLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		testHover[
			model = '''
				/**
				 * Some documentation.
				 */
				entity Foo {
				}
			'''
			line = 3
			column = 8
			expectedHover = '''
ллл				[start[line, character]	end[line, character]] that is used to visualize a hover, e.g. by changing the background color.
				[[3, 7] .. [3, 10]]
				kind: markdown
				value: Entity **Foo**  
				Some documentation.
			'''
		]
	}

	@Test def test002() {
		testHover[
			model = '''
				/**
				 * Documentation of the Datatype.
				 */
				datatype DataType
				entity Entity {
					f : DataType
				}
			'''
			line = 5
			column = 6
			expectedHover = '''
				[[5, 5] .. [5, 13]]
				kind: markdown
				value: DataType **DataType**  
				Documentation of the Datatype.
			'''
		]
	}

	@Test def test003() {
		testHover[
			filesInScope = #{
				('MyModel2.' + fileExtension) -> '''
				/**
				 * Documentation of the Datatype.
				 */
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
			expectedHover = '''
				[[1, 5] .. [1, 13]]
				kind: markdown
				value: DataType **DataType**  
				Documentation of the Datatype.
			'''
		]
	}
}