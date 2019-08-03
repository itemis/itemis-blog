package org.eclipse.xtext.example.fowlerdsl.ui.tests

import com.google.inject.Inject
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractQuickfixTest
import org.junit.Test
import org.junit.runner.RunWith

import static org.eclipse.xtext.diagnostics.Diagnostic.LINKING_DIAGNOSTIC
import static org.eclipse.xtext.example.fowlerdsl.validation.StatemachineValidator.INVALID_NAME

@RunWith(XtextRunner)
@InjectWith(StatemachineUiInjectorProvider)
class StatemachineQuickfix2Test extends AbstractQuickfixTest {

	@Inject extension StatemachineResourceSetHelper

	override protected dslFile(CharSequence content) {
		val dslFile = super.dslFile(content)
		initializeResourceSet(dslFile.project.fullPath.toString)
		dslFile
	}

	@Test def fix_invalid_reset_event() {
		'''
			resetEvents
				foo
			end
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			new Quickfix("Change to 'doorClosed'", "Change to 'doorClosed'", '''
				resetEvents
					doorClosed
				end
			'''),
			new Quickfix("Change to 'drawerOpened'", "Change to 'drawerOpened'", '''
				resetEvents
					drawerOpened
				end
			'''),
			new Quickfix("Change to 'lightOn'", "Change to 'lightOn'", '''
				resetEvents
					lightOn
				end
			'''),
			new Quickfix("Change to 'doorOpened'", "Change to 'doorOpened'", '''
				resetEvents
					doorOpened
				end
			'''),
			new Quickfix("Change to 'panelClosed'", "Change to 'panelClosed'", '''
				resetEvents
					panelClosed
				end
			''')
		)
	}

	@Test def fix_invalid_state_action() {
		'''
			state idle
				actions {foo}
			end
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			new Quickfix("Change to 'unlockPanel'", "Change to 'unlockPanel'", '''
				state idle
					actions {unlockPanel}
				end
			'''),
			new Quickfix("Change to 'lockPanel'", "Change to 'lockPanel'", '''
				state idle
					actions {lockPanel}
				end
			'''),
			new Quickfix("Change to 'lockDoor'", "Change to 'lockDoor'", '''
				state idle
					actions {lockDoor}
				end
			'''),
			new Quickfix("Change to 'unlockDoor'", "Change to 'unlockDoor'", '''
				state idle
					actions {unlockDoor}
				end
			''')
		)
	}

	@Test def fix_invalid_state_name() {
		'''
			resetEvents
				doorOpened
			end

			state Idle
				actions {unlockDoor lockPanel}
			end
		'''.testQuickfixesOn(INVALID_NAME, new Quickfix("Change to 'idle'.", "Change to 'idle'.", '''
			resetEvents
				doorOpened
			end

			state idle
				actions {unlockDoor lockPanel}
			end
		''')
		)
	}

	@Test def fix_invalid_transition_event() {
		'''
			state idle
				foo => active
			end

			state active
			end
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			 new Quickfix("Change to 'doorClosed'", "Change to 'doorClosed'", '''
				state idle
					doorClosed => active
				end

				state active
				end
			'''),
			new Quickfix("Change to 'drawerOpened'", "Change to 'drawerOpened'", '''
				state idle
					drawerOpened => active
				end

				state active
				end
			'''),
			new Quickfix("Change to 'lightOn'", "Change to 'lightOn'", '''
				state idle
					lightOn => active
				end

				state active
				end
			'''),
			new Quickfix("Change to 'doorOpened'", "Change to 'doorOpened'", '''
				state idle
					doorOpened => active
				end

				state active
				end
			'''),
			new Quickfix("Change to 'panelClosed'", "Change to 'panelClosed'", '''
				state idle
					panelClosed => active
				end

				state active
				end
			''')
		)
	}

	@Test def fix_invalid_transition_state() {
		'''
			state idle
				doorClosed => foo
			end

			state active
			end
		'''.testQuickfixesOn(LINKING_DIAGNOSTIC,
			 new Quickfix("Change to 'idle'", "Change to 'idle'", '''
				state idle
					doorClosed => idle
				end

				state active
				end
			'''),
			new Quickfix("Change to 'active'", "Change to 'active'", '''
				state idle
					doorClosed => active
				end

				state active
				end
			''')
		)
	}
}
