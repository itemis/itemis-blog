package org.xtext.example.cache

import java.util.Collections
import java.util.HashMap
import org.eclipse.emf.common.notify.impl.AdapterImpl
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.emf.ecore.util.EcoreUtil
import org.eclipse.xtext.resource.impl.ResourceDescriptionsProvider

class Cache extends AdapterImpl {

	val cachedValues = Collections.synchronizedMap(new HashMap <Object, Object>)

	protected def <T,U> U get(T key, (T)=>U lambda) {
		val cachedValue = cachedValues.get(key)
		if(cachedValue !== null)
			return cachedValue as U
		val newValue = lambda.apply(key)
		cachedValues.put(key, newValue)
		return newValue
	}

	override isAdapterForType(Object type) {
		type === typeof(Cache)
	}

	protected static def getCache(ResourceSet resourceSet) {
		val cache = EcoreUtil.getAdapter(resourceSet.eAdapters, Cache) as Cache
		if(cache === null) {
			val newCache = new Cache
			resourceSet.eAdapters.add(newCache)
			return newCache
		}
		return cache
	}

	static def <T, U> U getCachedElements(EObject context, T cacheKey, (T)=>U lambda) {
		if(!context.eIsProxy){
			val resourceSet = context.eResource.resourceSet
			if(resourceSet.loadOptions.containsKey(ResourceDescriptionsProvider.NAMED_BUILDER_SCOPE)) {
				return getCache(resourceSet).get(cacheKey, lambda)
			}
		}
		val newValue = lambda.apply(cacheKey)
		return newValue
	}
}
