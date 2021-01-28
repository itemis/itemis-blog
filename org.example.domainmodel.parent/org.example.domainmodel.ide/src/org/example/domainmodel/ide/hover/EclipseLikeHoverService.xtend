package org.example.domainmodel.ide.hover

import com.google.inject.Inject
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.documentation.IEObjectDocumentationProvider
import org.eclipse.xtext.ide.labels.INameLabelProvider
import org.eclipse.xtext.ide.server.hover.HoverService

class EclipseLikeHoverService extends HoverService {

	@Inject extension IEObjectDocumentationProvider
	@Inject extension INameLabelProvider

	override String getContents(EObject element) {
		val documentation = element.documentation
		if(documentation === null) element.firstLine else element.firstLine + "  " + System.lineSeparator + documentation 
	}

	private def String getFirstLine(EObject o) {
		val label = o.nameLabel
		'''«o.eClass.name»«IF label !== null» **«label»**«ENDIF»'''
	}
}