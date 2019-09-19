/*******************************************************************************
 * Copyright (c) 2015, 2019 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.example.homeautomation;

import org.eclipse.xtext.example.homeautomation.generator.RuleEngineDotGenerator;
import org.eclipse.xtext.generator.IGenerator;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class RuleEngineRuntimeModule extends AbstractRuleEngineRuntimeModule {

	@Override
	public Class<? extends IGenerator> bindIGenerator() {
		return RuleEngineDotGenerator.class;
	}

}
