package org.example.domainmodel.lsp.tests

import java.util.List
import org.eclipse.lsp4j.Diagnostic
import org.eclipse.lsp4j.DiagnosticSeverity
import org.eclipse.xtext.testing.AbstractLanguageServerTest
import org.example.domainmodel.validation.DomainmodelValidator
import org.junit.Test

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertTrue

/**
 * Test cases for the LSP Diagnostic language feature.
 * 
 * https://microsoft.github.io/language-server-protocol/specifications/specification-current/#diagnostic
 */
class DomainmodelDiagnosticLanguageServerTest extends AbstractLanguageServerTest {

	new() {
		super("dmodel")
	}

	@Test def test_valid_model() {
		val problems = '''
			entity MyEntity {}
		'''.problems

		assertEquals(0, problems.size)
	}

	@Test def test_invalid_model() {
		val problems = '''
			entity myEntity {}
		'''.problems

		assertEquals(1, problems.size)

		val problem = problems.head
		assertEquals("Name should start with a capital", problem.message)
		assertEquals(DomainmodelValidator.INVALID_NAME, problem.code.get)

		val range = problem.range
		val start = range.start
		val end = range.end
		assertEquals(0, start.line)
		assertEquals(7, start.character)
		assertEquals(0, end.line)
		assertEquals(15, end.character)

		assertEquals(DiagnosticSeverity.Warning, problem.severity)
	}

	private def List<Diagnostic> problems(CharSequence text) {
		val fileName = "test.dmodel"
		fileName.writeFile(text)
		initialize
		val diagnostic = diagnostics.entrySet.head
		val uri = diagnostic.key
		assertTrue(uri.endsWith(fileName))
		diagnostic.value
	}

}