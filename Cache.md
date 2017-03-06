#Caching
As you language grows during the development, the performance sooner or later is
an issue for most of us. So we start a profiler and soon see some hotspots inside
our code, we want to improve. A fast and easy way to do this is caching.

Inside this blogpost I want to introduce an easy mechanism for caching all kinds
of stuff.

##Problems
Regarding a Cache, there are two main problems:
The first problem is, how to implement a Cache in a proper way, that he can handle
a lot of data and does not get too slow.
The second problem is, that you need to find the point in time, when to invalidate this cache.
Imagine you cache some parts of your DSL, but as the build is finished the user
changes the files and the whole cache needs to be renewed. How can you invalidate
the cache at this point without triggering this explicitly?

##Implementation
To solve the first problem, the selection of the right map is the key. If you want
to use the Cache inside some code, which is parallelized you need to use a synchronized map.
If you want to use it in single threaded code, you can use a non synchronized map.
Java has some pretty good implementations nowadays, so you can easily switch
between these.
The second problem is also quite easy to solve. To have the cache invalidated
every time a build is run, we use an EMF Adapter and attach this adapter to the
`ResourceSet`. Every time a build is triggered, a new `ResourceSet` is created and the old
cache is thrown away and a new one is going to be created.

##Implementation of the Adapter
To implement an EMF Adapter we simply create our own Adapter and extend the class `AdapterImpl`
from `org.eclipse.emf.common.notify.impl-Package`. By simply overriding the method
`isAdapterForType(Object obj)` we are done. Afterwards we can start implementing
the cache.
First of all we will take a synchronized map as we want to access our cache also from inside
the generator, which may be parallelized. We create the map like this:
```
val cachedValues = Collections.synchronizedMap(new HashMap <Object, Object>)
```

Now we want to create a cache and attach it to the `ResourceSet`. This is done like this:
```
protected static def getCache(ResourceSet resourceSet) {
  val cache = EcoreUtil.getAdapter(resourceSet.eAdapters, Cache) as Cache
  if(cache === null) {
    val newCache = new Cache
    resourceSet.eAdapters.add(newCache)
    return newCache
  }
  cache
}
```
First we check, if there is already a cache attached to the ResourceSet by using `EcoreUtil.getAdapter`.
If there is none, we create it and attach it, otherwise we will take the existing.

Now we need another method, to put something inside the cache. To have it in a very
generic way we use the following method signature, including a lambda.
```
protected def <T,U> U get(T key, (T)=>U lambda) {
  ....
}
```
We here have a key of the generic type `T`, and a lambda which has a rule to get from the type `T`
to a new generic type `U`. With this we have maximum flexibility and can put everything
inside the cache. In the further implementation of the method we just check if
there is already a value for the key, and deliver it back if we have one, otherwise
we start the computation using the `lambda.apply` method.

The method for accessing the cache from the outside, is named `getCachedElements` and has
an `EObject`, a key and a lambda as parameters. Inside the method we get the `ResourceSet` and get
the Cache using `getCache`. On this Cache we call the method `get` to put the value
inside it and get the value back.

##Access the cache from the outside
To access the cache from the outside we use the static extension import feature of
Xtend and just say something like the following:
```
greeting.getCachedElements["greet"+greeting.name,[key|greeting.name]].
```
