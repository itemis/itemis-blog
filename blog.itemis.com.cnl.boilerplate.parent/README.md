# Xtext and controlled natural languages for software requirements 
Stakeholders usually document requirements informally, i.e. in natural language. Often using text processing programs which do not provide any input assistance related to the requirements and do not allow their automated validation or post-processing. This leads either to higher efforts for cost intensive and time consuming
human review processes or to reduced quality which can have a negative impact on subsequent development phases. To compensate these disadvantages of the usage of natural language in requirements documentation, various approaches exist. One of these approaches is to control the use of natural language by using templates in order to create acceptable requirements as they are written.

This series shows how to create a controlled natural language based on sentence templates (boilerplates) using Xtext. The language will allow the usage of free text in combination with references to model elements at specific parts of the boilerplates. In comprehension to text processing programs the language will support the user through the usability functions of Xtex and will ensure that the requirements match the used boilerplates.

Part one of this series is about the formalization of informal natural language and the realization of the boilerplates in the Xtext grammar. Besides the grammar we will see how to use strings as cross-references in a convenient and readable way.
Part two deals with the validation of the natural language requirements using Natural Language Processing (NLP). This part shows how to include external libraries into a Xtext project and how to use the validation API.

Finally, part three will show how to synchronize domain specific concepts used in specific free text parts of the boilerplates with a glossary using NLP techniques. The focus of this part lies on the quick fix API of Xtext.

## Part 1: Requirement boilerplates  
Requirement boilerplates aim to increase the quality of textual requirements by defining a sentence template with placeholders for specific words or phrases that define the particular requirement. There is a wide range of boilerplates used for requirements documentation. For example user stories in agile software development.

	As a <role>, I want <goal/desire> so that <benefit> 

Such boilerplates allow the documentation of requirements in a standardised way without the knowledge of a specific requirements language and therefore can be used by domain experts as well as requirements engineers. Furthermore, they reduce the risk of ambiguous, inconsistent or vague requirements arising from the use of natural language.

The boilerplate used in this series is similar to the one defined by the International Requirements Engineering Board ([IREB](https://www.ireb.org/)).  

<center>![boilerplate](https://github.com/itemis/itemis-blog/blob/boilerplate/blog.itemis.com.cnl.boilerplate.parent/images/boilerplate.png)</center>  
<center>Figure 1: The used [boilerplate](https://requirementstechniques.wordpress.com/documentation/requirements-templates/ "IREB Boilerplates").</center>

The following sentences are examples for requirements based on this template. Keywords are bold and references to AST elements are encapsulated in quotes.  

- **The** `"printing module"` **shall** `"print"` `"charts"` and `"documents"`.
- **If** the `"analyst"` created the `"chart"` or `"document"` the `"printing module"` **shall** **provide** **the** `"analyst"` **with the ability to** `"print"` this `"chart"` or `"document"`.
- **If** the `"charts"` where created by someone else the `"printing module"` **shall** hide the `"print button"`.
- **The** `"printing module"` **will** **provide the** `"client"` **with the ability to** `"print"` `"documents"`.
- **If** the licence is basic the `"printing module"` **will provide the** `"client"` **with the ability to** `"print"` `"greyscale documents"`.

In order to realize such a language we have to define a Xtext grammar which should look as close as possible like natural language.   

### Grammar
The Grammar consists of referable entities and glossary concepts, two types of boilerplates and the rules needed to use free text.

The Grammar defines the entities `Actor` and `System` which can be referenced in boilerplates by their name.

	Actor: 'Actor'  ':' name=Text 
	description = Description;
	
	System: 'System'  ':' name=Text 
	description = Description;

	Description: 'Description'  ':' text+=SentenceWithReferences*;

The user can use the type `Text` for the name of an entity which can consist of multiple words and is not limited by the Java-ID conventions. Keywords that should be used in Text must be added explicit.

	Text: ( 'To' |  'to' | 'A' | 'a' | 'the' | 'The' | WORD | ANY_OTHER)+;

Here we have to be careful regarding the limitations of the parser. Since the rule text has no distinct terminator, only keywords which are not used as terminators for `Text` types can be added. 

To add further informations for an entity the user can create a description for each entity using the type `SentenceWithReferences`. Such a sentence consists of `textWithReferences` and a `punctuation`. 
		
	SentenceWithReferences: textWithReferences=TextWithReferences punctuation=('.' | '!' | '?');     

`TextWithReferences` allows the combined use of references to entities and plain text. In order to recover the plain text representation of `TextWithReferences` the rule is defined as follows.   

	TextWithReferences:
		(onlyRefs+=[Entities|STRING]+ | 
		refBefore+=[Entities|STRING]* text+=Text 
		after+=EntitieCombination*
		finalRef+=[Entities|STRING]*);

	ReferenceCombination:
		(refs+=[Entities|STRING]+ text+=Text);

References to entities have the type `STRING`. This allows the referencing of entities with a name consisting of multiple words. For example the System `"printing module"`.

The core syntax elements of the language are the `Requirement` rules. The following rules are the realization of the boilerplate shown in figure 1.   

	Requirement:
		ConditionalRequirement | UnconditionalRequirement;
	
	ConditionalRequirement:
		condition=Precondition system=[System|STRING] liability=Liability end=RequirementEnd;

	UnconditionalRequirement:
		the='The' system=[System|STRING] liability=Liability end=RequirementEnd;
	
	Precondition:
		conditional=Conditional condition=TextWithReferences;

	enum Liability:
		shall | should | will;

	ActorInteraction:
		provide='provide' the1='the'? actor=[Actor|STRING] ^with='with' the2='the' ability='ability' to='to';
	
Since an Independent System Activity only consists of a process phrase we don't need to create a separate rule for it. Instead, these informations are captured in the attribute 'objectWithReferences' of the Type `TextWithConceptsOrSynonyms` in the rule `RequirementEnd`.

	RequirementEnd:
		ai=ActorInteraction? objectWithDetails=TextWithConceptsOrSynonyms '.';

Such `TextWithConceptsOrSynonyms` has the same structure than `TextWithReferences` but only `GlossaryConcepts` and their synonyms can be referenced. Such a glossary concept can be a `Function` representing a `"process"` or a `DomainObject` representing an `"object"` in figure 1. 

	Glossary:
		{Glossary} 'Glossary' concepts+=(Concept)*;
	
	Concept:
		Function  | DomainObject ;

	Function:
		'Function' ':' name=Text
		('Synonyms' ':' synonyms+=FunctionSynonym (',' synonyms+=FunctionSynonym)*)?
		('Description' ':' description+=SentenceWithReferences*)?;
	
	DomainObject:
		'Object' ':' name=Text
		('Synonyms' ':' synonyms+=DomainObjectSynonym (',' synonyms+=DomainObjectSynonym)*)?
		('Description' ':' description+=SentenceWithReferences+)?
		('Properties' ':' properties+=Property (',' properties+=Property)*)?;
	
	FunctionSynonym:
		name=Text;
	
	DomainObjectSynonym:
		name=Text; 

Synonyms are needed to ensure a consistent usage and description of terms and also to ensure to readability of the requirements when it comes to flexions or singular and plural nouns. They are nested in `Concepts`. This leads us to the next topic. The referencing of such nested types.      

### Cross-References using simple names 
Xtext uses by default full qualified names for cross-referencing nested types. This means for our language if you want to reference the synonym of a `Concept` you have to use a dot notation. The following example demonstrates this for the object "document" and his synonym "documents". 

	The "printing module" will provide the "client" with the ability to "print" "document.documents".

	Glossary
		Object: document
		Synonyms: documents	   

The use of such full qualified names would decrease the readability. To avoid this we add the `SimpleNameFragment2` to the language part of Modeling Workflow Engine 2 (mwe2) file of the main project. 

		language = StandardLanguage {
			...
			fragment = exporting.SimpleNamesFragment2 {}
			...
		}

This allows the use of simple names	and the direct referencing of nested objects.

### Deactivate auto editing for strings 
Besides the cross-referencing we should change the editor behavior. By default, if we type " the auto editing of the editor inserts another quote to close the string. If we now use Crtl+Space and choose a reference, duplicated quotes get inserted at the end. For example `"printing module""` instead of `"printing module"`. To avoid this we have to deactivate the automated insertions of closing quotes for strings. Therefore, we introduce a new class and override the method `configureStringLiteral` of the `DefaultAutoEditStrategyProvider` in the ui module.

	class MyAutoEditStrategy extends DefaultAutoEditStrategyProvider {
	
		override configureStringLiteral(IEditStrategyAcceptor acceptor) {
			acceptor.accept(partitionEndSkippingEditStrategy.get(),
				TerminalsTokenTypeToPartitionMapper.STRING_LITERAL_PARTITION);
		}
	}

Finally we register our newly introduced class.

	class <YourLanguageName>UiModule extends Abstract<YourLanguageName>UiModule {
	
		override Class<? extends AbstractEditStrategyProvider> bindAbstractEditStrategyProvider() {
			return MyAutoEditStrategy
		}
	}

### Summary and outlook  
In this post we saw how to realize boilerplates in the Xtext grammar and allow the usage of free text combined with references to entities in these boilerplates. The resulting language controls the use of natural language by defining a grammatical sentence structure and allows the user to document requirements in a standardized, convenient and readable way.  

In part two we will see how to further control the usage of natural language specially in the free text parts of the boilerplates. According to figure 1, we will make sure that each requirement contains a free text phrase which describes a process or `Function` of the system and at least one involved `DomainObject`. Since functions can be described by verbs and domain objects by nouns, we will use NLP techniques to ensure that each boilerplate contains exactly one `Function` and at least one `DomainObject`. Therefore, we will integrate an external library and define validation rules based on the Xtext validation API.  

## Part 2: Controlled use of natural language
In the first part of this series we defined a Xtext grammar based on boilerplates in order to control the use of natural language and create acceptable requirements as they are written. Another approach to improve the quality of textual requirements is the use of Natural Language Processing (NLP) techniques to control their quality in terms of grammar and vocabulary after they have been written. 

The NLP technique related to this post is Part-Of-Speech (POS)
tagging which categorizes the tokens (words or phrases) of a sentence into different types like verbs or nouns. Due to the fixed grammatical structure of the boilerplates defined by our Xtext grammar, an more expensive grammatical analysis using NLP techniques is not necessary.

We will use POS-tagging to define constraints for the use of domain specific concepts in the free text parts of the boilerplates. In our approach these concepts are objects and functions which appear as nouns and verbs in the free text parts of the boilerplates.

According to our grammar that means that each `RequirementEnd` must contain exactly one verb representing a `Function` and at least one noun which represents an `DomianObject` in our `Glossary`. 

### Model-to-text transformation 
In order to analyse the boilerplates using NLP techniques, we have to implement a model-to-text transformation which transforms the boilerplates from their representation in the model to plain text. Therefore, we implement a new class which contains toString methods for the different elements of the boilerplates. Due to the structure of the rules we defined in part one of this series, the transformation is rather simple. The following example shows the toString method for the type `TextWithReferences`. 

	def toString(TextWithReferences text) {
		if (!text.onlyRefs.empty) {
			return text.onlyRefs.map[name].join(" ").trim
		}
		val elements = newLinkedList
		elements.addAll(text.refBefore.map[name])
		elements.addAll(text.text)
		text.after.forEach [ comb |
			elements.addAll(comb.refs.map[name])
			elements.addAll(comb.text)
		]
		elements.addAll(text.finalRef.map[name])
		elements.join(" ").trim
	}  

The POS-tagging is done by a POS-tagger. A POS-tagger determines the Part-Of-Speech tag (POS-tag) of a token based on the sentence context. Therefore, we have to create toString methods for all elements related to the boilerplates in order to provide complete sentences as input for the tagger.  

### NLP framework integration
In order to validate natural language we use the framework [TokensRegex](http://nlp.stanford.edu/software/tokensregex.html) from the [Stanford Natural Language Processing Group](http://nlp.stanford.edu/). Its part of the [Stanford CoreNLP](http://stanfordnlp.github.io/CoreNLP/) suite and provides an API which allows the use of cascaded regular expressions over tokens. Basically this means the framework allows pattern matching over sentence phrases or words using regular expression and POS-tags. If you want to use it directly you can integrate it via maven.

	<dependency>
		<groupId>edu.stanford.nlp</groupId>
		<artifactId>stanford-corenlp</artifactId>
		<version>3.6.0</version>
	</dependency>
	<dependency>
		<groupId>edu.stanford.nlp</groupId>
		<artifactId>stanford-corenlp</artifactId>
		<version>3.6.0</version>
		<classifier>models</classifier>
	</dependency>   

I provided a wrapper around the TokensRegex framework. Its called POSRegex and is available at [github](https://github.com/chriskn/POSRegex/tree/master/POSRegex). I recommend this wrapper because it is tailored for the use in this series. To integrate the POSRegex.jar we add it to Bundle-Classpath in the Manifest. 

	Bundle-ClassPath: lib/POSRegex-0.0.2.jar,
	 . 

We have to make sure that we initialize POSRegex only ones at the Eclipse startup because of the time consuming loading of the reference files (treebanks) which gonne be used by the POS-tagger. Therefore, we register it as eager Singleton in the runtime-module. 

	override configure(Binder binder) {
		super.configure(binder);
		binder.bind(IPOSRegexPattern).to(POSRegexPattern).asEagerSingleton();
	} 

Finaly we add the following line to the `build.properties` of the runtime project to make sure the .jar is included in our eclipse plugin.

	jars.extra.classpath = lib/POSRegex-0.0.2.jar    

### Natural language validation
With the model-to-text transformation and the natural language library we are now able to validate the usage of domain specific concepts. We separate the natural language validation from the model based validation rules by defining a new class extending `Abstract<YourLanguageName>Validator` in the validation package of the runtime project. Xtext allows the use of multiple validators by the annotation `@ComposedChecks`. In order to register our new validator we annotate the `<YourLanguageName>Validator` in the following way.

	@ComposedChecks(validators = #[typeof(MyNaturalLanguageValidator)])
	public class <YourLanguageName>Validator extends Abstract<YourLanguageName>Validator { 
	}

The next step is to implement the validation rules in the natural language validator. Therefore, we inject the `IPOSRegexPattern` and our model-to-text converter which is called `BoilerplateToStringConverter` in the following example. The method `checkObjectWithDetailsContainsFunction` checks if each `RequirementEnd` contains exactly one verb. It is called for every `RequirementEnd` instance by Xtext. 

	@Inject
	IPOSRegexPattern posRegex

	@Inject
	BoilerplateToStringConverter converter

	@Check(CheckType.NORMAL)
	def checkObjectWithDetailsContainsFunction(RequirementEnd end) {
		val pattern = '(?$verb[pos:VB|pos:VBD|pos:VBG|pos:VBN|pos:VBP|pos:VBZ])'
		val requirement = end.eContainer as Requirement
		val reqString = converter.toString(requirement)
		val result = posRegex.match(reqString, pattern)
		val objectWithDetails = end.objectWithDetails
		val owdString = converter.toString(objectWithDetails)
		val verbs = result.tokensByGroup.get("verb")
		val verbsInOwdString = countOccurrences(owdString, verbs)
		val literal = <YourLanguageName>Package.Literals.REQUIREMENT_END__OBJECT_WITH_DETAILS
		if (verbsInOwdString.size != 1) {
			error("This text must contain one verb which stands for a function of the system", literal)
		}
	}

The natural language validation can be time consuming. Therefore, we annotate the method with the annotation `CheckType.NORMAL` to ensure that the check is only executed when the user saves the document. In the first step we define a `pattern` containing a non-capturing group called `verb` which matches multiple types of verb POS-Tags (VB=Verb base form, VBD=Verb past tense, VBG=Verb gerund or present participle,...). A detailed description of the syntax can be found in the TokensRegex [documentation](http://nlp.stanford.edu/software/tokensregex.html#Usage). The supported POS-tags are equivalent to the POS-tags defined by the University of Pennsylvania which are described [here](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html). In the next step we get the `Requirement` instance, translate it to text and run the pattern matching. The returned `result` contains all found verbs in the `verb` group. Afterwards, we count the occurrence of these verbs in the free text (`objectWithDetails`) part of the boilerplate. If not exactly one verb is found, we annotate the `objectWithDetails` with an error. 

We can do this kind of validation also for the domain objects. The following pattern could be used to check that each `objectWithDetails` contains a domain object with a name consisting of one or two nouns.

	(?$noun[pos:NN|pos:NNS|pos:NNP|pos:NNPS]{1,2})      

### Summary and outlook
In this part we saw how to validate the use of domain specific concepts inside the free text parts of the boilerplates. Therefore, we integrated a natural language framework and used it together with the validation API of Xtext.  

In Part three we will extend the use of NLP techniques. We will identify domain specific concepts in the free text, annotate them and provide the user quick fixes either to link the concepts with existing concepts in the glossary or to create new glossary entries. Therefore, we will use the quick fix API of Xtext.  

## Part 3: Synchronize boilerplates and glossary   
In part two of this series we checked the requirements using NLP techniques in order to validate the use of domain specific concepts in their free text parts. In this part we will annotate the domain specific concepts and provide the user quick fixes to synchronize them with the glossary.

To provide usefull quick fixes, we have to take the current state of the glossary into account. For example, if a verb is found which exists in the glossary as name of a function, we will provide a quick fix which encloses the verb with quotation marks. Respectively the grammar defined in part one this leads to a conversion of the verb from the type `WORD` to the type `STRING`. In our model this means the verb becomes a reference to the function defined in the glossary and an association between the requirement containing the verb and the function is established.

In order to keep the glossary consistent during such quick fix operations, we will extend the use of NLP techniques. To avoid the creation of multiple glossary concepts for the same word in different inflections we will use stemming. Stemming means finding the root (stem) of a word for inflected forms, for example the singular for a plural word. On base of the comprehension between the found concept and his stem it is possible to decide if the found concept is added as a new concept or as a synonym for an existing concept.

To take all of such conditions into account and decide which quick fixes are provided to the user, we will define a decision table. The realization of the quick fix will be shown exemplary for `Function`s and one of the rules described in the decision table. This quick fix will require the selection of an existing functions by the user. Therefore, we will integrate a choose dialog into it.

### Conditions and quick fixes 
The following decision table contains six rules. Each rule describes one constellation of conditions which leads to a specific quick fix. Conditions which have to apply are marked with `Y` (Yes). Conditions which have not to apply with `N` (No), ignored conditions with -. The quick fix that will be shown, if the constellation of conditions for the rule is fulfilled, is marked with `X`. 

| Available quick fixes if a concept was found in freetext                             | R1 | R2 | R3 | R4 | R5 | R6 |
|--------------------------------------------------------------------------------------|:--:|:--:|:--:|:--:|:--:|:--:|
| **Conditions**																									 |
| Name of concept exists in glossary as synonym                                	       |  Y |  N |  N |  N |  N |  N |
| Steam of concept exists in glossary as concept                               	       |  - |  Y |  Y |  N |  N |  N |
| Name equals stem                                                             	  	   |  - |  Y |  N |  Y |  N |  - |
| User chooses "add to glossary as concept"                                    	   	   |  - |  - |  - |  Y |  Y |  N |
| User chooses "add to existing concept as synonym"                             	   |  - |  - |  - |  N |  N |  Y |
| **Quick fixes**                                                                								     |
| Create concept and add it to the glossary                                      	   |    |    |    |  X |    |    |
| Create synonym and add it to the concept whose Name equals the steam          	   |    |    |  X |    |    |    |
| Reference existing concept                                                	   |    |  X |    |    |    |    |
| Reference existing synonym                                                 	   |  X |    |    |    |    |    |
| Create concept with the steam as name and add the concept as synonym                 |    |    |    |    | X  |    |
| User chooses existing concept. The concept will be added as synonym to this concept  |    |    |    |    |    | X  |

For example the rule 6 (R6) leads to a quick fix where the user has to choose an existing concept. The found concept will be added as synonym to the existing concept. This quick fix is only shown if the concept found is not present in the glossary (not as synonym and not as concept) and the user choose to add this concept to an existing concept as synonym. It does not matter in this case if the concept is the stem or an inflected form of the word. On the contrary, for the rules 4 and 5 this does matter. If the user chooses "add to glossary as concept" and the name of the concept is the stem of the word, we provide a quick fix which creates a new concept with the name of the found concept as name (R4). Otherwise, if the name of the new concept is not the stem and the user chooses the same, we provide a quickfix which creates a new concept with the steam as name and add the found concept as synonym to the newly created (R5).
The final step is always to encapsulate the found concept in quotation marks and therefore reference a glossary concept or one of its synonyms.   

### Annotate glossary concepts and provide quick fixes 
The behavior described in the previous section will be realized by a validator and a quick fix provider. The validator is responsible for the evaluation of the conditions and the annotation of the found concepts with a warning that can be fixed by one or more quick fixes.

The following check finds verbs in the `RequirementEnd` similar to that one described in part two of this series. It collects all information needed for the evaluation of the conditions described in the decision table.
	
	@Check(CheckType.NORMAL)
	def extractFunctionFromObjectWithDetails(RequirementEnd end) {
		val text = end.objectWithDetails
		val string = converter.textToString(text)
		val pattern = '(?$verb[pos:VB|pos:VBD|pos:VBG|pos:VBN|pos:VBP|pos:VBZ])'
		val result = tokenRegex.match(string, pattern)
		val tokensByGroup = result.tokensByGroup
		val verbGroupsFound = tokensByGroup.get("verb")
		for (verbs : verbGroupsFound) {
			var String verb = verbs.head.word
			var String lemma = verbs.head.lemma
			var verbPosition = verbs.head.begin
			if (!isReference(verb, text)) {
				val existingFunctions = getParentForEObject(end, Root).glossary.concepts.filter(typeof(Function)).toList
				showFunctionQuickFixes(existingFunctions, text, verb, verbPosition, lemma)
			}
		}
	}

For each verb found the check retrieves the `verb` and the `lemma` from the NLP result and stores the position of the verb in the list of found verbs. This position will be used later to determine the position of the verb in the free text that will be annotated. If the found verb is not a reference to a concept or synonym, the check retrieves all existing functions from the glossary. With these information the method `showFunctionQuickFixes` is called. 

`showFunctionQuickFixes` determines the quick fix to show by evaluating the first three conditions of the decision table. The conditions of rule 6 are the same than the conditions for the rules 5 and 6 except the ones related to user interaction. Therefore, we provide additionally the quick fix resulting from rule 6 if the rules 4 and 5 apply and let the user choose one of them.  

	def showFunctionQuickFixes(List<Function> functions, TextWithConceptsOrSynonyms text, String verb, int verbPos, String lemma) {
		val synonyms = functions.map[f|f.synonyms].flatten.toList
		val synonymNames = synonyms.map[name].toList
		val functionNames = functions.map[name].toList
		val offset = calculateOffset(text, verb, verbPos); 
		val length = verb.length
		val message = "Function " + verb + " found"		
		if (synonymNames.contains(verb)) {
			// rule 1 
			acceptWarning(message, text, offset, length, REFERENCE_CONCEPT_OR_SYNONYM, verb)
		} else if (functionNames.contains(lemma) && verb.equals(lemma)) {
			// rule 2 
			acceptWarning(message, text, offset, length, REFERENCE_CONCEPT_OR_SYNONYM, verb)
		} else if (functionNames.contains(lemma) && !verb.equals(lemma)) {
			// rule 3
			acceptWarning(message, text, offset, length, ADD_AS_SYNONYM_FOR_EXISTING_FUNCTION, verb, lemma)
		} else if (!functionNames.contains(lemma) && verb.equals(lemma)) {
			// rule 4 & 6
			acceptWarning(message, text, offset, length, ADD_AS_NEW_FUNCTION, verb, lemma)
			acceptWarning(message, text, offset, length, CHOOSE_FUNCTION_AND_ADD_AS_SYNONYM, verb)
		} else if (!functionNames.contains(lemma) && !verb.equals(lemma)) {
			// rule 5 & 6 
			acceptWarning(message, text, offset, length, CREATE_NEW_FUNCTION_AND_ADD_AS_SYNONYM, verb, lemma)
			acceptWarning(message, text, offset, length, CHOOSE_FUNCTION_AND_ADD_AS_SYNONYM, verb)
		}
	}

If a rule applies, we annotate a range of the resource with a warning using the method `acceptWarning`. We provide this method with a warning `message`, the object to annotate (`text`) as well as the `offset` and `length` of the annotation range which means the position and the length of the found verb in the textual representation of the `RequirementEnd`. Furthermore, we have to provide an issue code which is used to identify the corresponding quick fix (e.g. `REFERENCE_CONCEPT_OR_SYNONYM`) and additional issue data (`verb`, `lemma`) that is needed by the quick fix to solve the issue. The issue codes are stored in public static variables.       

	public static val ADD_AS_NEW_FUNCTION = "INTRODUCE_FUNCTION"
	public static val CREATE_NEW_FUNCTION_AND_ADD_AS_SYNONYM = "INTRODUCE_FUNCTION_AND_SYNONYM"
	public static val CHOOSE_FUNCTION_AND_ADD_AS_SYNONYM = "INTRODUCE_FUNCTION_SYNONYM"
	public static val ADD_AS_SYNONYM_FOR_EXISTING_FUNCTION = "INTRODUCE_SYNONYM_FOR_EXISTING_FUNCTION"
	public static val REFERENCE_CONCEPT_OR_SYNONYM = "REFERENCE_CONCEPT_OR_SYNONYM"

We only have to define five issue codes, because the quick fix for the referencing of existing concepts and synonyms is the same.

### Quick fixes 
The quick fixes are implemented in the generated class <YourLanguageName>QuickfixProvider located in the ui project. It is possible to provide multiple fixes for one issue code. A fix is annotated with the annotation `@Fix` and a reference to the issue code defined in the validator. 

The following example shows the fix for the rule 6. The first parameter of the `accept` method provided by the `IssueResolutionAcceptor` is the `issue` which contains data related to the issue. For example the line number, the offset, the severity and the additional issue data. The three following parameters are the label, the description and the icon of the quick fix shown in the UI. To implement the fix we have to modify the document content. The modification is implemented in the IModification which provides access to the document by a IModificationContext (`context`).  

	@Fix(MyNaturalLanguageValidator::CHOOSE_FUNCTION_AND_ADD_AS_SYNONYM)
	def chooseFunctionAndAddAsSynonym(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue, 'Choose Function and add as synonym', 'Choose Function and add as synonym', 'choose.png') [ context |
			val verb = issue.data.head
			val modified = context.xtextDocument.modify(
				[ resource |
				val model = resource.contents.filter(typeof(Root)).head
				val functions = model.glossary.concepts.filter(typeof(Function)).toList
				val functionNames = functions.map[name].toList
				val dialog = showSelectionDialog(functionNames, DIALOG_TITLE.replace(":CONCEPT", "Functions"))
				if (dialog.result == null) {
					return false
				}
				val chosenFunctionName = dialog.result.head as String
				val chosenFunction = functions.filter(a|a.name.equals(chosenFunctionName)).head
				val synonym = <YourLanguageName>Factory.eINSTANCE.createFunctionSynonym
				synonym.name = verb
				chosenFunction.synonyms.add(synonym)
			])
			if (modified){		
				val reference = "\"" + verb + "\""
				val text = context.xtextDocument.get(issue.offset, issue.length)
				val positionInText = text.indexOf(verb)	
				context.xtextDocument.replace(issue.offset + positionInText, verb.length, reference)
			}
		]
	}

For this fix, we are using Xtext’s IDocument API. After retrieving the `verb` from the `issue` data, we call the `modify` method on the document providing an implementation of the [IUnitOfWork](http://download.eclipse.org/modeling/tmf/xtext/javadoc/2.9/org/eclipse/xtext/util/concurrent/IUnitOfWork.html) interface which overrides the method boolean exec(XtextResource `resource`). A unit of work acts as a transaction block, which can be used to get read and write access to the parsed model of the document. Inside the exec- method we collect all existing function names and show a selection `dialog`. The `dialog` allows the user to choose the name of the function for that we will create the synonym.   

	def showSelectionDialog(List<String> elements, String title) {
		val shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();
		val dialog = new ConceptSelectionDialog(shell, elements);
		dialog.setInitialPattern("?*")
		dialog.setTitle(title)
		dialog.open
		return dialog
	}

To initialize the `ConceptSelectionDialog` we retrieve the workbench window's `shell` and provide the function names. After the customization of the title and the search pattern we `open` the dialog. The `open` method  is blocking. This means it waits until the window is closed by the end user. The `ConceptSelectionDialog` allows the user to select and search for the function by its name. It is an implementation of the abstract class [FilteredItemsSelectionDialog](http://help.eclipse.org/juno/index.jsp?topic=%2Forg.eclipse.platform.doc.isv%2Freference%2Fapi%2Forg%2Feclipse%2Fui%2Fdialogs%2FFilteredItemsSelectionDialog.html) which is explained in the Eclipse [Platform Plug-in Developer Guide](http://help.eclipse.org/mars/index.jsp?topic=%2Forg.eclipse.platform.doc.isv%2Fguide%2Fdialogs_FilteredItemsSelectionDialog_example.htm).

After the user closed the `dialog`, we return the dialog and make sure the user selected a function, otherwise we will stop the modification by returning false. For the chosen function we create the new `synonym` with the `verb` as name. For the creation of the synonym we use the singleton model factory instance of our language.     
If the modification was successful, we encapsulate the `verb` in quotations marks to convert it into a `reference`. In the next step, we get the position of the `verb` inside the annotated `text` and finally we replace the `verb` by the `reference` to link it with the newly created synonym. 

### Summary 
In this part we saw how to support the user keeping the glossary and the domain specific concepts mentioned in the requirements in sync. We defined a set of rules which define under what conditions which quick fix is provided to the user. To evaluate the conditions we implemented a validator. Furthermore, this validator annotates the findings and provides the correct quick fix. The quick fix itself showed how to change the current document and its model in a transactional safe way, how to create new model elements and how to integrate dialogs into quick fixes.

This series showed how to create a controlled natural language for software requirements using Xtext. The language controls the use of natural language by a fixed syntax for requirements which contains free text parts in order to allow the user to express the requirements in natural language. These free text parts are validated using natural language processing techniques. Furthermore the language supports the user thru providing semi-automatic quick fixes in order to keep the glossary in synv with the requirements and therefore to esthablish a common language for the domain.    
