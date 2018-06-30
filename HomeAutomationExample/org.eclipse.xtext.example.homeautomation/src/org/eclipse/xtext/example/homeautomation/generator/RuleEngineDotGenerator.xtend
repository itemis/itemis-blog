/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.homeautomation.generator

import com.google.inject.Inject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.example.homeautomation.ruleEngine.Device
import org.eclipse.xtext.example.homeautomation.ruleEngine.Model
import org.eclipse.xtext.example.homeautomation.ruleEngine.Rule
import org.eclipse.xtext.example.homeautomation.ruleEngine.State
import org.eclipse.xtext.example.homeautomation.validation.RuleEngineValidator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.xbase.XBlockExpression
import org.eclipse.xtext.xbase.XFeatureCall
import org.eclipse.xtext.xbase.compiler.JvmModelGenerator

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class RuleEngineDotGenerator extends JvmModelGenerator {

	@Inject extension ISerializer
	@Inject extension RuleEngineValidator

	override void doGenerate(Resource input, IFileSystemAccess fsa) {
		fsa.generateFile(input.fileName, (input.contents.head as Model).toDot)
	}

	def toDot(Model it) '''
		digraph {
			
			node[shape=Mrecord style="bold, filled" fillcolor="#3974B1" fontcolor=white]
			
			// nodes
			«FOR device : devices»
				«device.generate»
				
			«ENDFOR»
			// edges
			«FOR rule : rules»
				«rule.generate»
			«ENDFOR»
		}
	'''

	private def devices(Model it) {
		if(it===null) newArrayList else declarations.filter(Device)
	}

	private def generate(Device it) '''
		subgraph cluster_«name» {
			label = "«name»"
			«FOR state : states»
				«state.generate»
			«ENDFOR»
			«generateInvisibleEdges»
		}
	'''

	private def generate(State it)
		'''«nodeID» [label=«name»]'''

	private def nodeID(State it)
		'''"«(eContainer as Device).name».«name»"'''

	private def generateInvisibleEdges(Device it) '''
		«IF states.length > 1»
			
			// invisible edges to influence the layouting
			«states.map[nodeID].join(" -> ")» [style=invis]
		«ENDIF»
	'''

	private def rules(Model it) {
		if(it===null) newArrayList else declarations.filter(Rule)
	}

	private def generate(Rule it) '''
		«source» -> «target» [«attributes»]
	'''

	private def source(Rule it)
		'''«deviceState.nodeID»'''

	private def target(Rule it) {
		'''"«firstFeatureCall.actualArguments.head.serialize»"'''
	}

	private def attributes(Rule it)
		'''«IF firstFeatureCall.isRecursive»color=gold«ELSE»arrowhead=onormal«ENDIF»'''

	private def firstFeatureCall(Rule it) {
		(thenPart as XBlockExpression).expressions.head as XFeatureCall
	}

	private def fileName(Resource res) {
		// generate the dot file into the "src-gen" folder
		// res.URI.lastSegment.replace(".", "_") + ".dot"
		
		// generate the dot file into the "src-gen" folder using the package structure of the model file
		res.URI.segments.drop(3).join("/").replace(".", "_") + ".dot"
	}
}
