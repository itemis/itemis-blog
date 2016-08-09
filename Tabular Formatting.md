#Tabular Formatting with the new Formatter API
With Xtext 2.8 a new Formatter API was introduced, which is way easier to use and more flexible than the old one. 
Instead of using the DSL's Grammar Access it is now possible to work directly on the elements inside your document. This article shows how the Formatter API can be used to format text in tables. As an example, a small DSL is defined that allows the specification on tables in Wiki syntax.

## Wiki Table Syntax
The [Wiki table markup](https://www.mediawiki.org/wiki/Help:Tables) is defined as follows:
<table>
<tr><td>|+</td><td>**table start**, *required*</td></tr>
<tr><td>{|</td><td>table **caption**, *optional*; only between **table start** and **table row**</td></tr>
<tr><td>|-</td><td>**table row**, *optional on first row*—wiki engine assumes the first row</td></tr>
<tr><td>!</td><td>**table header** cell, *optional*. Consecutive **table header** cells may be added on same line separated by double marks (`!!`) or start on new lines, each with its own single mark (`!`).</td></tr>
<tr><td>|</td><td>**table data** cell, *optional*. Consecutive **table data** cells may be added on same line separated by double marks (||) or start on new lines, each with its own single mark (`|`).</td></tr>
<tr><td>{|</td><td>**table end**, *required*</td></tr>
</table>

## Example
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

As you can see, this is not really formatted like a table. The aim is now to define a DSL for this table syntax und implement a Formatter which would format this to:

```
{|
 |-|Orange    |Apple
 |-|Bread     |Pie
 |-|ButterCake|Ice cream
|}
```

Here you can see the columns are aligned correctly, and the reference for this is the cell with the most characters inside.


##Grammar

Let's start with a small DSL which allows to define text in Wiki table syntax. The grammar for such a DSL looks like this:

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

There is a `Table` Element, which has an optional caption and multiple rows. Each row can have
different cells, which are of kind `HeaderCell` (starting with `!`) or `DataCell` (starting with `|`). The cells contain any content. This is defined by the datatype rule `Label`, which allows any terminal tokens as its content.

##Implementing the Formatter

A good introduction to the new formatter can be found in the presententation ["Xtext's New Formatting API"](`http://www.slideshare.net/meysholdt/xtexts-new-formatter-api`). For our introduction, we only need some functions mentioned there, 
which I will now explain in detail. 

First of all we have to enable the generation of a formatter stub class, since by default this is not enabled for a Xtext project. To get a stub implementation of the new formatter you can enable it by simply putting 

```
formatter={
	generateStub=true
}
```

inside the `.mwe2` workflow of the language. After regenerating the Xtext implementation you get an Xtend class, which is automatically bound inside the `Abstract<MyDSL>RuntimeModule`
of the language and extends the `AbstractFormatter2` class. 

Inside this class you can implement a method, which has the following body for each element of the grammar.

```
def dispatch void format(Table table, extension IFormattableDocument document) {
}
```
####Add line breaks for the table

For our task, there are several tasks to solve. 

The first one is that there should be a new line after the opening keyword of the table and before the closing keyword. This is quite easy to solve. For each semantic element we can get the region of this element using the `ITextRegionExtensions` which are automatically available if we extend from `AbstractFormatter2`.

There we can implement the following statements

```
table.regionFor.keyword("{|").append[newLine]
table.regionFor.keyword("|}").prepend[newLine]
```

With the extension method `regionFor` we get the region and the keyword we can get using `keyword("..")`. With the two methods
`append` and `prepend` from the `IFormattableDocument` class we can as the method indicates append or prepend a new line.

####Format the rows

The second task is to do this also for the rows. Each row should start with the keyword and a line break afterwards. The command
is quite similar and looks like this 

```
row.regionFor.keyword("|-").prepend[newLine]
```
For this we can iterate over all the rows inside a table.

####Automatically align the columns

The most challenging task is to automatically align the columns based on the widest content of a column. 
To get the widest element inside a column, you can define this method:

```
/**
 * Computes the maximum length of the content in a table column.
 * @param table The table element
 * @param columnIndex Zero-based index of the table column
 * @return Maximum content length of the column
 */
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

If you use the three snippets above you can easily and very fast use the new API to implement a formatter for tables, which was nearly impossible with the old API. There are many convenience methods that really make your life way easier writing a formatter.

In a further blog post we will give a short introduction on how to test the formatter with a simple Xtend template and some basic JUnit tests.
