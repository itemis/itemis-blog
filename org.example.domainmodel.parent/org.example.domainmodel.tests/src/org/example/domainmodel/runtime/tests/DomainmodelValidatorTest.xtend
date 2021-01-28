package org.example.domainmodel.runtime.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.example.domainmodel.domainmodel.Domainmodel
import org.example.domainmodel.domainmodel.DomainmodelPackage
import org.example.domainmodel.tests.DomainmodelInjectorProvider
import org.example.domainmodel.validation.DomainmodelValidator
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class DomainmodelValidatorTest {

	@Inject extension ParseHelper<Domainmodel>

	@Inject extension ValidationTestHelper

	@Test def test_valid_model() {
		'''
			entity MyEntity {}
		'''.parse.assertNoIssues
	}

	@Test def test_invalid_model() {
		'''
			entity myEntity {}
		'''.parse.assertWarning(
			DomainmodelPackage.Literals.ENTITY,
			DomainmodelValidator.INVALID_NAME,
			"Name should start with a capital"
		)
	}
}