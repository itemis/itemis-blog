package org.eclipse.xtext.example.fowlerdsl.tests

import org.junit.runner.RunWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.junit.Before
import org.junit.Test
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.resource.IResourceDescription

import static extension org.junit.Assert.assertEquals
import org.eclipse.xtext.resource.impl.ResourceDescriptionsProvider
import org.eclipse.emf.ecore.resource.ResourceSet

/**
 * The index stores information (IEobjectDescription objects) about all the objects in every resource.
 * This is the base for cross-reference resolution.
 *
 * The set of resources handled by the index depends on the context of the execution:
 *		- In the IDE, Xtext indexes all the resources in all Xtext projects. The index is kept up-to-date using the incremental building mechanism of Eclipse.
 *		- In a plain runtime context (where there is no workspace), the index is based on the EMF ResourceSet.
 *		- In both context, the index is global. Visibility across resources is handled by containers.
 *
 * The index is implemented by IResourceDescriptions and can be obtained through the injected ResourceDescriptionsProvider using the getResourceDescriptions(Resource) method.
 * The indexed object descriptions of a resource are stored in IResourceDescription, which is an abstract description of a resource.
 * We get the list of all the IEObjectDescription elements of a resource that are externally visible (globally exported) using the getExportedObject() method.
 */
@RunWith(XtextRunner)
@InjectWith(StatemachineInjectorProvider)
class StatemachineIndexTest {

	@Inject extension ParseHelper<Statemachine>
	@Inject extension ResourceDescriptionsProvider
	@Inject extension StatemachineResourceSetHelper

	@Before def setup() {
		initializeResourceSet
	}

	@Test def events() {
		'''
			events
				doorClosed   D1CL
				drawerOpened D2OP
				lightOn      L1ON
				doorOpened   D1OP
				panelClosed  PNCL
			end
		'''.parse.assertExportedEObjectDescriptions('''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
		''')
	}

	@Test def events_in_external_resource() {
		eventsStatemachine.assertExportedEObjectDescriptions('''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
		''')
	}

	@Test def commands() {
		'''
			commands
				unlockPanel PNUL
				lockPanel   NLK
				lockDoor    D1LK
				unlockDoor  D1UL
			end
		'''.parse.assertExportedEObjectDescriptions('''
			unlockPanel
			lockPanel
			lockDoor
			unlockDoor
		''')
	}

	@Test def commands_in_external_resource() {
		commandsStatemachine.assertExportedEObjectDescriptions('''
			unlockPanel
			lockPanel
			lockDoor
			unlockDoor
		''')
	}

	@Test def events_and_commands() {
		'''
			events
				doorClosed   D1CL
				drawerOpened D2OP
				lightOn      L1ON
				doorOpened   D1OP
				panelClosed  PNCL
			end

			commands
				unlockPanel PNUL
				lockPanel   NLK
				lockDoor    D1LK
				unlockDoor  D1UL
			end
		'''.parse.assertExportedEObjectDescriptions('''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
			unlockPanel
			lockPanel
			lockDoor
			unlockDoor
		''')
	}

	@Test def events_and_commands_external_resources() {
		resourceSet.assertExportedEObjectDescriptions('''
			doorClosed
			drawerOpened
			lightOn
			doorOpened
			panelClosed
			unlockPanel
			lockPanel
			lockDoor
			unlockDoor
		''')
	}

	@Test def states() {
		'''
		state idle
		end

		state active
		end

		state waitingForLight
		end

		state waitingForDrawer
		end

		state unlockedPanel
		end
		'''.parse.assertExportedEObjectDescriptions('''
			idle
			active
			waitingForLight
			waitingForDrawer
			unlockedPanel
		''')
	}

	@Test def transitions() {
		'''
		events
			doorClosed D1CL
		end

		state idle
			doorClosed => active
		end

		state active
		end
		'''.parse.assertExportedEObjectDescriptions('''
			doorClosed
			idle
			active
		''')
	}

	private def assertExportedEObjectDescriptions(EObject it, String qualifiedNames) {
		#[index.getResourceDescription(eResource.URI)].assertVisibleQualifiedNames(qualifiedNames)
	}

	private def assertExportedEObjectDescriptions(ResourceSet it, String qualifiedNames) {
		index.allResourceDescriptions.assertVisibleQualifiedNames(qualifiedNames)
	}

	private def index(EObject it) {
		eResource.getResourceDescriptions
	}

	private def index(ResourceSet it) {
		getResourceDescriptions
	}

	private def assertVisibleQualifiedNames(Iterable<IResourceDescription> it, String expected) {
		val actual = map[exportedObjects].flatten.map[qualifiedName].join(System.lineSeparator)
		expected.trim.assertEquals(actual)
	}
}