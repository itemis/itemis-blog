/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.fowlerdsl.tests

import javax.inject.Inject
import org.junit.Test
import org.junit.runner.RunWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.xbase.testing.CompilationTestHelper

@RunWith(XtextRunner)
@InjectWith(StatemachineInjectorProvider)
class StatemachineDotGeneratorTest {

	@Inject extension CompilationTestHelper

	@Test def test01() {
		'''
		'''.assertCompilesTo('''
			digraph {
				node[shape=Mrecord width=1.5 style=filled fillcolor=green2]
				
				// states (nodes)
			
				// transitions (edges)
			
				// reset events
				resetEvents[shape=record style="bold, dashed, filled" fillcolor=moccasin label="Reset Events:\n"]
			}
		''')
	}

	@Test def test02() {
		'''
			events
				doorClosed		D1CL
				drawerOpened	D2OP
				lightOn			L1ON
				doorOpened		D1OP
				panelClosed 	PNCL
			end
			
			resetEvents
				doorOpened
			end
			
			commands
				unlockPanel PNUL
				lockPanel	NLK
				lockDoor	D1LK
				unlockDoor	D1UL
			end
			
			state idle
				actions {unlockDoor lockPanel}
				doorClosed => active
			end
			
			state active
				drawerOpened => waitingForLight
				lightOn		 => waitingForDrawer
			end
			
			state waitingForLight
				lightOn => unlockedPanel
			end
			
			state waitingForDrawer
				drawerOpened => unlockedPanel
			end
			
			state unlockedPanel
				actions {unlockPanel lockDoor}
				panelClosed => idle
			end
		'''.assertCompilesTo('''
			digraph {
				node[shape=Mrecord width=1.5 style=filled fillcolor=green2]
				
				// states (nodes)
				idle[label="{idle|unlockDoor\llockPanel\l}"]
				active
				waitingForLight
				waitingForDrawer
				unlockedPanel[label="{unlockedPanel|unlockPanel\llockDoor\l}"]
			
				// transitions (edges)
				idle -> active [label=doorClosed]
				active -> waitingForLight [label=drawerOpened]
				active -> waitingForDrawer [label=lightOn]
				waitingForLight -> unlockedPanel [label=lightOn]
				waitingForDrawer -> unlockedPanel [label=drawerOpened]
				unlockedPanel -> idle [label=panelClosed]
			
				// reset events
				resetEvents[shape=record style="bold, dashed, filled" fillcolor=moccasin label="Reset Events:\ndoorOpened"]
			}
		''')
	}
}