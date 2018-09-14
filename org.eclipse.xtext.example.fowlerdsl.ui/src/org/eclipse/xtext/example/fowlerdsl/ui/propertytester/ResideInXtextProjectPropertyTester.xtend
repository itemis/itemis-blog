package org.eclipse.xtext.example.fowlerdsl.ui.propertytester

import org.eclipse.core.expressions.PropertyTester
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.xtext.ui.XtextProjectHelper

/**
 * Property tester to verify that the selected IFile resides in a project having the Xtext nature configured.
 */
class ResideInXtextProjectPropertyTester extends PropertyTester {

	override test(Object it, String property, Object[] args, Object expectedValue) {
		file.residesInXtextProject
	}

	private def file(Object receiver) {
		(receiver as IStructuredSelection).firstElement as IFile
	}

	private def residesInXtextProject(IFile it) {
		project.hasXtextNature
	}

	private def hasXtextNature(IProject it) {
		getNature(XtextProjectHelper.NATURE_ID) !== null
	}

}