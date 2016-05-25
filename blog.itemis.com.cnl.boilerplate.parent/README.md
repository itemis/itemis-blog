# Xtext and controlled natural languages for software requirements 
Stakeholders usually document requirements informally, i.e. in natural language. Often using text processing programs which do not provide any input assistance related to the requirements and do not allow their automated validation or post-processing. This leads either to higher efforts for cost intensive and time consuming
human review processes or to reduced quality which can have a negative impact on subsequent development phases. To compensate these disadvantages of the usage of natural language in requirements documentation, various approaches exist. One of these approaches is to control the use of natural language by using templates in order to create acceptable requirements as they are written.

This series shows how to create a controlled natural language based on sentence templates (boilerplates) using Xtext. The language will allow the usage of free text in combination with references to model elements at specific parts of the boilerplates. In comprehension to text processing programs the language will support the user through the usability functions of Xtex and will ensure that the requirements match the used boilerplates.

Part one of this series is about the formalization of informal natural language and the realization of the boilerplates in the Xtext grammar. Besides the grammar we will see how to use strings as cross-references in a convenient and readable way.
Part two deals with the validation of the natural language requirements using Natural Language Processing (NLP). This part shows how to include external libraries into a Xtext project and how to use the validation API.
Finally, part three will show how to extract domain specific concepts from the free text parts of the boilerplates using NLP techniques. The focus of this part lies on the Quickfix API of Xtext.

## Part 1: Requirement boilerplates  
Requirement boilerplates aim to increase the quality of textual requirements by defining a sentence template with placeholders for specific words or phrases that define the particular requirement. There is a wide range of boilerplates used for requirements documentation. For example user stories in agile software development.

	As a <role>, I want <goal/desire> so that <benefit> 

Such boilerplates allow the documentation of requirements in a standardised way without the knowledge of a specific requirements language and therefore can be used by domain experts as well as requirements engineers. Furthermore, they reduce the risk of ambiguous, inconsistent or vague requirements arising from the use of natural language.

The boilerplate used in this series is similar to the one defined by the International Requirements Engineering Board ([IREB](https://www.ireb.org/)).  

<center>![boilerplate](https://github.com/itemis/itemis-blog/blob/boilerplate/blog.itemis.com.cnl.boilerplate.parent/images/boilerplate.png)</center>  
<center>Figure 1: The used [boilerplate](https://requirementstechniques.wordpress.com/documentation/requirements-templates/ "IREB Boilerplates").</center>

The following sentences are examples for requirements based on this template. Keywords are bold and references to model elements are encapsulated in quotes.  

- **The** `"printing module"` **shall** `"print"` `"charts"` and `"documents"`.
- **If** the `"analyst"` created the `"chart"` or `"document"` the `"printing module"` **shall** **provide** **the** `"analyst"` **with the ability to** `"print"` this `"chart"` or `"document"`.
- **If** the `"charts"` where created by someone else the `"printing module"` **shall** hide the `"print button"`.
- **The** `"printing module"` **will** **provide the** `"client"` **with the ability to** `"print"` `"documents"`.
- **If** the licence is basic the `"printing module"` **will provide the** `"client"` **with the ability to** `"print"` `"greyscale documents"`.

In order to realize such a language we have to define a Xtext grammar which should look as close as possible like natural language.   

### Grammar
The Grammar consists of referable entities and glossary entries, two types of boilerplates and the rules needed to use free text.

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
	
Since an Independent System Activity only consists of a process phrase we don't need to create a separate rule for it. Instead, these informations are captured in the attribute 'objectWithReferences' of the Type `TextWithGlossaryEntriesOrSynonyms` in the rule `RequirementEnd`.

	RequirementEnd:
		ai=ActorInteraction? objectWithDetails=TextWithGlossaryEntriesOrSynonyms '.';

Such `TextWithGlossaryEntriesOrSynonyms` has the same structure than `TextWithReferences` but only `GlossaryEntries` and their synonyms can be referenced. Such a glossary entry can be a `Function` representing a `"process"` or a `DomainObject` representing an `"object"` in figure 1. 

	Glossary:
		{Glossary} 'Glossary' elements+=(GlossaryEntry)*;
	
	GlossaryEntry:
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

Synonyms are needed to ensure a consistent usage and description of terms and also to ensure to readability of the requirements when it comes to flexions or singular and plural nouns. They are nested in GlossaryEntries. This leads us to the next topic. The referencing of such nested types.      

### Cross-References using simple names 
Xtext uses by default full qualified names for cross-referencing nested types. This means for our language if you want to reference the synonym of a `GlossaryEntry` you have to use a dot notation. The following example demonstrates this for the object "document" and his synonym "documents". 

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

In the next part we will see how to further control the usage of natural language specially in the free text parts of the boilerplates. According to figure 1, we will make sure that each requirement contains a free text phrase which describes a process or `Function` of the system and at least one involved `DomainObject`. Since functions can be described by verbs and domain objects by nouns, we will use NLP techniques to ensure that each boilerplate contains exactly one `Function` and at least one `DomainObject`. Therefore, we will integrate an external library and define validation rules based on the Xtext validation API.  

## Part 2: Controlled use of natural language
In the first part of this series we defined a Xtext grammar based on boilerplates in order to control the use of natural language and create acceptable requirements as they are written. Another approach to improve the quality of textual requirements is the use of Natural Language Processing (NLP) techniques to control their quality in terms of grammar and vocabulary after they have been written. 

NLP techniques related to this post are Part-Of-Speech (POS)
tagging which categorizes the tokens (words or phrases) of a sentence into different types like verbs or nouns and stemming which finds the root (stem) of a word for inflected forms, for example the singular for a plural word. Due to the fixed grammatical structure of the boilerplates defined by our Xtext grammar, an expensive grammatical analysis using NLP techniques is not necessary.

We will use these techniques to define constraints for the use of domain specific concepts in the free text parts of the boilerplates. In our approach these concepts are objects and functions which appear as nouns and verbs in the free text parts of the boilerplates.

According to our grammar that means that each `RequirementEnd` must contain exactly one verb representing a `Function` and at least one object which represents an `DomianObject` in our `Glossary`. 

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

The POS tagging is done by a POS tagger. A POS tagger determines the part-of-speech tag (POS-tag) of a token based on the sentence context. Therefore, we have to create toString methods for all elements related to the boilerplates in order to provide complete sentences as input for the tagger.  

### NLP framework integration
In order to validate natural language we use the framework [TokensRegex](http://nlp.stanford.edu/software/tokensregex.html) from the [Stanford Natural Language Processing Group](http://nlp.stanford.edu/). Its part of the [Stanford CoreNLP](http://stanfordnlp.github.io/CoreNLP/) suite and provides an API which allows the use of cascaded regular expressions over tokens. Basically this means the framework allows pattern matching over sentence phrases or words using regular expression and POS-Tags. If you want to use it directly you can integrate it via maven.

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

Finaly we add the following line to the `build.properties` of the runtime project to make sure the jar is included in our eclipse plugin.

	jars.extra.classpath = lib/POSRegex-0.0.2.jar    

### Natural language validation
With the model-to-text transformation and the natural language library we are now able to validate the usage of domain specific concepts. We separate the natural language validation from the model based validation rules by defining a new class extending `Abstract<YourLanguageName>Validator `in the validation package of the runtime project. Xtext allows the use of multiple validators by the annotation `@ComposedChecks`. In order to register our new validator we annotate the `<YourLanguageName>Validator` in the following way.

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

The natural language validation can be time consuming. Therefore, we annotate the method with the annotation `CheckType.NORMAL` to ensure that the check is only executed when the user saves the document. In the first step we define a `pattern` containing a non-capturing group called `verb` which matches multiple types of verb POS-Tags (VB=Verb base form, VBD=Verb past tense, VBG=Verb gerund or present participle,...). A detailed description of the syntax can be found in the TokensRegex [documentation](http://nlp.stanford.edu/software/tokensregex.html#Usage). The supported POS-tags are equivalent to the POS-tags defined by the University of Pennsylvania which are described [here](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html). In the next step we get the `Requirement` instance from our model, translate it to text and run the pattern matching. The returned `result` contains all found verbs in the `verb` group. In the next step we count the occurrence of these verbs in the free text (`objectWithDetails`) part of the boilerplate. If not exactly one verb is found, we mark the `objectWithDetails` with an error. 

We can do this kind of validation also for the domain objects. The following pattern could be used to check that each `objectWithDetails` contains a domain object with a name consisting of one or two nouns.

	(?$noun[pos:NN|pos:NNS|pos:NNP|pos:NNPS]{1,2})      

### Summary and outlook
In this part we saw how to validate the use of domain specific concepts inside the free text parts of the boilerplates. Therefore, we integrated a natural language framework and used it together with the validation API of Xtext.  

In Part 3 we will extend the use of NLP techniques. We will identifie domain specific concepts, allow the user to extract them from the free text parts of the boilerplates and add them to the glossary. To support the user during this process, we will offer multiple automatic actions using the Xtexts Quickfix API. 

## Part 3: Extracting and creating glossary entries   

<!--	
Such a boilerplate constrains the structure of a sentence by the definition of keywords and placeholders.  
The most Xtext languages are designed to generate a formal output for example source code in one ore more target languages. This post is not about such languages. Instead I will show you how to create a language for requirements documentation on base of sentence templates (boilerplates). The language will combine keywords, informal natural language (free text) and references to entities. The resulting language will contrain the use of free text and therefore can be described as contrained natural language. 

The boilerplate starts with an optional precondition followed by the name of the system under discussion and a liability which can be "must", "should" or "will". The next part can be an user interaction or an independent system activity. An user interaction starts with the keyword "provide" followed by the name of the actor and the keywords "with", "the", "ability" and "to". These keywords are followed by a process term. Such a process term discribing a functionality of the system under discussion. In contrast to an user interaction an independent system activity consists only of such a process term. The next part of the boilerplate is the object which is processed or used. The boilerplate ends with optional details about the object.
-->
