# How to reference UML elements from Xtext DSLs

With the [Xtext framework](https://www.eclipse.org/Xtext/) one can build DSL workbenches in just a few steps. However, sometimes it is desired to reuse model elements already defined in other formats, or even in other languages.

The previous blog post [Combining EMF Models with Xtext DSLs](https://blogs.itemis.com/en/combining-emf-models-with-xtext-dsls) introduced use cases on reusing model elements belonging to the same language but defined in different formats.

This blog post demonstrates the use cases on **reusing model elements belonging to a different language**. Consider e.g. having some already defined Eclipse UML2 models and you want to reference classes from these UML models from your Xtext DSL.
 
#### I. Preparation steps
1. Install the latest version of the `UML2 Extender SDK` and the `Xtext Complete SDK` from the Eclipse Release Train.
![Installation.jpg](images/1-Installation.jpg)

2. Create the Domainmodel project based on the [Xtext 15 Minutes Tutorial](https://www.eclipse.org/Xtext/documentation/102_domainmodelwalkthrough.html). The meta-model of the Domainmodel project

![Domainmodel_class_diagram.jpg](images/2-Domainmodel_class_diagram.jpg)

describes that a domain model consist of certain types (datatypes and entities), an entity contains features and each feature can have a type. To be able to **use UML classes in the feature's type definition**, the following modifications are necessary:

#### II. Modifications<sup>1</sup> in the `org.example.domainmodel` plug-in

3. Extend the [Domainmodel.xtext](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/src/org/example/domainmodel/Domainmodel.xtext#L23) grammar definition

```
grammar org.example.domainmodel.Domainmodel with org.eclipse.xtext.common.Terminals

...

import "http://www.eclipse.org/uml2/5.0.0/UML" as uml

...

Feature:
	(many?='many')? name=ID ':' type=[uml::Class|FQN] | type=[Type];

...
```


4. Extend the [GenerateDomainmodel.mwe2](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/src/org/example/domainmodel/GenerateDomainmodel.mwe2#L11-L66) workflow.

```
module org.example.domainmodel.GenerateDomainmodel

import org.eclipse.emf.mwe.utils.*
import org.eclipse.xtext.xtext.generator.*
import org.eclipse.xtext.xtext.generator.model.project.*

var rootPath = ".."

Workflow {

	bean = StandaloneSetup {
		
		scanClassPath = true
		platformUri = rootPath
		
		uriMap = {
			from = "platform:/plugin/org.eclipse.emf.codegen.ecore/model/GenModel.genmodel"
			to = "platform:/resource/org.eclipse.emf.codegen.ecore/model/GenModel.genmodel"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.emf.ecore/model/Ecore.genmodel"
			to = "platform:/resource/org.eclipse.emf.ecore/model/Ecore.genmodel"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.uml2.codegen.ecore/model/GenModel.genmodel"
			to = "platform:/resource/org.eclipse.uml2.codegen.ecore/model/GenModel.genmodel"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.uml2.uml/model/UML.genmodel"
			to = "platform:/resource/org.eclipse.uml2.uml/model/UML.genmodel"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.emf.codegen.ecore/model/GenModel.ecore"
			to = "platform:/resource/org.eclipse.emf.codegen.ecore/model/GenModel.ecore"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.emf.ecore/model/Ecore.ecore"
			to = "platform:/resource/org.eclipse.emf.ecore/model/Ecore.ecore"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.uml2.codegen.ecore/model/GenModel.ecore"
			to = "platform:/resource/org.eclipse.uml2.codegen.ecore/model/GenModel.ecore"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.uml2.uml/model/UML.ecore"
			to = "platform:/resource/org.eclipse.uml2.uml/model/UML.ecore"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.uml2.types/model/Types.genmodel"
			to = "platform:/resource/org.eclipse.uml2.types/model/Types.genmodel"
		}
		uriMap = {
			from = "platform:/plugin/org.eclipse.uml2.types/model/Types.ecore"
			to = "platform:/resource/org.eclipse.uml2.types/model/Types.ecore"
		}
		
		registerGeneratedEPackage = "org.eclipse.emf.ecore.EcorePackage"
		registerGeneratedEPackage = "org.eclipse.uml2.uml.UMLPackage"
		registerGeneratedEPackage = "org.eclipse.uml2.types.TypesPackage"
		registerGeneratedEPackage = "org.eclipse.emf.codegen.ecore.genmodel.GenModelPackage"
		registerGeneratedEPackage = "org.eclipse.uml2.codegen.ecore.genmodel.GenModelPackage"
		registerGenModelFile = "platform:/resource/org.eclipse.emf.ecore/model/Ecore.genmodel"
		registerGenModelFile = "platform:/resource/org.eclipse.emf.codegen.ecore/model/GenModel.genmodel"
		registerGenModelFile = "platform:/resource/org.eclipse.uml2.uml/model/UML.genmodel"
		registerGenModelFile = "platform:/resource/org.eclipse.uml2.codegen.ecore/model/GenModel.genmodel"
	}
	
	component = XtextGenerator {
		...
	}
}	
```
5. Add the following plugins to the `Require-Bundle` section in the [MANIFEST.MF](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/META-INF/MANIFEST.MF#L18-L19) file
	* org.eclipse.uml2.uml
	* org.eclipse.uml2.codegen.ecore
	
6. Add the following classes
	* [UMLLanguageConstants.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/src/org/example/domainmodel/UMLLanguageConstants.xtend)
	* [UMLQualifiedNameProvider.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/src/org/example/domainmodel/UMLQualifiedNameProvider.xtend)
	* [UMLRuntimeModule.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/src/org/example/domainmodel/UMLRuntimeModule.xtend)
	* [UMLStandaloneSetup.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel/src/org/example/domainmodel/UMLStandaloneSetup.xtend)
	
#### III. Modifications<sup>2</sup> in the `org.example.domainmodel.ui` plug-in 
7. Add the following classes
	* [UMLExecutableExtensionFactory.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/src/org/example/domainmodel/ui/UMLExecutableExtensionFactory.xtend)
	* [UMLUiModule.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/src/org/example/domainmodel/ui/UMLUiModule.xtend)
	* [ReflectiveTreeEditorOpener.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/src/org/example/domainmodel/ui/editor/ReflectiveTreeEditorOpener.xtend)
	* [DomainmodelActivatorEx.xtend](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/src/org/example/domainmodel/ui/internal/DomainmodelActivatorEx.xtend)

8. Register the DomainmodelActivatorEx as the `Bundle-Activator` in the [MANIFEST.MF](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/META-INF/MANIFEST.MF#L27) file.
	
9. Add the following plugin to the `Require-Bundle` section in the [MANIFEST.MF](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/META-INF/MANIFEST.MF#L21)
	* org.eclipse.emf.ecore.editor

10. Add the following section to the [plugin.xml](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui/plugin.xml#L435-L442)
```
<!-- register the Xtext UI language services to Xtext's registry -->
<extension
	point="org.eclipse.xtext.extension_resourceServiceProvider">
	<resourceServiceProvider
		class="org.example.domainmodel.ui.UMLExecutableExtensionFactory:org.eclipse.xtext.ui.resource.generic.EmfResourceUIServiceProvider"
		uriExtension="uml">
	</resourceServiceProvider>
</extension>
```

#### IV. Manuel Testing
Start a Runtime Eclipse to verify that the parsing, linking, content assistant, hovering, hyperlink navigation, quickfixes, ... are working properly.

![Xtext-UML-OK.jpg.jpg](images/3-Xtext-UML-OK.jpg)
	
#### V. Automated Testing
* Extend the `org.example.domainmodel.tests` plug-in by [Indexing](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.tests/src/org/example/domainmodel/tests/DomainmodelIndexTest.xtend), [Linking](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.tests/src/org/example/domainmodel/tests/DomainmodelLinkingTest.xtend), [Parsing](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.tests/src/org/example/domainmodel/tests/DomainmodelParsingTest.xtend), [Scoping](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.tests/src/org/example/domainmodel/tests/DomainmodelScopingTest.xtend)... **JUnit test cases**.
* Extend the `org.example.domainmodel.ui.tests` plug-in by 
 [ContentAssistant](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui.tests/src/org/example/domainmodel/ui/tests/DomainmodelContentAssist2Test.xtend),
 [Hovering](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui.tests/src/org/example/domainmodel/ui/tests/DomainmodelHover2Test.xtend), 
 [Hyperlinking](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui.tests/src/org/example/domainmodel/ui/tests/DomainmodelHyperlinking2Test.xtend),  [Quickfixes](https://github.com/itemis/itemis-blog/blob/referencing-uml-elements-from-xtext-dsls/org.example.domainmodel.ui.tests/src/org/example/domainmodel/ui/tests/DomainmodelQuickfix2Test.xtend)... **JUnit Plug-in test cases**.

 
 This example was kept simple on purpose. If you are interested on more advanced use-cases on the Xtext-UML integration, I recommend you [Karsten](https://blogs.itemis.com/author/karsten-thoms) and [Holger](https://blogs.itemis.com/author/holger-schill) presentation on [How to build Code Generators for Non-Xtext Models with Xtend](https://www.youtube.com/watch?v=teOULtQ81-U).

<hr>
<sup>1,2</sup> Please note that the blog [Combining EMF Models with Xtext DSLs](https://blogs.itemis.com/en/combining-emf-models-with-xtext-dsls) explains the necessary modifications in detail.