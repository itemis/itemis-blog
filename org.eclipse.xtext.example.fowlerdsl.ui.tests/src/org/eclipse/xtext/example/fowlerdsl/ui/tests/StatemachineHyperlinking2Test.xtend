/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
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
import org.eclipse.xtext.ui.testing.AbstractHyperlinkingTest
import org.junit.Test
import org.junit.runner.RunWith

/**
 * @author miklossy - Initial contribution and API
 */
@RunWith(XtextRunner)
@InjectWith(StatemachineUiInjectorProvider)
class StatemachineHyperlinking2Test extends AbstractHyperlinkingTest {

	@Inject extension StatemachineResourceSetHelper

	override protected dslFile(CharSequence content) {
		val dslFile = super.dslFile(content)
		initializeResourceSet(dslFile.project.fullPath.toString)
		dslFile
	}

	@Test def hyperlink_on_event() {
		'''
			state idle
				«c»doorClosed«c» => active
			end

			state active
			end
		'''.hasHyperlinkTo("doorClosed")
	}

	@Test def hyperlink_on_reset_event() {
		'''
			resetEvents
				«c»doorOpened«c»
			end
		'''.hasHyperlinkTo("doorOpened")
	}

	@Test def hyperlink_on_command() {
		'''
			state idle
				actions {«c»unlockDoor«c»}
			end
		'''.hasHyperlinkTo("unlockDoor")
	}
}