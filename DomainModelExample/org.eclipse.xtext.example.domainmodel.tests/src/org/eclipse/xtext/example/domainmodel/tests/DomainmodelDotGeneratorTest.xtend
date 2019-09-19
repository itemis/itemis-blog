/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.domainmodel.tests

import javax.inject.Inject
import org.eclipse.xtext.example.domainmodel.tests.DomainmodelInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Test cases for the {@link org.eclipse.xtext.example.domainmodel.generator.DomainmodelDotGenerator} class.
 */
@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelDotGeneratorTest {

	@Inject extension CompilationTestHelper

	@Test def test01() {
		'''
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test02() {
		'''
			entity E {}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				E [
					label = "{
						E|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test03() {
		'''
			entity Blog {
				post : String
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
						post : String\l|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test04() {
		'''
			import java.util.List
			
			entity Blog {
				post : List<String>
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
						post : List\<String\>\l|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test05() {
		'''
			import java.util.List

			entity E {
				p1 : String
				p2 : List<String>
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				E [
					label = "{
						E|
						p1 : String\lp2 : List\<String\>\l|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test06() {
		'''
			entity A {}
			
			entity B {
				p : A
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				B [
					label = "{
						B|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				B -> A [headlabel="p\n1"]
			}
		''')
	}

	@Test def test07() {
		'''
			entity A {
				p : B
			}
			
			entity B {}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				B [
					label = "{
						B|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				A -> B [headlabel="p\n1"]
			}
		''')
	}

	@Test def test08() {
		'''
			entity A {
				p : A
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				A -> A [headlabel="p\n1"]
			}
		''')
	}

	@Test def test09() {
		'''
			import java.util.List
			
			entity A {
				p : List<B>
			}
			
			entity B {}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				B [
					label = "{
						B|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				A -> B [headlabel="p\n[0..*]"]
			}
		''')
	}

	@Test def test10() {
		'''
			import java.util.List
			
			entity A {
				p : List<B>
			}
			
			entity B {
				p : List<A>
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				B [
					label = "{
						B|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				A -> B [headlabel="p\n[0..*]"]
				B -> A [headlabel="p\n[0..*]"]
			}
		''')
	}

	@Test def test11() {
		'''
			import java.util.List
			
			entity A {
				p1 : List<A>
				p2 : A
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				A -> A [headlabel="p1\n[0..*]"]
				A -> A [headlabel="p2\n1"]
			}
		''')
	}

	@Test def test12() {
		'''
			entity A {}
			
			entity B extends A {}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
					}"
				]
				B [
					label = "{
						B|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				B -> A
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

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

	@Test def test14() {
		'''
			import java.util.List
			 
			entity Person {
				name: String
				firstName: String
				friends: List<Person>
				address : Address
			}
			
			entity Address {
				street: String
				zip: String
				city: String
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				Person [
					label = "{
						Person|
						name : String\lfirstName : String\l|
					}"
				]
				Address [
					label = "{
						Address|
						street : String\lzip : String\lcity : String\l|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				Person -> Person [headlabel="friends\n[0..*]"]
				Person -> Address [headlabel="address\n1"]
			}
		''')
	}

	@Test def test15() {
		'''
			import java.util.List
			
			entity A {
				names : List<String>
				c : C
			}
			
			entity B {
				something : String
				myA : List<A>
			}
			
			entity C {
				
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						names : List\<String\>\l|
					}"
				]
				B [
					label = "{
						B|
						something : String\l|
					}"
				]
				C [
					label = "{
						C|
						|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				A -> C [headlabel="c\n1"]
				B -> A [headlabel="myA\n[0..*]"]
			}
		''')
	}

	@Test def test16() {
		'''
			import java.util.List
			
			entity Gender {}
			entity Mother {}
			entity Son {}
			entity Daughter {}
			
			entity Father {
				id: String
				name: String
				gender:Gender
				wife: Mother
				sons: List <Son>
				daughters: List <Daughter>
				hobbyList: List<String>
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				Gender [
					label = "{
						Gender|
						|
					}"
				]
				Mother [
					label = "{
						Mother|
						|
					}"
				]
				Son [
					label = "{
						Son|
						|
					}"
				]
				Daughter [
					label = "{
						Daughter|
						|
					}"
				]
				Father [
					label = "{
						Father|
						id : String\lname : String\lhobbyList : List\<String\>\l|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				Father -> Gender [headlabel="gender\n1"]
				Father -> Mother [headlabel="wife\n1"]
				Father -> Son [headlabel="sons\n[0..*]"]
				Father -> Daughter [headlabel="daughters\n[0..*]"]
			}
		''')
	}

	@Test def test17() {
		'''
			import java.util.List
			
			entity Gender {}
			entity Mother {}
			entity Son {}
			entity Daughter {}
			
			entity Father {
				id: String
				name: String
				gender:Gender
				wife: Mother
				sons: List <Son>
				daughters: List <Daughter>
				hobbyList: List<String>
				
				op activityInOneDay(): void {
					getUp();
					haveBreakfast();
					workAtHome();
					haveLunch();
				}
				
				op getUp(): void {}
				
				op haveBreakfast(): void {}
				
				op workAtHome(): void {}
				
				op haveLunch(): void {}
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				Gender [
					label = "{
						Gender|
						|
					}"
				]
				Mother [
					label = "{
						Mother|
						|
					}"
				]
				Son [
					label = "{
						Son|
						|
					}"
				]
				Daughter [
					label = "{
						Daughter|
						|
					}"
				]
				Father [
					label = "{
						Father|
						id : String\lname : String\lhobbyList : List\<String\>\l|
						activityInOneDay() : void\lgetUp() : void\lhaveBreakfast() : void\lworkAtHome() : void\lhaveLunch() : void\l
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				Father -> Gender [headlabel="gender\n1"]
				Father -> Mother [headlabel="wife\n1"]
				Father -> Son [headlabel="sons\n[0..*]"]
				Father -> Daughter [headlabel="daughters\n[0..*]"]
			}
		''')
	}

	@Test def test18() {
		'''
			import java.util.List
			
			entity Person {
				op a() : void {}
				op b() : String {}
				op c() : Person {}
				op d() : List<String> {}
				op e() : List<Person> {}
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				Person [
					label = "{
						Person|
						|
						a() : void\lb() : String\lc() : Person\ld() : List\<String\>\le() : List\<Person\>\l
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test19() {
		'''
			import java.util.List
			
			entity Person {
				op a() : void {}
				op b() : String {}
				op c(String p1) : Person {}
				op d(String p1, int p2) : List<String> {}
				op e(Person p1, List<Person> p2) : List<Person> {}
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				Person [
					label = "{
						Person|
						|
						a() : void\lb() : String\lc(String p1) : Person\ld(String p1, int p2) : List\<String\>\le(Person p1, List\<Person\> p2) : List\<Person\>\l
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test20() {
		'''
			import java.util.List
			
			entity Person {
				name: String
				firstName: String
				friends: List<Person>
				address : Address
				op getFullName() : String {
					// return firstName + " " + name;
				}
			
				op getFriendsSortedByFullName() : List<Person> {
					// return friends.sortBy[ f | f.fullName ]
				}
			}
			
			entity Address {
				street: String
				zip: String
				city: String
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				Person [
					label = "{
						Person|
						name : String\lfirstName : String\l|
						getFullName() : String\lgetFriendsSortedByFullName() : List\<Person\>\l
					}"
				]
				Address [
					label = "{
						Address|
						street : String\lzip : String\lcity : String\l|
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
				Person -> Person [headlabel="friends\n[0..*]"]
				Person -> Address [headlabel="address\n1"]
			}
		''')
	}

	@Test def test21() {
		'''
			entity A {
				op m() : Object {}
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
						m() : Object\l
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test22() {
		'''
			entity A {
				op m() {}
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
						m() : Object\l
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}

	@Test def test23() {
		'''
			import java.util.LinkedList
			
			entity A {
				op m() {
					new LinkedList<String>
				}
			}
		'''.assertCompilesTo('''
			digraph {
				// layout=sfdp
				
				nodesep=1.2
				rankdir=BT
				
				node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
				
				// nodes
				A [
					label = "{
						A|
						|
						m() : LinkedList\<String\>\l
					}"
				]
				
				// inheritance edges
				edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
				
				// association edges
				edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
			}
		''')
	}
}
