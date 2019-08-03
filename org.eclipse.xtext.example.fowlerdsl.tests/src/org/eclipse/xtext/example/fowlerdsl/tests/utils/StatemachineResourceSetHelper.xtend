package org.eclipse.xtext.example.fowlerdsl.tests.utils

import com.google.inject.Inject
import com.google.inject.Provider
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import org.eclipse.xtext.example.fowlerdsl.EmfStatemachineStandaloneSetup
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.example.fowlerdsl.statemachine.StatemachineFactory
import org.eclipse.xtext.example.fowlerdsl.tests.StatemachineInjectorProvider
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.testing.InjectWith

@InjectWith(StatemachineInjectorProvider)
class StatemachineResourceSetHelper {

	@Inject extension Provider<XtextResourceSet>
	extension StatemachineFactory = StatemachineFactory.eINSTANCE

	ResourceSet resourceSet
	Statemachine eventsStatemachine
	Statemachine commandsStatemachine

	def void initializeResourceSet() {
		new EmfStatemachineStandaloneSetup().createInjectorAndDoEMFRegistration

		resourceSet = get

		// register factories
		val resourceFactoryRegistry = resourceSet.resourceFactoryRegistry
		resourceFactoryRegistry.extensionToFactoryMap.put("emfstatemachine", new XMIResourceFactoryImpl)

		createEventsStatemachine(URI.createURI("events.emfstatemachine"))
		createCommandsStatemachine(URI.createURI("commands.emfstatemachine"))
	}

	def initializeResourceSet(String projectFullPath) {
		resourceSet = get

		createEventsStatemachine(URI.createPlatformResourceURI(projectFullPath + "/events.emfstatemachine", true))
		createCommandsStatemachine(URI.createPlatformResourceURI(projectFullPath + "/commands.emfstatemachine", true))

		resourceSet.resources.forEach[save(newHashMap)]
	}

	def resourceSet() {
		resourceSet
	}

	// events
	def doorClosed()   { eventsStatemachine.events.get(0) }
	def drawerOpened() { eventsStatemachine.events.get(1) }
	def lightOn()      { eventsStatemachine.events.get(2) }
	def doorOpened()   { eventsStatemachine.events.get(3) }
	def panelClosed()  { eventsStatemachine.events.get(4) }

	// commands
	def unlockPanel() { commandsStatemachine.commands.get(0) }
	def lockPanel()   { commandsStatemachine.commands.get(1) }
	def lockDoor()    { commandsStatemachine.commands.get(2) }
	def unlockDoor()  { commandsStatemachine.commands.get(3) }

	def eventsStatemachine() {
		eventsStatemachine
	}

	def commandsStatemachine() {
		commandsStatemachine
	}

	/**
	 * commands.emfstatemachine
	 * commands
	 *			unlockPanel PNUL
	 *			lockPanel   NLK
	 *			lockDoor    D1LK
	 *			unlockDoor  D1UL
	 *	end
	 */
	private def createCommandsStatemachine(URI uri) {
		commandsStatemachine = createStatemachine => [
			commands += createCommand => [name='unlockPanel' code='PNUL']
			commands += createCommand => [name='lockPanel'   code='NLK']
			commands += createCommand => [name='lockDoor'    code='D1LK']
			commands += createCommand => [name='unlockDoor'  code='D1UL']
		]

		resourceSet.createResource(uri).contents += commandsStatemachine
	}

	/**
	 * events.emfstatemachine
	 * events
	 *		doorClosed   D1CL
	 *		drawerOpened D2OP
	 *		lightOn      L1ON
	 *		doorOpened   D1OP
	 *		panelClosed  PNCL
	 * end
	 */
	private def createEventsStatemachine(URI uri) {
		eventsStatemachine = createStatemachine => [
			events += createEvent => [name='doorClosed'   code='D1CL']
			events += createEvent => [name='drawerOpened' code='D2OP']
			events += createEvent => [name='lightOn'      code='L1ON']
			events += createEvent => [name='doorOpened'   code='D1OP']
			events += createEvent => [name='panelClosed'  code='PNCL']
		]

		resourceSet.createResource(uri).contents += eventsStatemachine
	}
}