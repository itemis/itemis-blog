/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui.tests

import com.google.inject.Inject
import java.io.InputStream
import java.util.List
import org.eclipse.core.runtime.NullProgressMonitor
import org.eclipse.emf.common.util.URI
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.XtextProjectHelper
import org.eclipse.xtext.ui.refactoring.ui.SyncUtil
import org.eclipse.xtext.ui.testing.AbstractContentAssistTest
import org.example.domainmodel.tests.utils.UMLResourceSetHelper
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
@InjectWith(DomainmodelUiInjectorProvider)
class DomainmodelContentAssist2Test extends AbstractContentAssistTest {

	@Inject extension FileExtensionProvider
	@Inject extension UMLResourceSetHelper
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

	@Test def uml_reference_with_package_name() {
		'''
			entity UML {
				a : test.«c»
			}
		'''.testContentAssistant(#[
			'test.A',
			'test.B'
		], 'test.A', '''
			entity UML {
				a : test.A
			}
		''')
	}

	@Test def uml_reference_without_package_name() {
		'''
			entity UML {
				b : «c»
			}
		'''.testContentAssistant(#[
			'UML',
			'b',
			'test',
			'test.A',
			'test.B'
		], 'test.B', '''
			entity UML {
				b : test.B
			}
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
