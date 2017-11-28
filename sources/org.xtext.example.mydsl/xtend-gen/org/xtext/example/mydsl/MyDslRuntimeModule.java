package org.xtext.example.mydsl;

import org.eclipse.xtext.resource.IDefaultResourceDescriptionStrategy;
import org.eclipse.xtext.scoping.IGlobalScopeProvider;
import org.xtext.example.mydsl.AbstractMyDslRuntimeModule;
import org.xtext.example.mydsl.MyDslResourceDescriptionStrategy;
import org.xtext.example.mydsl.scoping.MyDslGlobalScopeProvider;

@SuppressWarnings("all")
public class MyDslRuntimeModule extends AbstractMyDslRuntimeModule {
  public Class<? extends IDefaultResourceDescriptionStrategy> bindIDefaultResourceDescriptionStrategy() {
    return MyDslResourceDescriptionStrategy.class;
  }
  
  @Override
  public Class<? extends IGlobalScopeProvider> bindIGlobalScopeProvider() {
    return MyDslGlobalScopeProvider.class;
  }
}
