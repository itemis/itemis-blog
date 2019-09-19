/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.homeautomation.tests

import javax.inject.Inject
import org.eclipse.xtext.example.homeautomation.tests.RuleEngineInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Test cases for the {@link org.eclipse.xtext.example.homeautomation.generator.RuleEngineDotGenerator} class.
 */
@RunWith(XtextRunner)
@InjectWith(RuleEngineInjectorProvider)
class RuleEngineDotGeneratorTest {

	@Inject extension CompilationTestHelper

	@Test def test01() {
		'''
		'''.assertCompilesTo('''
			digraph {
				
				node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
				
				// nodes
				// edges
			}
		''')
	}

	@Test def test02() {
		'''
			Device Window can be open
		'''.assertCompilesTo('''
			digraph {
				
				node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
				
				// nodes
				subgraph cluster_Window {
					label = "Window"
					"Window.open" [label=open]
				}
				
				// edges
			}
		''')
	}

	@Test def test03() {
		'''
			Device Window can be open
			
			Rule 'rule1' when Window.open then
				fire(Window.open)
		'''.assertCompilesTo('''
			digraph {
				
				node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
				
				// nodes
				subgraph cluster_Window {
					label = "Window"
					"Window.open" [label=open]
				}
				
				// edges
				"Window.open" -> "Window.open" [color=gold]
			}
		''')
	}

	@Test def test04() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
		'''.assertCompilesTo('''
			digraph {
				
				node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
				
				// nodes
				subgraph cluster_Window {
					label = "Window"
					"Window.open" [label=open]
					"Window.closed" [label=closed]
					
					// invisible edges to influence the layouting
					"Window.open" -> "Window.closed" [style=invis]
				}
				
				subgraph cluster_Heater {
					label = "Heater"
					"Heater.on" [label=on]
					"Heater.off" [label=off]
					"Heater.error" [label=error]
					
					// invisible edges to influence the layouting
					"Heater.on" -> "Heater.off" -> "Heater.error" [style=invis]
				}
				
				// edges
			}
		''')
	}

	@Test def test05() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				fire(Heater.off)
				
			Rule 'rule2' when Heater.on then
				fire(Window.closed)
				
			Rule 'rule3' when Window.closed then
				fire(Heater.on)
		'''.assertCompilesTo('''
			digraph {
				
				node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
				
				// nodes
				subgraph cluster_Window {
					label = "Window"
					"Window.open" [label=open]
					"Window.closed" [label=closed]
					
					// invisible edges to influence the layouting
					"Window.open" -> "Window.closed" [style=invis]
				}
				
				subgraph cluster_Heater {
					label = "Heater"
					"Heater.on" [label=on]
					"Heater.off" [label=off]
					"Heater.error" [label=error]
					
					// invisible edges to influence the layouting
					"Heater.on" -> "Heater.off" -> "Heater.error" [style=invis]
				}
				
				// edges
				"Window.open" -> "Heater.off" [arrowhead=onormal]
				"Heater.on" -> "Window.closed" [arrowhead=onormal]
				"Window.closed" -> "Heater.on" [arrowhead=onormal]
			}
		''')
	}

	@Test def test06() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				fire(Heater.off)
				
			Rule 'rule2' when Heater.on then
				fire(Window.closed)
				
			Rule 'rule3' when Window.closed then
				fire(Heater.on)
				
			Rule 'rule3' when Window.open then
				fire(Window.open)
		'''.assertCompilesTo('''
			digraph {
				
				node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
				
				// nodes
				subgraph cluster_Window {
					label = "Window"
					"Window.open" [label=open]
					"Window.closed" [label=closed]
					
					// invisible edges to influence the layouting
					"Window.open" -> "Window.closed" [style=invis]
				}
				
				subgraph cluster_Heater {
					label = "Heater"
					"Heater.on" [label=on]
					"Heater.off" [label=off]
					"Heater.error" [label=error]
					
					// invisible edges to influence the layouting
					"Heater.on" -> "Heater.off" -> "Heater.error" [style=invis]
				}
				
				// edges
				"Window.open" -> "Heater.off" [arrowhead=onormal]
				"Heater.on" -> "Window.closed" [arrowhead=onormal]
				"Window.closed" -> "Heater.on" [arrowhead=onormal]
				"Window.open" -> "Window.open" [color=gold]
			}
		''')
	}
}
