rm(list=ls())
library(officer)
library(graphics)

#create Power Point presentation
my_pres <- read_pptx()

#add first slide
my_pres <- add_slide(my_pres,layout = "Title Slide", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "ctrTitle", str = "Raport opisuj¹cy zbiór wig_d.csv")
my_pres <- ph_with_text(my_pres, type = "subTitle", str = "Autor: JS")

#load dataset
wigData <- as.data.frame(read.csv(file = "https://stooq.pl/q/d/l/?s=wig&i=d", sep="," , dec="." , header=T , stringsAsFactors=F))
wigData$Wolumen[is.na(wigData$Wolumen)] <- 0
wigData$Data <- as.Date(wigData$Data)
write.table(wigData , file = "wigData.csv" , sep = ";" , dec = "." , row.names = F)

#save in .pptx format
print(my_pres, target = "officer_demo.pptx")



