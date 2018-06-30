/*******************************************************************************
 * Copyright (c) 2015, 2018 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.arithmetics.generator

import com.google.inject.Inject
import java.util.Map
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.example.arithmetics.arithmetics.Expression
import org.eclipse.xtext.example.arithmetics.interpreter.Calculator
import org.eclipse.xtext.serializer.ISerializer
import org.eclipse.xtext.example.arithmetics.arithmetics.Module
import org.eclipse.xtext.example.arithmetics.arithmetics.Plus
import org.eclipse.xtext.example.arithmetics.arithmetics.Minus
import org.eclipse.xtext.example.arithmetics.arithmetics.Multi
import org.eclipse.xtext.example.arithmetics.arithmetics.Div
import org.eclipse.xtext.example.arithmetics.arithmetics.NumberLiteral
import org.eclipse.xtext.example.arithmetics.arithmetics.FunctionCall
import org.eclipse.xtext.example.arithmetics.arithmetics.Definition
import org.eclipse.xtext.example.arithmetics.arithmetics.Evaluation
import java.math.BigDecimal
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.Locale
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class ArithmeticsDotGenerator extends AbstractGenerator {

	@Inject	extension ISerializer

	extension Calculator = new Calculator

	var nodeId = 1
	val Map<Expression, Integer> nodeToIdMapper = newHashMap

	override void doGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
		nodeId = 1 // reset nodeId to the initial value
		fsa.generateFile(input.fileName, (input.contents.head as Module).toDot)
	}

	def toDot(Module it) '''
		digraph {
			node[shape=square style="bold, filled" fillcolor="orange"]
			
			«IF !expressions.empty»
				// nodes
				«FOR expression : expressions»
					«expression.generateNode»
				«ENDFOR»
				
				// forward edges
				edge[arrowhead=vee]
				«FOR expression : expressions»
					«expression.generateForwardEdge»
				«ENDFOR»
				
				// backward edges
				{
					edge[arrowhead=normal color=green4 style=dashed]
					«FOR expression : expressions»
						«expression.generateBackwardEdge»
					«ENDFOR»
				}
			«ENDIF»
			
			«IF !definitions.empty»
				// subgraphs
				«FOR definition : definitions»
					«definition.generateSubgraph»
				«ENDFOR»
			«ENDIF»
		}
	'''

	private def dispatch String generateNode(Plus it) '''
		«getNodeId»[label="«generateNodeLabel»"«generateNodeTooltip»]
		«left.generateNode»
		«right.generateNode»
	'''

	private def dispatch String generateNode(Minus it) '''
		«getNodeId»[label="«generateNodeLabel»"«generateNodeTooltip»]
		«left.generateNode»
		«right.generateNode»
	'''

	private def dispatch String generateNode(Multi it) '''
		«getNodeId»[label="«generateNodeLabel»"«generateNodeTooltip»]
		«left.generateNode»
		«right.generateNode»
	'''

	private def dispatch String generateNode(Div it) '''
		«getNodeId»[label="«generateNodeLabel»"«generateNodeTooltip»]
		«left.generateNode»
		«right.generateNode»
	'''

	private def dispatch String generateNode(NumberLiteral it) '''
		«getNodeId»[label="«generateNodeLabel»"«generateNodeTooltip» shape=circle]
	'''

	private def dispatch String generateNode(FunctionCall it) '''
		««« using 'box' shape for function calls, since their label can be quite long
		«getNodeId»[label="«generateNodeLabel»"«generateNodeTooltip» shape=box]
	'''

	private def dispatch String generateNode(Expression it) {
		throw new UnsupportedOperationException(''''«class .name»' expressions are not yet supported!''')
	}

	private def dispatch String generateForwardEdge(Plus it) '''
		«getNodeId»->«left.getNodeId»
		«getNodeId»->«right.getNodeId»
		«left.generateForwardEdge»
		«right.generateForwardEdge»
	'''

	private def dispatch String generateForwardEdge(Minus it) '''
		«getNodeId»->«left.getNodeId»
		«getNodeId»->«right.getNodeId»
		«left.generateForwardEdge»
		«right.generateForwardEdge»
	'''

	private def dispatch String generateForwardEdge(Multi it) '''
		«getNodeId»->«left.getNodeId»
		«getNodeId»->«right.getNodeId»
		«left.generateForwardEdge»
		«right.generateForwardEdge»
	'''

	private def dispatch String generateForwardEdge(Div it) '''
		«getNodeId»->«left.getNodeId»
		«getNodeId»->«right.getNodeId»
		«left.generateForwardEdge»
		«right.generateForwardEdge»
	'''

	private def dispatch String generateForwardEdge(NumberLiteral it)
		''''''

	private def dispatch String generateForwardEdge(FunctionCall it)
		''''''

	private def dispatch String generateBackwardEdge(Plus it) '''
		«left.getNodeId»->«getNodeId»[«left.generateBackwardEdgeLabel»]
		«right.getNodeId»->«getNodeId»[«right.generateBackwardEdgeLabel»]
		«left.generateBackwardEdge»
		«right.generateBackwardEdge»
	'''

	private def dispatch String generateBackwardEdge(Minus it) '''
		«left.getNodeId»->«getNodeId»[«left.generateBackwardEdgeLabel»]
		«right.getNodeId»->«getNodeId»[«right.generateBackwardEdgeLabel»]
		«left.generateBackwardEdge»
		«right.generateBackwardEdge»
	'''

	private def dispatch String generateBackwardEdge(Multi it) '''
		«left.getNodeId»->«getNodeId»[«left.generateBackwardEdgeLabel»]
		«right.getNodeId»->«getNodeId»[«right.generateBackwardEdgeLabel»]
		«left.generateBackwardEdge»
		«right.generateBackwardEdge»
	'''

	private def dispatch String generateBackwardEdge(Div it) '''
		«left.getNodeId»->«getNodeId»[«left.generateBackwardEdgeLabel»]
		«right.getNodeId»->«getNodeId»[«right.generateBackwardEdgeLabel»]
		«left.generateBackwardEdge»
		«right.generateBackwardEdge»
	'''

	private def dispatch String generateBackwardEdge(NumberLiteral it)
		''''''

	private def dispatch String generateBackwardEdge(FunctionCall it)
		''''''

	private def dispatch String generateForwardEdge(Expression it) {
		throw new UnsupportedOperationException(''''«class.name»' expressions are not yet supported!''')
	}

	private def generateNodeLabel(Expression it) {
		switch it {
			Plus: "+"
			Minus: "-"
			Multi: "*"
			Div: "/"
			NumberLiteral: '''«value»'''
			FunctionCall: '''«serialize.trim»'''
		}
	}

	private def generateNodeTooltip(Expression it) {
		/*
		 * Generate tooltips only if the expression can be evaluated and it does not evaluates to 'null'
		 */
		val result = formattedResult
		if(result!==null) ''' tooltip=«result»'''
	}

	private def generateBackwardEdgeLabel(Expression it) {
		/*
		 * Generate backward edge label only if the expression can be evaluated and it does not evaluates to 'null'
		 */
		val result = formattedResult
		if(result!==null) '''label=«result»'''
	}

	private def formattedResult(Expression it) {
		val result = try {
			evaluate
		}catch(NullPointerException e) {
			null
		}
		
		if(result!==null) '''«result.format»'''
	}

	private def generateSubgraph(Definition it) '''
		subgraph cluster_«name» {
			label="«name»"
			«expr.generateNode»
			«expr.generateForwardEdge»
		}
	'''

	private def getNodeId(Expression it) {
		if (!nodeToIdMapper.containsKey(it)) {
			nodeToIdMapper.put(it, nodeId++)
		}
	
		nodeToIdMapper.get(it)
	}

	private def getExpressions(Module it) {
		if(it===null) newArrayList else statements.filter(Evaluation).map[expression]
	}

	private def getDefinitions(Module it) {
		if(it===null) newArrayList else statements.filter(Definition)
	}

	private def format(BigDecimal it) {
		// use always the english locale when formatting BigDecimals (use '.' as decimal sign)
		val symbols = DecimalFormatSymbols.getInstance(Locale.ENGLISH)
		new DecimalFormat("#0.##", symbols).format(it)
	}

	private def fileName(Resource res) {
		// generate the dot file into the "src-gen" folder
		// res.URI.lastSegment.replace(".", "_") + ".dot"
		
		// generate the dot file into the "src-gen" folder using the package structure of the model file
		res.URI.segments.drop(3).join("/").replace(".", "_") + ".dot"
	}

}
