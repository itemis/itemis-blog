# Xtext and contrained natural languages for software requirements 

This series shows how to create a constrained natural language based on sentence templates (boilerplate) using Xtext. The resulting language will allow the usage of natural language in combination with references to model elements at specific parts of the boilerplate. In comprehension to text processing programs the resulting language will support the user through the usability functions of Xtex and will ensure that the requirements match the used boilerplates. Furthermore the requirements will be mapped to a data model which allows there validation and post processing.  

Dann Part1:, Part2:, Part3: beschreiben 

## Part 1: Requirement boilerplates  
Requirement boilerplates aim to increase the quality of textual requirements by defining a sentence template with placeholders for specific words or phrases that define the particular requirement. There is a wide range of boilerplates used for requirements documentation. For example user stories in agile software development:

	As a <role>, I want <goal/desire> so that <benefit> 

Such boilerplates allow the documentation of requirements in an standardised way without the knowledge of a specific requirements language and therefore can be used by domain experts as well as requirements engineers. Furthermore they reduce the risk of ambiguous, inconsistent or vague requirements arising form the use of natural language.  

Often boilerplates are used with text processing programs which do not provide any input assistance related to the boilerplates and do not allow there automated validation or post-processing.    

This post shows how to create a language based on boilerplates using Xtext. The resulting language will allow the usage of natural language in combination with references to model elements at specific parts of the boilerplate. In comprehension to text processing programs the resulting language will support the user through the usability functions of Xtex and will ensure that the requirements match the used boilerplates. Furthermore the requirements will be mapped to a data model which allows there validation and post processing.  

### Boilerplate
The used boilerplate is similar to the one defined by the International Requirements Engineering Board ([IREB](https://www.ireb.org/)):  

<center>![boilerplate](file:images/boilerplate.png)</center>  
<center>Figure 1: The used [boilerplate](https://requirementstechniques.wordpress.com/documentation/requirements-templates/ "IREB Boilerplates").</center>

The following sentences are examples for requirements based on this template. Keywords are bold, references to modell elements are encapsulated in angle brackets and optional parts are in ecapsulated in square brackets:  

- **The** `<printing module>` **shall** `<print>` `<charts>` and `<documents>`.
- [**If** the `<analyst>` created the `<chart>` or `<document>` the] `<printing module>` **shall** **provide** **the** `<analyst>` **with the ability to** `<print>` this `<chart>` or `<document>`.
- **If** the `<charts>` where created by someone else the `<printing module>` **shall** hide the `<print button>`.
- **The** `<printing module>` **will** **provide the** `<client>`**with the ability to** `<print>` `<documents>`.
- [**If** the licence is basic the] `<printing module>` **will provide the** `<client>` **with the ability to** `<print>` `<greyscale documents>`.

### Grammar
The Grammar consists of entities, glossary entries, two types of boilerplates and the rules needed to use natural language.    
	
The Grammar defines the entities `Actor` and `System` which can be referenced in boilerplates by there name:

	Actor: 'Actor'  ':' name=Text 
	description = Description;
	
	System: 'System'  ':' name=Text 
	description = Description;

	Description: 'Description'  ':' text+=SentenceWithReferences*;

The user can use the type `Text` for the name of an entity which can consist of multiple words and is not limited by the Java-ID conventions. Keywords that should be used in Text must be added explicit:

	Text: ( 'To' |  'to' | 'A' | 'a' | 'the' | 'The' | WORD | ANY_OTHER)+;

 To add further informations for an entity the user can create a description for each entity using the type `SentenceWithReferences`. Such a sentence consists of `textWithReferences` and a `punctuation`: 
		
	SentenceWithReferences: textWithReferences=TextWithReferences punctuation=('.' | '!' | '?');     

`TextWithReferences` allows the combined use of references to entities and plain text. In order to recover the plain text representation of `TextWithReferences` the rule is defined as follows:   

	TextWithReferences:
		(onlyRefs+=[Entities|STRING]+ | 
		refBefore+=[Entities|STRING]* text+=Text 
		after+=EntitieCombination*
		finalRef+=[Entities|STRING]*);

	EntitieCombination:
		(refs+=[Entities|STRING]+ text+=Text);

References to entities have the type `STRING`. This allows the referencing of entities with a name consisting of mutliple words. For example the System "printing module".  

The core syntax elements of the language are the `Requirement` rules. The following rules are the realisation of the boilerplate shown in Figure 1.:   

	Requirement:
		ConditionalRequirement | UnconditionalRequirement;
	
	ConditionalRequirement:
		condition=Precondition system=[System|STRING] liability=Liability end=End;
	
	Precondition:
		conditional=Conditional condition=TextWithReferences;

	enum Liability:
		shall | should | will;

	UnconditionalRequirement:
		the='The' system=[System|STRING] liability=Liability end=End;
	
	ActorInteraction:
		provide='provide' the1='the'? actor=[Actor|STRING] ^with='with' the2='the' ability='ability' to='to';
	
Since an Independent System Activity only consists of a <process> we don't need to create a seperate rule for it. Instead these informations are captured in the attribute `objectWithReferences` of the Type `TextWithGlossaryEntries` in the rule `RequirementEnd`:

	RequirementEnd:
		ai=ActorInteraction? objectWithDetails=TextWithGlossaryEntriesOrSynonyms '.';

Such `TextWithGlossaryEntriesOrSynonyms` has the same structure than `TextWithReferences` but only `GlossaryEntries` and there synonyms can be referenced. Such a glossary entry can be a `Function` describing a process or a `DomainObject`: 

	Glossary:
		{Glossary} 'Glossary' elements+=(GlossaryEntry)*;

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

### Using simple names for Cross-References 
Xtext uses by default full qualified names for cross-referencing nested objects. This means for our language if you want to reference the synonym of an object you have to use dot notation. The following example demonstartes this for the Object with name "document" and the synonym "documents": 

	The "printing module" will provide the "client" with the ability to "print" "document.documents".

	Glossary
		Object: document
		Synonyms: documents	   

The use of such full qualified names would decrease the readability. To avoid this we add the `SimpleNameFragment2` to the lanuage part of Modeling Workflow Engine 2 (mwe2) file of the main project: 

		language = StandardLanguage {
			name = "blog.itemis.com.cnl.boilerplate.Boilerplate"
			fileExtensions = "bp"
			fragment = exporting.SimpleNamesFragment2 {}
			serializer = {
				generateStub = false
			}
		}

This allows the use of simple names	and the direct referencing of nested objects without using a dot notation.

### Summary and outlook  



### References
<a name="myfootnote1">1</a>:[The IREB boilerplate](https://requirementstechniques.wordpress.com/documentation/requirements-templates/ "IREB Boilerplates")

##Part 2: Natural language validation  

##Part 3: Extracting and creating glossary entries   


<!--	
Such a boilerplate constrains the structure of a sentence by the definition of keywords and placeholders.  
The most Xtext languages are designed to generate a formal output for example source code in one ore more target languages. This post is not about such languages. Instead I will show you how to create a language for requirements documentation on base of sentence templates (boilerplates). The language will combine keywords, informal natural language (freetext) and references to entities. The resulting language will contrain the use of freetext and therefore can be described as contrained natural language. 
Concrete manifestations of the boileplates are shown in listing 1.

The boilerplate starts with an optional precondition followed by the name of the system under discussion and a liability which can be "must", "should" or "will". The next part can be an user interaction or an independent system activity. An user interaction starts with the keyword "provide" followed by the name of the actor and the keywords "with", "the", "ability" and "to". These keywords are followed by a process term. Such a process term discribing a functionality of the system under discussion. In contrast to an user interaction an independent system activity consists only of such a process term. The next part of the boilerplate is the object which is processed or used. The boilerplate ends with optional details about the object.
-->