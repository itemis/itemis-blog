package org.example.domainmodel.runtime.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.formatter.FormatterTestHelper
import org.example.domainmodel.tests.DomainmodelInjectorProvider
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelFormatterTest {

	@Inject extension FormatterTestHelper

	@Test def test001() {
		assertFormatted[
			toBeFormatted = '''
				entity E {}
			'''
			expectation = '''
				entity E {
				}
			'''
		]
	}

	@Test def test002() {
		assertFormatted[
			toBeFormatted = '''
				datatype DataType
				entity E {f:DataType}
			'''
			expectation = '''
				datatype DataType
				entity E {
					f : DataType
				}
			'''
		]
	}
}