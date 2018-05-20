# Implementing JUnit Test Cases in Xtend

> What makes a clean test? Three things. Readability, readability, and readability. Readability is perhaps even more important in unit tests than it is in production code. What makes tests readable? The same thing that makes all code readable: clarity, simplicity, and density of expression.<sup>1</sup>

Recently, the [Eclipse GEF DOT Editor](http://blogs.itemis.com/en/editing-graphviz-.dot-files-with-the-gef-dot-editor) has been extended by the [Rename Refactoring](http://www.eclipse.org/Xtext/documentation/310_eclipse_support.html#refactoring) functionality. Following the Behaviour-Driven Development approach, the acceptance criteria have been specified first:
```Gherkin
Feature: Rename Refactoring

  Scenario Outline:
    Given is the <dslFile>
    When renaming the <targetElement> to <newName>
    Then the dsl file has the content <newContent>.

    Examples:
      |  dslFile  |   targetElement   | newName | newContent |
      |-----------|-------------------|---------|------------|
      |  graph {  |                   |         |  graph {   |
      |    1      |     firstNode     |    2    |    2       |
      |  }        |                   |         |  }         |
      |           |                   |         |            |
      | digraph { |                   |         | digraph {  |
      |   1       |     firstNode     |    3    |   3        |
      |   1->2    |                   |         |   3->2     |
      | }         |                   |         | }          |
      |           |                   |         |            |
      | digraph { |                   |         | digraph {  |
      |   1       |    source node    |    3    |   3        |
      |   1->2    | of the first edge |         |   3->2     |
      | }         |                   |         | }          |
      |           |                   |         |            |
```

Thereafter, the test specification has been implemented in JUnit test cases:
```Xtend
class DotRenameRefactoringTests extends AbstractEditorTest {

	// ...

	@Test def testRenameRefactoring01() {
		'''
			graph {
				1
			}
		'''.
		testRenameRefactoring([firstNode], "2", '''
			graph {
				2
			}
		''')
	}

	@Test def testRenameRefactoring02() {
		'''
			digraph {
				1
				1->2
			}
		'''.
		testRenameRefactoring([firstNode], "3", '''
			digraph {
				3
				3->2
			}
		''')
	}

	@Test def testRenameRefactoring03() {
		'''
			digraph {
				1
				1->2
			}
		'''.
		testRenameRefactoring([sourceNodeOfFirstEdge], "3", '''
			digraph {
				3
				3->2
			}
		''')
	}

	// ...

	private def testRenameRefactoring(CharSequence it,
		(DotAst)=>NodeId element, String newName,
		CharSequence newContent) {
		// given
		dslFile.
		// when
		rename(target(element), newName).
		// then
		dslFileHasContent(newContent)
	}

	// ...

}
```
Thanks to the [Xtend](http://www.eclipse.org/xtend/) programming language, the entire [DotRenameRefactoringTests](http://github.com/eclipse/gef/blob/master/org.eclipse.gef.dot.tests/src/org/eclipse/gef/dot/tests/DotRenameRefactoringTests.xtend) test suite became readable, clean, and scales very well.
> How did I do this? I did not simply write this program from beginning to end in its current form. To write clean code, you must first write dirty code and then clean it.<sup>2</sup>

Would you like to learn more about Clean Code, Behaviour-Driven and Test-Driven Development?
Take a look at the blog posts of my colleague [Christian Fischer](http://blogs.itemis.com/author/christian-fischer), who is a very passionate software craftsman and agile coach at itemis.

<hr>
<sup>1</sup> Robert C. Martin: Clean Code - A Handbook of Agile Software Craftsmanship (page 124)<br>
<sup>2</sup> Robert C. Martin: Clean Code - A Handbook of Agile Software Craftsmanship (page 200)
