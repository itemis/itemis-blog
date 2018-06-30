/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.arithmetics.tests

import javax.inject.Inject
import org.eclipse.xtext.example.arithmetics.tests.ArithmeticsInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(ArithmeticsInjectorProvider)
class ArithmeticsDotGeneratorTest {

	@Inject extension CompilationTestHelper

	@Test def test01() {
		'''
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				
			}
		''')
	}

	@Test def test02() {
		'''
			module arithmetics
			1;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="1" tooltip=1 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
				}
				
			}
		''')
	}

	@Test def test03() {
		'''
			module arithmetics
			1+2;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="+" tooltip=3]
				2[label="1" tooltip=1 shape=circle]
				3[label="2" tooltip=2 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->3
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=1]
					3->1[label=2]
				}
				
			}
		''')
	}

	@Test def test04() {
		'''
			module arithmetics
			1+2+3;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="+" tooltip=6]
				2[label="+" tooltip=3]
				3[label="1" tooltip=1 shape=circle]
				4[label="2" tooltip=2 shape=circle]
				5[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->5
				2->3
				2->4
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=3]
					5->1[label=3]
					3->2[label=1]
					4->2[label=2]
				}
				
			}
		''')
	}

	@Test def test05() {
		'''
			module arithmetics
			1 + 2 - 3;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="-" tooltip=0]
				2[label="+" tooltip=3]
				3[label="1" tooltip=1 shape=circle]
				4[label="2" tooltip=2 shape=circle]
				5[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->5
				2->3
				2->4
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=3]
					5->1[label=3]
					3->2[label=1]
					4->2[label=2]
				}
				
			}
		''')
	}

	@Test def test06() {
		'''
			module arithmetics
			1 * 2 + 3;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="+" tooltip=5]
				2[label="*" tooltip=2]
				3[label="1" tooltip=1 shape=circle]
				4[label="2" tooltip=2 shape=circle]
				5[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->5
				2->3
				2->4
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=2]
					5->1[label=3]
					3->2[label=1]
					4->2[label=2]
				}
				
			}
		''')
	}

	@Test def test07() {
		'''
			module arithmetics
			1 - 2 - 3;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="-" tooltip=-4]
				2[label="-" tooltip=-1]
				3[label="1" tooltip=1 shape=circle]
				4[label="2" tooltip=2 shape=circle]
				5[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->5
				2->3
				2->4
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=-1]
					5->1[label=3]
					3->2[label=1]
					4->2[label=2]
				}
				
			}
		''')
	}

	@Test def test08() {
		'''
			module arithmetics
			1 / 2 * 3;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="*" tooltip=1.5]
				2[label="/" tooltip=0.5]
				3[label="1" tooltip=1 shape=circle]
				4[label="2" tooltip=2 shape=circle]
				5[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->5
				2->3
				2->4
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=0.5]
					5->1[label=3]
					3->2[label=1]
					4->2[label=2]
				}
				
			}
		''')
	}

	@Test def test09() {
		'''
			module arithmetics
			12*(5-6) + 108/2;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="+" tooltip=42]
				2[label="*" tooltip=-12]
				3[label="12" tooltip=12 shape=circle]
				4[label="-" tooltip=-1]
				5[label="5" tooltip=5 shape=circle]
				6[label="6" tooltip=6 shape=circle]
				7[label="/" tooltip=54]
				8[label="108" tooltip=108 shape=circle]
				9[label="2" tooltip=2 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->7
				2->3
				2->4
				4->5
				4->6
				7->8
				7->9
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=-12]
					7->1[label=54]
					3->2[label=12]
					4->2[label=-1]
					5->4[label=5]
					6->4[label=6]
					8->7[label=108]
					9->7[label=2]
				}
				
			}
		''')
	}

	@Test def test10() {
		'''
			module arithmetics
			1*2-3;
			1*(2-3);
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="-" tooltip=-1]
				2[label="*" tooltip=2]
				3[label="1" tooltip=1 shape=circle]
				4[label="2" tooltip=2 shape=circle]
				5[label="3" tooltip=3 shape=circle]
				6[label="*" tooltip=-1]
				7[label="1" tooltip=1 shape=circle]
				8[label="-" tooltip=-1]
				9[label="2" tooltip=2 shape=circle]
				10[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->5
				2->3
				2->4
				6->7
				6->8
				8->9
				8->10
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=2]
					5->1[label=3]
					3->2[label=1]
					4->2[label=2]
					7->6[label=1]
					8->6[label=-1]
					9->8[label=2]
					10->8[label=3]
				}
				
			}
		''')
	}

	@Test def test11() {
		'''
			module arithmetics
			
			def pi: 3.14;
			pi * 4;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="*" tooltip=12.56]
				2[label="pi" tooltip=3.14 shape=box]
				3[label="4" tooltip=4 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->3
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=3.14]
					3->1[label=4]
				}
				
				// subgraphs
				subgraph cluster_pi {
					label="pi"
					4[label="3.14" tooltip=3.14 shape=circle]
				}
			}
		''')
	}

	@Test def test12() {
		'''
			module arithmetics
			
			def a:2;
			def b:1;
			a+b;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="+" tooltip=3]
				2[label="a" tooltip=2 shape=box]
				3[label="b" tooltip=1 shape=box]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->3
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=2]
					3->1[label=1]
				}
				
				// subgraphs
				subgraph cluster_a {
					label="a"
					4[label="2" tooltip=2 shape=circle]
				}
				subgraph cluster_b {
					label="b"
					5[label="1" tooltip=1 shape=circle]
				}
			}
		''')
	}

	@Test def test13() {
		'''
			module arithmetics
			
			def multiply(a, b) : a * b;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				
				// subgraphs
				subgraph cluster_multiply {
					label="multiply"
					1[label="*"]
					2[label="a" shape=box]
					3[label="b" shape=box]
					1->2
					1->3
				}
			}
		''')
	}

	@Test def test14() {
		'''
			module arithmetics
			
			def multiply(a, b) : a * b;
			multiply(2,3);
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="multiply(2,3)" tooltip=6 shape=box]
				
				// forward edges
				edge[arrowhead=vee]
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
				}
				
				// subgraphs
				subgraph cluster_multiply {
					label="multiply"
					2[label="*"]
					3[label="a" shape=box]
					4[label="b" shape=box]
					2->3
					2->4
				}
			}
		''')
	}

	@Test def test15() {
		'''
			module arithmetics
			
			def boxVolume(l,w,h): l*w*h;
			def cubeVolume(l): boxVolume(l,l,l);
			
			cubeVolume(10);
			cubeVolume(2);
			boxVolume(1,3,5);
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="cubeVolume(10)" tooltip=1000 shape=box]
				2[label="cubeVolume(2)" tooltip=8 shape=box]
				3[label="boxVolume(1,3,5)" tooltip=15 shape=box]
				
				// forward edges
				edge[arrowhead=vee]
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
				}
				
				// subgraphs
				subgraph cluster_boxVolume {
					label="boxVolume"
					4[label="*"]
					5[label="*"]
					6[label="l" shape=box]
					7[label="w" shape=box]
					8[label="h" shape=box]
					4->5
					4->8
					5->6
					5->7
				}
				subgraph cluster_cubeVolume {
					label="cubeVolume"
					9[label="boxVolume(l,l,l)" shape=box]
				}
			}
		''')
	}

	@Test def test16() {
		'''
			module arithmetics
			
			multiply(2,multiply(2, 3));
			def multiply(a, b) : a * b;
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="multiply(2,multiply(2, 3))" tooltip=12 shape=box]
				
				// forward edges
				edge[arrowhead=vee]
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
				}
				
				// subgraphs
				subgraph cluster_multiply {
					label="multiply"
					2[label="*"]
					3[label="a" shape=box]
					4[label="b" shape=box]
					2->3
					2->4
				}
			}
		''')
	}

	@Test def test17() {
		'''
			module arithmetics
			
			def fun(a,b) : a * b;
			fun(2, fun(3,4));
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="fun(2, fun(3,4))" tooltip=24 shape=box]
				
				// forward edges
				edge[arrowhead=vee]
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
				}
				
				// subgraphs
				subgraph cluster_fun {
					label="fun"
					2[label="*"]
					3[label="a" shape=box]
					4[label="b" shape=box]
					2->3
					2->4
				}
			}
		''')
	}

	@Test def test18() {
		'''
			module arithmetics
			
			def fun(a,b) : a * b;
			fun(2, fun(3,4)) / (1-2+3);
		'''.assertCompilesTo('''
			digraph {
				node[shape=square style="bold, filled" fillcolor="orange"]
				
				// nodes
				1[label="/" tooltip=12]
				2[label="fun(2, fun(3,4))" tooltip=24 shape=box]
				3[label="+" tooltip=2]
				4[label="-" tooltip=-1]
				5[label="1" tooltip=1 shape=circle]
				6[label="2" tooltip=2 shape=circle]
				7[label="3" tooltip=3 shape=circle]
				
				// forward edges
				edge[arrowhead=vee]
				1->2
				1->3
				3->4
				3->7
				4->5
				4->6
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					2->1[label=24]
					3->1[label=2]
					4->3[label=-1]
					7->3[label=3]
					5->4[label=1]
					6->4[label=2]
				}
				
				// subgraphs
				subgraph cluster_fun {
					label="fun"
					8[label="*"]
					9[label="a" shape=box]
					10[label="b" shape=box]
					8->9
					8->10
				}
			}
		''')
	}
}
