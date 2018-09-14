package org.eclipse.xtext.example.fowlerdsl.tests

import com.google.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.eclipse.xtext.scoping.IScopeProvider
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

import static org.eclipse.xtext.example.fowlerdsl.statemachine.StatemachinePackage.Literals.*

import static extension org.junit.Assert.assertEquals

/**
 * Scoping deals with cross-references: references in EMF with the boolean attribute containment set to false.
 */
@RunWith(XtextRunner)
@InjectWith(StatemachineInjectorProvider)
class StatemachineScopeProviderTest {

	@Inject extension ParseHelper<Statemachine>
	@Inject extension IScopeProvider
	@Inject extension StatemachineResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def visible_elements_for_Statemachine_resetEvents() {
		val statemachine = '''
			events
				doorClosed   D1CL
				drawerOpened D2OP
				lightOn      L1ON
				doorOpened   D1OP
				panelClosed  PNCL
			end
		'''.parse
		
		statemachine.assertVisibleElements(STATEMACHINE__RESET_EVENTS, '''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
		''')
	}

	@Test def visible_elements_for_Statemachine_resetEvents_external_resource() {
		val statemachine = ''''''.parse(resourceSet)
		
		statemachine.assertVisibleElements(STATEMACHINE__RESET_EVENTS, '''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
		''')
	}
	
	@Test def visible_elements_for_State_actions(){
		val statemachine = '''
			commands
				unlockPanel PNUL
				lockPanel   NLK
				lockDoor    D1LK
				unlockDoor  D1UL
			end
			
			state idle
			end
		'''.parse
	
		statemachine.states.head.assertVisibleElements(STATE__ACTIONS, '''
			unlockPanel
			lockPanel
			lockDoor
			unlockDoor
		''')
	}

	@Test def visible_elements_for_State_actions_external_resource(){
		val statemachine = '''
			state idle
			end
		'''.parse(resourceSet)
	
		statemachine.states.head.assertVisibleElements(STATE__ACTIONS, '''
			unlockPanel
			lockPanel
			lockDoor
			unlockDoor
		''')
	}

	@Test def visible_elements_for_Transition_event(){
		val statemachine = '''
			events
				doorClosed   D1CL
				drawerOpened D2OP
				lightOn      L1ON
				doorOpened   D1OP
				panelClosed  PNCL
			end
			
			state idle
				doorClosed => active
			end
		'''.parse
		
		statemachine.states.head.transitions.head.assertVisibleElements(TRANSITION__EVENT, '''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
		''')
	}

	@Test def visible_elements_for_Transition_event_external_resource(){
		val statemachine = '''
			state idle
				doorClosed => active
			end
		'''.parse(resourceSet)
	
		statemachine.states.head.transitions.head.assertVisibleElements(TRANSITION__EVENT, '''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
		''')
	}

	@Test def visible_elements_for_Transition_state(){
		val statemachine = '''
			events
				doorClosed D1CL
			end

			state idle
				doorClosed => active
			end
			
			state active
			end
			
			state waitingForLight
			end
			
			state waitingForDrawer
			end
			
			state unlockedPanel
			end
		'''.parse
	
		statemachine.states.head.transitions.head.assertVisibleElements(TRANSITION__STATE, '''
			idle
			active
			waitingForLight
			waitingForDrawer
			unlockedPanel
		''')
	}

	private def assertVisibleElements(EObject context, EReference reference, String expected) {
		val actual = context.getScope(reference).allElements.map[name].join(System.lineSeparator)
		expected.trim.assertEquals(actual)
	}
}