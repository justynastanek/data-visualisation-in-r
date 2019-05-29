rm(list=ls())
library(knitr)
library(markdown)
library(rmarkdown)
library(googleVis)

setwd('C:/Users/you/Desktop/SGH MGR/II semestr/Prezentacja i wizualizacja danych/homework1')

# wygenerowanie pliku *.md
knit(input="RaportGoogleVis.Rmd", output="tmp.md") 

# Konwersja na zwykly dokument html
markdownToHTML(file="tmp.md", output="RaportGoogleVis.html", stylesheet='markdown.css')
