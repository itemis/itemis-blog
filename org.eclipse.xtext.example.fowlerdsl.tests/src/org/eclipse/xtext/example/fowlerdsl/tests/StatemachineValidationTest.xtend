package org.eclipse.xtext.example.fowlerdsl.tests

import com.google.inject.Inject
import org.eclipse.emf.ecore.EClass
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

import static org.eclipse.xtext.example.fowlerdsl.statemachine.StatemachinePackage.Literals.STATE
import static org.eclipse.xtext.example.fowlerdsl.validation.StatemachineValidator.INVALID_NAME

import static extension org.junit.Assert.assertEquals

@RunWith(XtextRunner)
@InjectWith(StatemachineInjectorProvider)
class StatemachineValidationTest {

	@Inject extension ParseHelper<Statemachine>
	@Inject extension ValidationTestHelper
	@Inject extension StatemachineResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def invalid_state_name() {
		'''
			resetEvents
				doorOpened
			end
			
			state Idle
			end
		'''.hasOneWarning(STATE, INVALID_NAME, "Name should start with a lower case letter")
	}

	private def hasOneWarning(CharSequence it, EClass objectType, String issueCode, String message) {
		assertNumberOfValidationIssues(1).
		assertWarning(objectType, issueCode, message)
	}

	private def assertNumberOfValidationIssues(CharSequence it, int expectedNumberOfIssues) {
		val statemachine = parse(resourceSet)
		expectedNumberOfIssues.assertEquals(statemachine.validate.size)
		statemachine
	}
}