package org.xtext.example.mydsl

import com.google.inject.Inject
import java.util.HashMap
import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.xtext.resource.EObjectDescription
import org.eclipse.xtext.resource.IEObjectDescription
import org.eclipse.xtext.resource.impl.DefaultResourceDescriptionStrategy
import org.eclipse.xtext.scoping.impl.ImportUriResolver
import org.eclipse.xtext.util.IAcceptor
import org.xtext.example.mydsl.myDsl.Model
import org.eclipse.emf.ecore.EObject

class MyDslResourceDescriptionStrategy extends DefaultResourceDescriptionStrategy {
	public static final String INCLUDES = "includes"
	@Inject
	ImportUriResolver uriResolver

	override createEObjectDescriptions(EObject eObject, IAcceptor<IEObjectDescription> acceptor) {
		if(eObject instanceof Model) {
			this.createEObjectDescriptionForModel(eObject, acceptor)
			return true
		}
		else {
			super.createEObjectDescriptions(eObject, acceptor)
		}
	}

	def void createEObjectDescriptionForModel(Model model, IAcceptor<IEObjectDescription> acceptor) {
		val uris = newArrayList()
		model.includes.forEach[uris.add(uriResolver.apply(it))]
		val userData = new HashMap<String,String>
		userData.put(INCLUDES, uris.join(","))
		acceptor.accept(EObjectDescription.create(QualifiedName.create(model.eResource.URI.toString), model, userData))
	}
}


