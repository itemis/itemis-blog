/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.fowlerdsl.ui.tests

import com.google.inject.Inject
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith
import org.eclipse.xtext.ui.testing.AbstractHoverTest

/**
 * @author miklossy - Initial contribution and API
 */
@RunWith(XtextRunner)
@InjectWith(StatemachineUiInjectorProvider)
class StatemachineHover2Test extends AbstractHoverTest {

	@Inject extension StatemachineResourceSetHelper

	override protected dslFile(CharSequence content) {
		val dslFile = super.dslFile(content)
		initializeResourceSet(dslFile.project.fullPath.toString)
		dslFile
	}

	@Test def hover_over_reset_event() {
		'''
			resetEvents
				doorOpened
			end
		'''.hasHoverOver("doorOpened", '''Event <b>doorOpened</b>''')
	}

	@Test def hover_over_state_action() {
		'''
			state idle
				actions { lockPanel }
			end
		'''.hasHoverOver("lockPanel", '''Command <b>lockPanel</b>''')
	}

	@Test def hover_over_transition_event() {
		'''
			state idle
				doorClosed => active
			end

			state active
			end
		'''.hasHoverOver("doorClosed", '''Event <b>doorClosed</b>''')
	}

	@Test def hover_over_transition_state() {
		'''
			state idle
				doorClosed => active
			end

			state active
			end
		'''.hasHoverOver("active", '''State <b>state active</b>''')
	}
}