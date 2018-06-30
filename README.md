# Eclipse GEF DOT - Graphical Views on Xtext DSLs

The previous [blog post](https://blogs.itemis.com/en/adding-gef-dot-based-visualization-support-to-the-eclipse-ide) introduced complex [Graphviz \*.dot](https://graphviz.gitlab.io/_pages/doc/info/lang.html) graphs to add Eclipse GEF DOT-based visualization support to the Eclipse IDE. This blog post demonstrates the usage of the GEF DOT Graph View to add graphical representations to Xtext DSLs.

The following examples are shipped with the Xtext framework and are available from the Xtext Example Wizard. They are extended by Model-to-Text transformations to generate intermediate Graphviz \*.dot files as inputs for the GEF DOT Graph View.

### Visualizing the Xtext Domain-Model Example

The Xtext Domain-Model Example describes a language that allows the specification of entities with their properties/operations and their relations to each other.
![1_DomainModelExample_class_diagram.jpg](images/1_DomainModelExample_class_diagram.jpg)

The [DomainmodelDotGeneratorTest](https://github.com/itemis/itemis-blog/blob/gef_graphical_views_on_xtext_dsls/DomainModelExample/org.eclipse.xtext.example.domainmodel.tests/src/org/eclipse/xtext/example/domainmodel/tests/DomainmodelDotGeneratorTest.xtend) test suite specifies how the different Entity DSLs should be translated to Graphviz DOT files.
```Xtend
@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelDotGeneratorTest {

	...

	@Test def test13() {
		'''
			import java.util.List

			entity Blog {
				title: String
				posts: List<Post>

				op addPost(Post post) : void { }
				op getPosts() : List<Post> {}
			}

			entity HasAuthor {
				author: String

				op getAuthor() { author }
				op setAuthor() : void {}
			}

			entity Post extends HasAuthor {
				title: String
				content: String
				comments: List<Comment>
			}

			entity Comment extends HasAuthor {
				content: String
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp

				nodesep=1.2
				rankdir=BT

				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]

				// nodes
				Blog [
					label = "{
						Blog|
						title : String\l|
						addPost(Post post) : void\lgetPosts() : List\<Post\>\l
					}"
				]
				HasAuthor [
					label = "{
						HasAuthor|
						author : String\l|
						getAuthor() : String\lsetAuthor() : void\l
					}"
				]
				Post [
					label = "{
						Post|
						title : String\lcontent : String\l|
					}"
				]
				Comment [
					label = "{
						Comment|
						content : String\l|
					}"
				]

				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				Post -> HasAuthor
				Comment -> HasAuthor

				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				Blog -> Post [headlabel="posts\n[0..*]"]
				Post -> Comment [headlabel="comments\n[0..*]"]
			}
		''')
	}

	...

}
```
The implementation of the [DomainmodelDotGenerator](https://github.com/itemis/itemis-blog/blob/gef_graphical_views_on_xtext_dsls/DomainModelExample/org.eclipse.xtext.example.domainmodel/src/org/eclipse/xtext/example/domainmodel/generator/DomainmodelDotGenerator.xtend) shows that each entity is translated into a DOT node, the entity's properties/operations are coded into the DOT node's record-based label, while the inheritance/association relationships are converted to DOT edges with corresponding arrowhead/arrowtail symbols.

```Xtend
class DomainmodelDotGenerator extends JvmModelGenerator {

	...

	override void doGenerate(Resource input, IFileSystemAccess fsa) {
		fsa.generateFile(input.fileName, (input.contents.head as DomainModel).toDot)
	}

	def toDot(DomainModel it) '''
		digraph {
			// layout=sfdp

			nodesep=1.2
			rankdir=BT

			«generateEntities»

			«generateInheritanceConnections»

			«generateAssociationConnections»
		}
	'''

	private def generateEntities(DomainModel it) '''
		node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]

		// nodes
		«FOR entity : entities»
			«entity.generate»
		«ENDFOR»
	'''

	private def generate(Entity it) '''
		«name» [
			label = "{
				«name»|
				«generateProperties»|
				«generateOperations»
			}"
		]
	'''

	...

	private def generateInheritanceConnections(DomainModel it) '''
		// inheritance edges
		edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
		«FOR entity : entities»
			«IF entity.superType!==null»
				«entity.name» -> «entity.superType.simpleName»
			«ENDIF»
		«ENDFOR»
	'''

	private def generateAssociationConnections(DomainModel it) '''
		// association edges
		edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
		«FOR entity : entities»
			«FOR property : entity.associationProperties»
				«entity.name» -> «property.type.determineType.simpleName» [headlabel="«property.associationLabel»"]
			«ENDFOR»
		«ENDFOR»
	'''

	...

}
```
 As soon as the Xtext project is extended by the GEF DOT-based visualization support, the `Show In -> DOT Graph` context menu of the Xtext Editor opens the graphical representation of the Xtext DSL.

![2_DomainModelExample_visualization.png](images/2_DomainModelExample_visualization.png)

### Visualizing the Xtext Home Automation Example
The Xtext Home Automation Example describes a language for home automation systems that allows the specification of devices with their states and rules to describe the effects of the events on the devices' states.
![3_HomeAutomationExample_class_diagram.jpg](images/3_HomeAutomationExample_class_diagram.jpg)
Rules firing the same device state may lead to endless recursion. Such warnings are presented on the textual editor and also on the graphical view.
![4_HomeAutomationExample_visualization.png](images/4_HomeAutomationExample_visualization.png)

### Visualizing the Xtext Simple Arithmetics Example
The Xtext Simple Arithmetics Example describes a language for simple arithmetics calculation such as addition, substraction, multiplication and division. The operands of an expression can either be a simple number, a function call or even a complex expression.
![5_SimpleArithmeticsExample_class_diagram.jpg](images/5_SimpleArithmeticsExample_class_diagram.jpg)

The graphical view on an expression shows not only the operators with their operands, but also the values of each sub-expressions.
![6_SimpleArithmeticsExample_visualization.png](images/6_SimpleArithmeticsExample_visualization.png)

### Visualizing the Xtext State-Machine Example
The Xtext State-Machine Example describes a languages for State-Machine definitions. A state machine consists of certain commands, events, states and transitions.
![7_StateMachineExample_class_diagram.jpg](images/7_StateMachineExample_class_diagram.jpg)

On the graphical view, the states are presented by nodes, the transitions by edges. The commands are attached to the corresponding nodes, while the events are described on the corresponding edge label.
![8_StateMachineExample_visualization.png](images/8_StateMachineExample_visualization.png)

All these examples are available on the corresponding [GitHub repository](https://github.com/itemis/itemis-blog/tree/gef_graphical_views_on_xtext_dsls). For further information, watch the recorded [GEF DOT session on the EclipseCon Europe 2018](https://www.eclipsecon.org/europe2018/sessions/eclipse-gef-dot-graphviz-authoring-environment-eclipse), study the [GEF DOT User Guide](https://github.com/eclipse/gef/wiki/DOT-User-Guide) and take a look at the [Getting started with GEF 5.0 Online Tutorial](https://info.itemis.com/en/gef/tutorials/).
