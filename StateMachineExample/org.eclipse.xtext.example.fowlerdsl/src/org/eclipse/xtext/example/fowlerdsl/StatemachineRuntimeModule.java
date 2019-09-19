/*******************************************************************************
 * Copyright (c) 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.fowlerdsl;

import org.eclipse.xtext.example.fowlerdsl.generator.StatemachineDotGenerator;
import org.eclipse.xtext.generator.IGenerator2;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class StatemachineRuntimeModule extends AbstractStatemachineRuntimeModule {

	@Override
	public Class<? extends IGenerator2> bindIGenerator2() {
		return StatemachineDotGenerator.class;
	}

}
