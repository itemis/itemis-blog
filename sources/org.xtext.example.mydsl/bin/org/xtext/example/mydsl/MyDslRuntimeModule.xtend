package org.xtext.example.mydsl

import org.eclipse.xtext.resource.IDefaultResourceDescriptionStrategy
import org.eclipse.xtext.scoping.IGlobalScopeProvider
import org.xtext.example.mydsl.scoping.MyDslGlobalScopeProvider

class MyDslRuntimeModule extends AbstractMyDslRuntimeModule {
	def Class<? extends IDefaultResourceDescriptionStrategy> bindIDefaultResourceDescriptionStrategy() {
		MyDslResourceDescriptionStrategy
	}
	override Class<? extends IGlobalScopeProvider> bindIGlobalScopeProvider() {
		MyDslGlobalScopeProvider;
	}
}

