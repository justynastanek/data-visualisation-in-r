rm(list=ls())
library(knitr)
library(markdown)
library(rmarkdown)
library(googleVis)

#set working directory first
#setwd()

# wygenerowanie pliku *.md
knit(input="RaportGoogleVis.Rmd", output="tmp.md") 

# Konwersja na zwykly dokument html
markdownToHTML(file="tmp.md", output="RaportGoogleVis.html", stylesheet='markdown.css')
