/*
 * generated by Xtext
 */
package org.eclipse.xtext.example.domainmodel


/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
class DomainmodelStandaloneSetup extends DomainmodelStandaloneSetupGenerated {

	def static void doSetup() {
		new DomainmodelStandaloneSetup().createInjectorAndDoEMFRegistration()
	}
}
