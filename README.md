# HandOn-NLP

First, imporatnt thing to do is to install all needed packages. (Run all install.packages(...) commands)

After packages are installed it is needed to load libraries. (Run all library(...) commands)

To make all of functions created by me (getWordWithTag, getCountWithTag, createGraph) it is first needed to run all the function above, to get the document variable filled with list of words and their tags. 

It is needed to run code that creates three functions: getAnnotaionsFromDocumen, getAnnotatedMergedDocument, getAnnotatedPlainTextDocument. 
Once we have these function created, it is needed to create Corpus. 

We start applying function mentioned above to the corpus. 

First we apply getAnnotationsFromDocumet to corpus by running:
```r
annotations = lapply(corpus, getAnnotationsFromDocument)
```
```html
<h2>Example of code</h2>

<pre>
    <div class="container">
        <div class="block two first">
            <h2>Your title</h2>
            <div class="wrap">
            //Your content
            </div>
        </div>
    </div>
</pre>
```
Next, we apply two other functions to corups with annotations by running:
corpus.tagged = Map(getAnnotatedPlainTextDocument, corpus, annotations)

corpus.taggedText = Map(getAnnotatedMergedDocument, corpus, annotations)

corpus.taggedText is enabling us to see whole text with tag assigned to every word. 
It is possible to see it by running command corpus.taggedText[[1]]

And corpus.tagged is enabling us to use some useful functions with tagged document. 
Function that is used here is access to taged words - tagged_words() function 

For this I saved corpus.tagged in variable and return value from function tagged_words() into another variable we will work with in function created by me, with next part of code:
##There are functions for accessing parts of an AnnotatedPlainTextDocument.
doc = corpus.tagged[[1]] 

##For accessing its tagged words.
head(tagged_words(doc))

##new variable with taged words to work with
document = tagged_words(doc)

After this is done it is only left to run code for creating all three of my function and the they are ready to run. For every function arguments are document variable - list of words and their tags and string that specifiy which tag we want to use. 




