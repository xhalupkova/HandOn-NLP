getwd()

setwd("D:/Users/petra/Erasmus+/IS/Natural language processing")

install.packages("rJava")
install.packages("openNLP")
install.packages('ggplot2')

# The openNLPmodels.en library is not in CRAN; it has to be installed from another repository
install.packages("openNLPmodels.en", repos = "http://datacube.wu.ac.at")


# Needed for OutOfMemoryError: Java heap space 
library(rJava)
.jinit(parameters="-Xmx4g")

library(NLP)
library(openNLP) 
library(openNLPmodels.en)
library(tm)
library(ggplot2)

getAnnotationsFromDocument = function(doc){
  x=as.String(doc)
  sent_token_annotator <- Maxent_Sent_Token_Annotator()
  word_token_annotator <- Maxent_Word_Token_Annotator()
  pos_tag_annotator <- Maxent_POS_Tag_Annotator()
  y1 <- annotate(x, list(sent_token_annotator, word_token_annotator))
  y2 <- annotate(x, pos_tag_annotator, y1)
  parse_annotator <- Parse_Annotator()
  y3 <- annotate(x, parse_annotator, y2)
  return(y3)  
} 

getAnnotatedMergedDocument = function(doc,annotations){
  x=as.String(doc)
  y2w <- subset(annotations, type == "word")
  tags <- sapply(y2w$features, '[[', "POS")
  r1 <- sprintf("%s/%s", x[y2w], tags)
  r2 <- paste(r1, collapse = " ")
  return(r2)  
}

getAnnotatedPlainTextDocument = function(doc,annotations){
  x=as.String(doc)
  a = AnnotatedPlainTextDocument(x,annotations)
  return(a)  
} 

source.pos = DirSource("D:/Users/petra/Erasmus+/IS/Natural language processing/review_polarity_small/txt_sentoken/my_txt", encoding = "UTF-8")
corpus = Corpus(source.pos)

annotations = lapply(corpus, getAnnotationsFromDocument)

corpus.tagged = Map(getAnnotatedPlainTextDocument, corpus, annotations)
corpus.tagged[[1]] 

corpus.taggedText = Map(getAnnotatedMergedDocument, corpus, annotations)
corpus.taggedText[[1]]

##There are functions for accessing parts of an AnnotatedPlainTextDocument.
doc = corpus.tagged[[1]] 

##For accessing its tagged words.
head(tagged_words(doc))

##new variable with taged words to work with
document = tagged_words(doc)
document

##Function to get all the words with specific tag put as argument
getWordWithTag = function(document, tag){
  
  len<-1
  
  while(len < length(document)){
    value<-document[len]
    value2<-sub(".*/", "", value)
    if(value2[2] == tag){
      print(value2[1])
    }
    len<-len + 1
  }
}

getWordWithTag(document, "IN")

##Function to get number of the words with specific tag put as argument
getCountWithTag = function(document, tag){
  
  len <- 1
  count <- 0
  
  while(len < length(document)){
    value <- document[len]
    value2 <- sub(".*/", "", value)
    if(value2[2] == tag){
      count <- count + 1
      ##print(count)
    }
    len<-len + 1
  }
  print(count)
  
}

getCountWithTag(document, "VBN")

##Function to get all the words with specific tags put as argument and also graph with tags names and count
createGraph = function(document, tag1, tag2, tag3){
  
  len <- 1
  count1 <- 0
  count2 <- 0
  count3 <- 0
  
  while(len < length(document)){
    value <- document[len]
    value2 <- sub(".*/", "", value)
    if(value2[2] == tag1){
      count1 <- count1 + 1
      
    } else if (value2[2] == tag2) {
      count2 <- count2 + 1
    }
    else if (value2[2] == tag3) {
      count3 <- count3 + 1
    }
    len<-len + 1
  }
  print(count1)
  print(count2)
  print(count3)
  
  # Create data
  data <- data.frame(
    tag=c(tag1,tag2,tag3) ,  
    count=c(count1,count2,count3)
  )
  
  # Barplot
  ggplot(data, aes(x=tag, y=count)) + 
    geom_bar(stat = "identity", fill="steelblue") +
    theme_minimal()
  
}

createGraph(document, tag1 = "RB", tag2 = "JJR", tag3 = "VBN")
