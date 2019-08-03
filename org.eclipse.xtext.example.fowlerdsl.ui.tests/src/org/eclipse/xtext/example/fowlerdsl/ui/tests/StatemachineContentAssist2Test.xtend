package org.eclipse.xtext.example.fowlerdsl.ui.tests

import com.google.inject.Inject
import java.io.InputStream
import java.util.List
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.example.fowlerdsl.tests.utils.StatemachineResourceSetHelper
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.XtextProjectHelper
import org.eclipse.xtext.ui.refactoring.ui.SyncUtil
import org.eclipse.xtext.ui.testing.AbstractContentAssistTest
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

import static extension org.eclipse.xtext.ui.testing.util.IResourcesSetupUtil.addNature

/**
 * The scope provider is also used by the content assist to provide
 * a list of all visible elements. Since the scope concerns a specific
 * program context, the proposals provided by the content assist
 * are actually sensible for that specific context.
 */
@RunWith(XtextRunner)
@InjectWith(StatemachineUiInjectorProvider)
class StatemachineContentAssist2Test extends AbstractContentAssistTest {

	@Inject extension FileExtensionProvider
	@Inject extension StatemachineResourceSetHelper
	@Inject extension SyncUtil

	static String projectFullPath

	// cursor position marker
	val c = '''<|>'''

	@Before def setup() {
		val project = getJavaProject(null).project
		project.addNature(XtextProjectHelper.NATURE_ID)

		projectFullPath = project.fullPath.toString

		initializeResourceSet(projectFullPath)

		waitForBuild(new NullProgressMonitor)
	}

	@Test def statemachine_resetEvents() {
		'''
			resetEvents
				«c»
			end
		'''.testContentAssistant(#[
			'doorClosed',
			'drawerOpened',
			'lightOn',
			'doorOpened',
			'panelClosed'
		], 'doorOpened', '''
			resetEvents
				doorOpened
			end
		''')
	}

	@Test def state_actions() {
		'''
			state idle
				actions {«c»}
			end
		'''.testContentAssistant(#[
			'unlockPanel',
			'lockPanel',
			'lockDoor',
			'unlockDoor',
			'{'
		], 'unlockDoor', '''
			state idle
				actions {unlockDoor}
			end
		''')
	}

	@Test def transition_event() {
		'''
			state idle
				actions {unlockDoor lockPanel}
				«c»
			end
		'''.testContentAssistant(#[
			'Transition - Template for a Transition',
			'doorClosed',
			'drawerOpened',
			'lightOn',
			'doorOpened',
			'panelClosed',
			'end'
		], 'doorClosed', '''
			state idle
				actions {unlockDoor lockPanel}
				doorClosed
			end
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

	/**
	 * Unit testing the content assistant with several dsls/xmis:
	 * https://www.eclipse.org/forums/index.php/t/243876/
	 */
	override getResourceFor(InputStream stream) {
		val set = resourceSet as XtextResourceSet
		initializeTypeProvider(set)

		val uri = URI.createPlatformResourceURI(projectFullPath + "/" + "test." + primaryFileExtension, true)

		var result = set.getResource(uri, false)

		if(result===null){
			result = set.createResource(uri)
			result.load(stream, null)
		}

		result as XtextResource
	}
}