package org.example.domainmodel.lsp.tests

import org.eclipse.lsp4j.Position
import org.eclipse.lsp4j.RenameParams
import org.eclipse.lsp4j.TextDocumentIdentifier
import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.junit.Assert
import org.junit.Test

/**
 * Test cases for the LSP Rename language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_rename
 */
class DomainmodelRenameLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test001() {
		'''
			datatype DataType
			entity Entity {
				f : DataType
			}
		'''.testRename(0, 10, 'DataType2', '''
			changes :
				MyModel.dmodel : DataType2 [[0, 9] .. [0, 17]]
				DataType2 [[2, 5] .. [2, 13]]
			documentChanges : 
		''')
	}

	@Test def test002() {
		'''
			datatype DataType
			entity Entity {
				f : DataType
			}
		'''.testRename(2, 10, 'DataType2', '''
			changes :
				MyModel.dmodel : DataType2 [[0, 9] .. [0, 17]]
				DataType2 [[2, 5] .. [2, 13]]
			documentChanges : 
		''')
	}

	@Test def test003() {
		'''
			datatype DataType
			entity Entity {
				f1 : DataType
				f2 : DataType
			}
		'''.testRename(0, 10, 'DataType1', '''
			changes :
				MyModel.dmodel : DataType1 [[0, 9] .. [0, 17]]
				DataType1 [[2, 6] .. [2, 14]]
				DataType1 [[3, 6] .. [3, 14]]
			documentChanges : 
		''')
	}

	@Test def test004() {
		'''
			entity E1 {}
			entity E2 extends E1 {}
		'''.testRename(0, 8, 'Entity1', '''
			changes :
				MyModel.dmodel : Entity1 [[0, 7] .. [0, 9]]
				Entity1 [[1, 18] .. [1, 20]]
			documentChanges : 
		''')
	}

	@Test def test005() {
		'''
			entity E1 {}
			entity E2 extends E1 {}
		'''.testRename(1, 19, 'Entity1', '''
			changes :
				MyModel.dmodel : Entity1 [[0, 7] .. [0, 9]]
				Entity1 [[1, 18] .. [1, 20]]
			documentChanges : 
		''')
	}

	private def testRename(CharSequence model, int line, int column, String newName, CharSequence expectedWorkspaceEdit) {
		// Given
		val file = writeFile('MyModel.' + fileExtension, model)
		initialize
		
		// When
		val params = new RenameParams(new TextDocumentIdentifier(file), new Position(line, column), newName)
		val workspaceEdit = languageServer.rename(params).get
		
		// Then
		val actualWorkspaceEdit = workspaceEdit.toExpectation
		Assert.assertEquals(expectedWorkspaceEdit.toString, actualWorkspaceEdit.toString)
	}

}