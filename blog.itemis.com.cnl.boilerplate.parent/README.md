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
	
Since an Independent System Activity only consists of a process phrase we don't need to create a separate rule for it. Instead, these informations are captured in the attribute 'objectWithReferences' of the Type `TextWithGlossaryEntries` in the rule `RequirementEnd`.

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
			name = "blog.itemis.com.cnl.boilerplate.Boilerplate"
			fileExtensions = "bp"
			fragment = exporting.SimpleNamesFragment2 {}
			serializer = {
				generateStub = false
			}
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

	class BoilerplateUiModule extends AbstractBoilerplateUiModule {
	
		override Class<? extends AbstractEditStrategyProvider> bindAbstractEditStrategyProvider() {
			return MyAutoEditStrategy
		}
	}

### Summary and outlook  
In this post we saw how to realize boilerplates in the Xtext grammar and allow the usage of free text combined with references to entities in these boilerplates. The resulting language controls the use of natural language by defining a grammatical sentence structure and allows the user to document requirements in a standardized, convenient and readable way.  

In the next part we will see how to further control the usage of natural language specially in the free text parts of the boilerplates. According to figure 1, we will make sure that each requirement contains a free text phrase which describes a process or `Function` of the system and at least one involved `DomainObject`. Since functions can be described by verbs and domain objects by nouns, we gone use NLP techniques to ensure that each boilerplate contains exactly one `Function` and at least one `DomainObject`. Therefore, we will integrate a external library and define validation rules based on the Xtext validation API.  

## Part 2: Controlled use of natural language
In the first part of this series we defined a Xtext grammar based on boilerplates in order to control the use of natural language and create acceptable requirements as they are written. 

Another approach to improve the quality of textual requirements
is the use of Natural Language Processing (NLP) techniques to check their quality in terms of grammar and vocabulary after they have been written. NLP
techniques related to this post are Part-Of-Speech (POS)
tagging which categorizes the tokens of a sentence into different
types like verbs or nouns and stemming which finds the root (stem) of a word for inflected forms, for example the singular for a plural word. Due to the fixed grammatical structure of the boilerplates defined by our Xtext grammar, an expensive grammatical analysis using NLP techniques is not necessary.

We will use these techniques to define constraints for the use of domain specific concepts in the free text parts of the boilerplates. In our approach these concepts are domain objects and functions which appear as nouns and verbs in the free text parts of the boilerplates.

According to our grammar that means that each `RequirementEnd` must contain exactly one verb representing a `Function` and at least one object which represents an `DomianObject` in our `Glossary`. Therefore, we have to implement a model-to-text transformation which transforms the boilerplates from there reprensentation in the model to plain text. 

### Model transformation 


### Integrate external libraries 

### Defining validation rules 


## Part 3: Extracting and creating glossary entries   


<!--	
Such a boilerplate constrains the structure of a sentence by the definition of keywords and placeholders.  
The most Xtext languages are designed to generate a formal output for example source code in one ore more target languages. This post is not about such languages. Instead I will show you how to create a language for requirements documentation on base of sentence templates (boilerplates). The language will combine keywords, informal natural language (freetext) and references to entities. The resulting language will contrain the use of freetext and therefore can be described as contrained natural language. 

The boilerplate starts with an optional precondition followed by the name of the system under discussion and a liability which can be "must", "should" or "will". The next part can be an user interaction or an independent system activity. An user interaction starts with the keyword "provide" followed by the name of the actor and the keywords "with", "the", "ability" and "to". These keywords are followed by a process term. Such a process term discribing a functionality of the system under discussion. In contrast to an user interaction an independent system activity consists only of such a process term. The next part of the boilerplate is the object which is processed or used. The boilerplate ends with optional details about the object.
-->