/*******************************************************************************
 * Copyright (c) 2014 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.domainmodel.formatting2;

import org.eclipse.xtext.example.domainmodel.domainmodel.DomainModel
import org.eclipse.xtext.example.domainmodel.domainmodel.Entity
import org.eclipse.xtext.example.domainmodel.domainmodel.Property
import org.eclipse.xtext.formatting2.IFormattableDocument
import org.eclipse.xtext.xbase.formatting2.XbaseFormatter

import static org.eclipse.xtext.example.domainmodel.domainmodel.DomainmodelPackage.Literals.*

/**
 * @author Moritz Eysholdt - Initial implementation and API
 */
class DomainmodelFormatter extends XbaseFormatter {

	def dispatch void format(DomainModel domainmodel, extension IFormattableDocument document) {
		domainmodel.prepend[setNewLines(0, 0, 1); noSpace].append[newLine]
		format(domainmodel.getImportSection(), document);
		for (Entity element : domainmodel.getElements()) {
			format(element, document);
		}
	}

	def dispatch void format(Entity entity, extension IFormattableDocument document) {
		val open = entity.regionFor.keyword("{")
		val close = entity.regionFor.keyword("}")
		entity.regionFor.feature(ENTITY__NAME).surround[oneSpace]
		entity.superType.surround[oneSpace]
		open.append[newLine]
		interior(open, close)[indent]
		format(entity.getSuperType(), document);
		for (Property feature : entity.properties) {
			feature.format
			feature.append[setNewLines(1, 1, 2)]
		}
	}

	def dispatch void format(Property property, extension IFormattableDocument document) {
		property.regionFor.keyword(":").surround[noSpace]
		property.type.format
	}
}
