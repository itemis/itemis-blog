/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.fowlerdsl.ui.visualization

import com.google.inject.Guice
import com.google.inject.util.Modules
import org.eclipse.gef.dot.internal.ui.DotGraphView
import org.eclipse.gef.zest.fx.ZestFxModule
import org.eclipse.gef.zest.fx.ui.ZestFxUiModule

class StatemachineView extends DotGraphView {
	new() {
		super()
		val injector = Guice.createInjector(Modules.override(new ZestFxModule()).with(new ZestFxUiModule()))
//		val injector = Guice.createInjector(Modules.override(new StatemachineViewModule()).with(new ZestFxUiModule()))
		injector.injectMembers(this)
	}
}
