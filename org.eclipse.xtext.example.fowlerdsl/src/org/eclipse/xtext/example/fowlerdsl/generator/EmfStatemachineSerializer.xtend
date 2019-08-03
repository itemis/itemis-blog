package org.eclipse.xtext.example.fowlerdsl.generator

import com.google.inject.Inject
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.example.fowlerdsl.statemachine.Statemachine
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.xtext.resource.FileExtensionProvider
import org.eclipse.xtext.resource.XtextResourceSet

import static extension org.eclipse.emf.common.util.URI.createPlatformResourceURI

class EmfStatemachineSerializer extends AbstractGenerator {

	@Inject extension FileExtensionProvider

	override doGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
		serialize(input.toOutputURI, (input.contents.head as Statemachine))
	}

	private def serialize(URI outputURI, Statemachine statemachine) {
		val resource = new XtextResourceSet().createResource(outputURI)
		resource.contents += statemachine
		resource.save(newHashMap)
	}

	private def toOutputURI(Resource input) {
		val inputUri = input.URI
		val inputPath = inputUri.toPlatformString(true)

		val outputPath = inputPath.replace("." + primaryFileExtension, ".statemachine" )

		outputPath.createPlatformResourceURI(true)
	}

}