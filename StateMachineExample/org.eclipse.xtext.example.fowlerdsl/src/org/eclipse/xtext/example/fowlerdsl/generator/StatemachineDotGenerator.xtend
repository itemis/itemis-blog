/*******************************************************************************
 * Copyright (c) 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.fowlerdsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.example.fowlerdsl.statemachine.State
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.example.fowlerdsl.statemachine.Transition
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class StatemachineDotGenerator extends AbstractGenerator {

	override void doGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
		fsa.generateFile(input.fileName, (input.contents.head as Statemachine).toDot)
	}

	private def toDot(Statemachine it) '''
		digraph {
			node[shape=Mrecord width=1.5 style=filled fillcolor=green2]
			
			// states (nodes)
			«FOR state : states»
				«state.name»«IF !state.actions.empty»«state.label»«ENDIF»
			«ENDFOR»
		
			// transitions (edges)
			«FOR transition : transitions»
				«transition.source» -> «transition.target» [label=«transition.event.name»]
			«ENDFOR»
		
			// reset events
			resetEvents[shape=record style="bold, dashed, filled" fillcolor=moccasin label="«resetEventsLabel»"]
		}
	'''

	private def transitions(Statemachine it) {
		states.map[transitions].flatten
	}

	private def label(State it) {
		'''[label="{«name»|«FOR action : actions»«action.name»\l«ENDFOR»}"]'''
	}

	private def source(Transition it) {
		(eContainer as State).name
	}

	private def target(Transition it) {
		state.name
	}

	private def resetEventsLabel(Statemachine it)
		'''Reset Events:\n«FOR event : resetEvents SEPARATOR "\\n"»«event.name»«ENDFOR»'''

	private def fileName(Resource res) {
		// generate the dot file into the "src-gen" folder
		// res.URI.lastSegment.replace(".", "_") + ".dot"
		
		// generate the dot file into the "src-gen" folder using the package structure of the model file
		res.URI.segments.drop(3).join("/").replace(".", "_") + ".dot"
	}
}