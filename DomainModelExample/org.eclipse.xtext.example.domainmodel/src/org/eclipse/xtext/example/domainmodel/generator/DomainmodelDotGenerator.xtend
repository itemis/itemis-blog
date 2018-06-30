/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.domainmodel.generator

import com.google.inject.Inject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.common.types.JvmOperation
import org.eclipse.xtext.common.types.JvmParameterizedTypeReference
import org.eclipse.xtext.common.types.JvmTypeReference
import org.eclipse.xtext.example.domainmodel.domainmodel.DomainModel
import org.eclipse.xtext.example.domainmodel.domainmodel.Entity
import org.eclipse.xtext.example.domainmodel.domainmodel.Operation
import org.eclipse.xtext.example.domainmodel.domainmodel.Property
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.xbase.compiler.JvmModelGenerator
import org.eclipse.xtext.xbase.jvmmodel.IJvmModelAssociations

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class DomainmodelDotGenerator extends JvmModelGenerator {

	@Inject extension ISerializer
	@Inject extension IJvmModelAssociations

	override void doGenerate(Resource input, IFileSystemAccess fsa) {
		fsa.generateFile(input.fileName, (input.contents.head as DomainModel).toDot)
	}

	def toDot(DomainModel it) '''
		digraph {
			// layout=sfdp
			
			nodesep=1.2
			rankdir=BT
			
			«generateEntities»
			
			«generateInheritanceConnections»
			
			«generateAssociationConnections»
		}
	'''

	private def generateEntities(DomainModel it) '''
		node [shape=record style="filled, bold" color="#CE970D" fillcolor="#FAEAC1" fontcolor="#CE970D"]
		
		// nodes
		«FOR entity : entities»
			«entity.generate»
		«ENDFOR»
	'''

	private def generate(Entity it) '''
		«name» [
			label = "{
				«name»|
				«generateProperties»|
				«generateOperations»
			}"
		]
	'''

	private def generateProperties(Entity it)
		'''«FOR memberProperty : memberProperties»«memberProperty.memberLabel»\l«ENDFOR»'''

	private def generateOperations(Entity it)
		'''«FOR operation : operations»«operation.operationLabel»\l«ENDFOR»'''

	private def generateInheritanceConnections(DomainModel it) '''
		// inheritance edges
		edge[arrowhead=onormal color="#CE970D" fontcolor="#CE970D"]
		«FOR entity : entities»
			«IF entity.superType!==null»
				«entity.name» -> «entity.superType.simpleName»
			«ENDIF»
		«ENDFOR»
	'''

	private def generateAssociationConnections(DomainModel it) '''
		// association edges
		edge[arrowhead=normal arrowtail=diamond dir=both constraint=false]
		«FOR entity : entities»
			«FOR property : entity.associationProperties»
				«entity.name» -> «property.type.determineType.simpleName» [headlabel="«property.associationLabel»"]
			«ENDFOR»
		«ENDFOR»
	'''

	private def entities(DomainModel it) {
		if(it===null) newArrayList else elements.filter(Entity)
	}

	private def properties(Entity it) {
		features.filter(Property)
	}

	private def operations(Entity it) {
		features.filter(Operation)
	}

	private def memberProperties(Entity it) {
		properties.filter[!hasEntityType]
	}

	private def associationProperties(Entity it) {
		properties.filter[hasEntityType]
	}

	private def hasEntityType(Property it) {
		type.determineType.type.primarySourceElement instanceof Entity
	}

	private def memberLabel(Property it)
		'''«name» : «type.name»'''

	private def associationLabel(Property it)
		'''«name»\n«type.cardinality»'''
		
	private def operationLabel(Operation it)
		'''«name»(«parameters») : «returnType»'''

	/**
	 * Determines the (explicit or inferred) return type of an Operation.
	 */
	private def returnType(Operation it) {
		if (type !== null) {
			// explicit return type
			type.name
		} else {
			// inferred return type
			val inferredOperation = getPrimaryJvmElement as JvmOperation
			if (inferredOperation !== null && inferredOperation.returnType !== null) {
				inferredOperation.returnType.name
			} else {
				// broken model
				""
			}
		}
	}

	private def name(JvmTypeReference it) {
		simpleName.mask
	}

	private def parameters(Operation it) 
		'''«FOR param : params SEPARATOR ','»«param.serialize.mask»«ENDFOR»'''

	private def mask(String text) {
		text.replaceAll("\\<", "\\\\<").replaceAll("\\>", "\\\\>")
	}

	private def cardinality(JvmTypeReference it)
		'''«IF many»[0..*]«ELSE»«1»«ENDIF»'''
	
	private def determineType(JvmTypeReference it) {
		val jvmParameterizedTypeReference = it as JvmParameterizedTypeReference
		if(!jvmParameterizedTypeReference.arguments.empty) {
			jvmParameterizedTypeReference.arguments.head
		} else {
			jvmParameterizedTypeReference
		}
	}

	private def many(JvmTypeReference it) {
		type.identifier == "java.util.List"
	}

	private def fileName(Resource res) {
		// generate the dot file into the "src-gen" folder
		// res.URI.lastSegment.replace(".", "_") + ".dot"
		
		// generate the dot file into the "src-gen" folder using the package structure of the model file
		res.URI.segments.drop(3).join("/").replace(".", "_") + ".dot"
	}
}
