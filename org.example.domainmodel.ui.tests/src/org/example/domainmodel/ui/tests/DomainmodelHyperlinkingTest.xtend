/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.example.domainmodel.ui.tests

import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.ui.testing.AbstractHyperlinkingTest
import org.junit.Test
import org.junit.runner.RunWith

/**
 * @author miklossy - Initial contribution and API
 */
@RunWith(XtextRunner)
@InjectWith(DomainmodelUiInjectorProvider)
class DomainmodelHyperlinkingTest extends AbstractHyperlinkingTest {

	@Test def hyperlink_on_entity_superType() {
		'''
			entity HasAuthor {}
			entity Post extends «c»HasAuthor«c» {}
		'''.hasHyperlinkTo("HasAuthor")
	}
	
	@Test def hyperlink_on_feature_type() {
		'''
			datatype String
			
			entity Blog {
				title: «c»String«c»
			}
		'''.hasHyperlinkTo("String")
	}
}
