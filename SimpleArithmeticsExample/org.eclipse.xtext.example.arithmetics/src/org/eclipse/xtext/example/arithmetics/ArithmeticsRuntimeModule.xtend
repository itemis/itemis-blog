/*******************************************************************************
 * Copyright (c) 2015, 2017 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.arithmetics

import org.eclipse.xtext.generator.IGenerator2
import org.eclipse.xtext.example.arithmetics.generator.ArithmeticsDotGenerator

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class ArithmeticsRuntimeModule extends AbstractArithmeticsRuntimeModule {

	override Class<? extends IGenerator2> bindIGenerator2() {
		ArithmeticsDotGenerator
	}

}
