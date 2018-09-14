package org.eclipse.xtext.example.fowlerdsl.tests

import org.junit.runner.RunWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.junit.Test

import static extension org.junit.Assert.assertEquals
import org.junit.Before

/**
 * The actual cross-reference resolution (the linking) is performed by the LinkingService.
 * Usually, you do not need to customize the linking service, since the default implementation
 * relies on IScopeProvider, which is the component you would customize instead.
 * You can think of a scope as a symbol table, where keys are the names and the values are instances of IEObjectDescription.
 *
 * Both scopes and the index deal with object descriptions.
 * The crucial difference is that a scope also specifies the actual string with which you can refer to an object.
 * The actual string does not have to be equal to the object description's qualified name in the index.
 * Thus, the same object can be referred to with different strings in different program contexts.
 *
 * The index provides all the qualified names of the visible objects of a resource so that all these objects
 * can be referred to using their qualified names. The scope provides further information, that is, in a given program context,
 * some objects can be referred to even using simple names or using qualified names with less segments.
 */
@RunWith(XtextRunner)
@InjectWith(StatemachineInjectorProvider)
class StatemachineLinkingTest {

	@Inject extension ParseHelper<Statemachine>
	@Inject extension StatemachineResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def linking_resetEvent() {
		val statemachine = '''
			resetEvents
				doorOpened
			end
		'''.parse(resourceSet)
	
		doorOpened.assertEquals(statemachine.resetEvents.head)
	}

	@Test def linking_commands() {
		val statemachine = '''
			state idle
				actions {unlockDoor lockPanel}
			end
		'''.parse(resourceSet)
	
		unlockDoor.assertEquals(statemachine.states.head.actions.head)
		lockPanel.assertEquals(statemachine.states.head.actions.get(1))
	}

	@Test def linking_events() {
		val statemachine = '''
			state idle
				actions {unlockDoor lockPanel}
				doorClosed => active
			end
			
			state active
			end
		'''.parse(resourceSet)
	
		doorClosed.assertEquals(statemachine.states.head.transitions.head.event)
	}

	@Test def linking_states() {
		
		val statemachine = '''
			state idle
				actions {unlockDoor lockPanel}
				doorClosed => active
			end
			
			state active
			end
		'''.parse(resourceSet)
	
		val idleState = statemachine.states.head
		val activeState = statemachine.states.get(1)
		activeState.assertEquals(idleState.transitions.head.state)
	}

}