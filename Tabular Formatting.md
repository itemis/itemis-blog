#Format Tables with the new Formatter API
With Xtext 2.8 a new Formatter API was introduced, which is way easier to use than the old one. 
Instead of using the GrammarAccess it is now possible to work directly on the elements inside your document.

##Grammar
The grammar for this example is based on the wiki syntax for tables, which can be found here
`https://www.mediawiki.org/wiki/Help:Tables`

The grammar built from these rules looks like this:
```
Document:
	elements+=Table*
;

Table: {Table}
	'{|' 
	caption=Caption?
	rows += Row* 
	'|}'
;

Caption:
	'|+' label=Label
;

Row: {Row}
	'|-' cells+=Cell*
;

Cell:
	HeaderCell | DataCell
;

HeaderCell:
	'!' text=Label	
;

DataCell:
	'|' text=Label
;

Label: (ID|STRING|INT|WS|ANY_OTHER)*;
```
There is a Table-Element, which has an optional caption and multiple rows. Each row can have
different cells, which are HeaderCells (starting with !) or DataCells (starting with |). 
An example for a table filled with contents could be the following one:

```
{|
|-
|Orange
|Apple
|-
|Bread
|Pie
|-
|ButterCake
|Ice cream 
|}
```

As you can see, this is not really formatted like a table and if you do not implement any Formatter at all, 
the table will be displayed like this:
```
{| |- | Orange | Apple |- | Bread | Pie |- | ButterCake | Ice cream |}
```

The readability of this is very bad and should more look like this:
```
{|
|-|Orange    |Apple
|-|Bread     |Pie
|-|ButterCake|Ice cream
|}
```
Here you can see the columns are aligned correctly, and the reference for this is the cell with the most characters inside.
##Introduction to the new formatter
A good introduction to the new formatter can be found here `http://www.slideshare.net/meysholdt/xtexts-new-formatter-api`

For our introduction, we only need some functions mentioned there, which I will now explain in detail. 
###How to enable the formatter?
To get a stub implementation of the new formatter you can enable it by simply putting 
```
formatter={
	generateStub=true
}
```
inside the workflow of the language. Afterwards you get a generated Xtend class, which is automatically bound inside the AbstractRuntimeModule
of the language and extends the AbstractFormatter2 class. 
###Implement the formatter for the table
Inside this class you can implement a method, which has the following body for each element of the grammar.
```
def dispatch void format(Table table, extension IFormattableDocument document) {
}
```
####Add line breaks for the table
For our task, there are several problems to solve. 
The first one is, that there should be a new line after the opening keyword of the table and before the closing keyword.

This is quite easy to solve. For each semantic element we can get the region of this element using the ITextRegionExtensions
which are automatically available if we extend from AbstractFormatter2.
There we can implement the following statements
```
table.regionFor.keyword("{|").append[newLine]
table.regionFor.keyword("|}").prepend[newLine]
```
With the extension method `regionFor`, we get the region and the keyword we can get using `keyword("..")`. With the two methods
`append` and `prepend` from the `IFormattableDocument` class we can as the method indicates append or prepend a new line.
####Format the rows
The second task is to do this also for the rows. Each row should start with the keyword and a line break afterwards. The command
is quite similar and looks like this `row.regionFor.keyword("|-").prepend[newLine]`. For this we can iterate over all the
rows inside a table.

####Automatically align the columns
The hardest task is to automatically align the columns, based on the widest content of a column. 
To get the widest element inside a column, you can use this method:
```
def getMaxColumnLength(Table table, int columnIndex) {
	var maxLength = 0
	for (row : table.rows) {
		var cellLength = row.cells.get(columnIndex).regionForEObject.length
		if (cellLength > maxLength)
			maxLength = cellLength
	}
	return maxLength
}
```
Once we have this value, you can calculate the width of the actual cell you want to format and substract the values. 
The following snippet provides exactly this functionality.
```
val cellLength = table.getMaxColumnLength(counter) - cell.regionForEObject.length
cell.regionFor.feature(TablePackage.Literals.CELL__TEXT).append[space = Strings.repeat(" ", cellLength)]
```

####Conclusion
If you use the three snippets above you can easily and very fast use the new API to implement a formatter for tables, which was
nearly impossible with the old API. There are many convenience methods, which really make your life way easier writing a formatter.
In the next blog post we will give a short introduction how to test the formatter with a very simple Xtend template and some basic JUnit tests.