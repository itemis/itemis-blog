package org.eclipse.xtext.example.fowlerdsl.tests

import com.google.inject.Inject
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.eclipse.xtext.example.fowlerdsl.statemachine.StatemachineFactory
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.resource.SaveOptions
import java.io.StringWriter
import static extension org.junit.Assert.assertEquals
import org.junit.Before

@RunWith(XtextRunner)
@InjectWith(StatemachineInjectorProvider)
class StatemachineSerializerTest {

	@Inject extension ISerializer
	@Inject extension FileExtensionProvider
	@Inject extension StatemachineResourceSetHelper

	extension StatemachineFactory = StatemachineFactory.eINSTANCE

	@Before def setup() {
		initializeResourceSet
	}

	@Test def test() {
		statemachine.testSerialization('''
			resetEvents
				doorOpened
			end

			state idle
				actions { unlockDoor lockPanel }
				doorClosed => active
			end

			state active
				drawerOpened => waitingForLight
				lightOn      => waitingForDrawer
			end

			state waitingForLight
				lightOn => unlockedPanel
			end

			state waitingForDrawer
				drawerOpened => unlockedPanel
			end

			state unlockedPanel
				actions { unlockPanel lockDoor }
				panelClosed => idle
			end
		''')
	}

	private def statemachine() {
		val idle = createState => [
			name = 'idle'
			actions += #[unlockDoor, lockPanel]
		]

		val active = createState => [
			name = 'active'
		]

		val waitingForLight = createState => [
			name = 'waitingForLight'
		]

		val waitingForDrawer = createState => [
			name = 'waitingForDrawer'
		]

		val unlockedPanel = createState => [
			name = 'unlockedPanel'
			actions += #[unlockPanel, lockDoor]
		]

		idle.transitions += createTransition => [
			event = doorClosed
			state = active
		]

		active.transitions += createTransition => [
			event = drawerOpened
			state = waitingForLight
		]

		active.transitions += createTransition => [
			event = lightOn
			state = waitingForDrawer
		]

		waitingForLight.transitions += createTransition => [
			event = lightOn
			state = unlockedPanel
		]

		waitingForDrawer.transitions += createTransition => [
			event = drawerOpened
			state = unlockedPanel
		]

		unlockedPanel.transitions += createTransition => [
			event = panelClosed
			state = idle
		]

		createStatemachine => [
			resetEvents += doorOpened
			states += #[idle, active, waitingForLight, waitingForDrawer, unlockedPanel]
		]
	}

	private def testSerialization(Statemachine statemachine, String content) {
		// given
		statemachine.
		// when
		serialize.
		// then
		dslFileHasContent(content)
	}

	private def serialize(EObject statemachine) {
		val resource = resourceSet.createResource(URI.createURI("test." + primaryFileExtension))
		resource.contents += statemachine
		val sw = new StringWriter
		statemachine.serialize(sw, SaveOptions.newBuilder.format.options)
		sw
	}

	private def dslFileHasContent(StringWriter sw, String content) {
		content.assertEquals(sw.toString)
	}
}