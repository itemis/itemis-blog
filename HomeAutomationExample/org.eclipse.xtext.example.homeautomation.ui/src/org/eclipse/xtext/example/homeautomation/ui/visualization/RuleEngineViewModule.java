/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.homeautomation.ui.visualization;

import org.eclipse.gef.common.adapt.AdapterKey;
import org.eclipse.gef.dot.internal.ui.DotGraphViewModule;
import org.eclipse.gef.mvc.fx.policies.ResizePolicy;
import org.eclipse.gef.mvc.fx.policies.TransformPolicy;
import org.eclipse.gef.zest.fx.handlers.TranslateSelectedAndRelocateLabelsOnDragHandler;

import com.google.inject.multibindings.MapBinder;

public class RuleEngineViewModule extends DotGraphViewModule {

	@Override
	protected void bindNodePartAdapters(MapBinder<AdapterKey<?>, Object> adapterMapBinder) {
		super.bindNodePartAdapters(adapterMapBinder);

		// translate on-drag
		adapterMapBinder.addBinding(AdapterKey.defaultRole()).to(TranslateSelectedAndRelocateLabelsOnDragHandler.class);

		// transform policy for relocation
		adapterMapBinder.addBinding(AdapterKey.defaultRole()).to(TransformPolicy.class);

		// resize policy to resize nesting nodes
		adapterMapBinder.addBinding(AdapterKey.defaultRole()).to(ResizePolicy.class);

		// anchor provider
//		adapterMapBinder.addBinding(AdapterKey.defaultRole())
//				.to(/* NodePartAnchorProvider.class */ CustomNodePartAnchorProvider.class);
	}
}
