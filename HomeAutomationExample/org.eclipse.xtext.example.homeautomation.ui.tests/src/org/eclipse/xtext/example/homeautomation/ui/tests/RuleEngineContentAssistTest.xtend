package org.eclipse.xtext.example.homeautomation.ui.tests

import java.util.List
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractContentAssistTest
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(RuleEngineUiInjectorProvider)
class RuleEngineContentAssistTest extends AbstractContentAssistTest {

	// cursor position marker
	val c = '''<|>'''

	@Test def empty() {
		'''
			«c»
		'''.testContentAssistant(#[
			'Device',
			'Example - Insert an example',
			'Example Rules - Insert example rules',
			'Rule'
		], 'Device', '''
			Device
		''')
	}

	@Test def rule_device_state() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when «c»
		'''.testContentAssistant(#[
			'Window.open',
			'Window.closed',
			'Heater.on',
			'Heater.off',
			'Heater.error'
		], 'Window.open', '''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open
		''')
	}

	@Test def rule_device_state_with_prefix() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Win«c»
		'''.testContentAssistant(#[
			'Window.open',
			'Window.closed'
		], 'Window.open', '''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open
		''')
	}

	@Test def rule_then_part() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				«c»
		'''.testContentAssistant(#[
			'do',
			'false',
			'for',
			'if',
			'new',
			'null',
			'return',
			'switch',
			'synchronized',
			'throw',
			'true',
			'try',
			'typeof',
			'val',
			'var',
			'while'
		], 'switch', '''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				switch
		''')
	}

	@Test def rule_then_part_with_prefix() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				fire(Heater.o«c»)
		'''.testContentAssistant(#[
			'on',
			'off'
		], 'off', '''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				fire(Heater.off)
		''')
	}
	
	@Test def example_rules() {
		'''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			«c»
		'''.testContentAssistant(#[
			'Device',
			'Example Rules - Insert example rules',
			'Rule'
		], 'Example Rules - Insert example rules', '''
			Device Window can be open, closed
			Device Heater can be on, off, error
			
			Rule 'rule1' when Window.open then
				fire(Heater.off)
				
			Rule 'rule2' when Heater.on then
				fire(Window.closed)
				
			Rule 'rule3' when Window.closed then
				fire(Heater.on)
				
			Rule 'rule4' when Window.closed then
				fire(Window.closed)
		''')
	}

	private def void testContentAssistant(CharSequence text, List<String> expectedProposals,
		String proposalToApply, String expectedContent) {
		
		val cursorPosition = text.toString.indexOf(c)
		val content = text.toString.replace(c, "")
		
		newBuilder.append(content).
		assertTextAtCursorPosition(cursorPosition, expectedProposals).
		applyProposal(cursorPosition, proposalToApply).
		expectContent(expectedContent)
	}
}
