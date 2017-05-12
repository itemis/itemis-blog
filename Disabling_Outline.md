# Disabling the outline in Xtext
There are several explanations on how to modify the outline view for your language, for example in the official [documentation](https://eclipse.org/Xtext/documentation/310_eclipse_support.html#outline).

But what do you do, if you want to disable the outline? Disabling the outline could sometimes be desired, as with very large files it takes very long to compute and the editor freezes.

## Dropping complete support
The first way to do this could be to drop the whole support for the outline. Therefore you can just override the binding to `IContentOutlinePage` in the `UiModule`by adding this snippet
```
override Class<? extends IContentOutlinePage> bindIContentOutlinePage() {
	return null;
}
```

But with this overridden binding the outline is gone for every file of your language, not only for the large ones. 

## Dropping the support for some files
If you want to drop the support of the outline just for very large files, you can override the method `createRoot` of the `OutlineTreeProvider`. In our example the outline should be disabled for files which have more than 10000 lines of code.

The snippet we need to add is the following one:
```
override createRoot(IXtextDocument document) {
    if(document.numberOfLines<10_000){
        super.createRoot(document)
    }
}
```

The method `createRoot` which triggers the creation of the outline is now only called, if the document has less than 10000 lines. 