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

#plot1
png("plot1.png", width = 900, height = 600)
plot(x = wigData$Data,y = wigData$Otwarcie, type = "l", col = "#00008B", main = "Szeregi czasowe cen i wolumenu", xlab = "Data", ylab = "Cena",
    col.main = "#00008B", col.lab = "#00008B", cex.lab = 1.5, cex.main = 2)
lines(x = wigData$Data, y = wigData$Najwyzszy, col = "#8B6508")
lines(x = wigData$Data, y = wigData$Najnizszy, col = "#006400")
lines(x = wigData$Data, y = wigData$Zamkniecie, col = "#8B0000")
grid(nx = 6, ny = 8, col = "gray", lty = "dotted")
legend(x="bottomright", legend=c("Otwarcie", "Najwy¿szy", "Najni¿szy", "Zamkniêcie"), col=c("#00008B", "#8B6508", "#006400", "#8B0000"), lty=1, cex=1.5,
      text.col = c("#00008B", "#8B6508", "#006400", "#8B0000"))
dev.off()

#slide
my_pres <- add_slide(my_pres,layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "title", str = "Szeregi czasowe")
my_pres <- ph_with_text(my_pres,type = "ftr", str = "Data visualisation in R")
my_pres <- ph_with_text(my_pres,type = "dt", str = format(Sys.Date()))
my_pres <- ph_with_text(my_pres,type = "sldNum", str = "str. 2")
my_pres <- ph_with_img_at(my_pres, src = "plot1.png", left = 0.75 , top =1.35,  width = 8.5, height = 5.25)


#save in .pptx format
print(my_pres, target = "officer_demo.pptx")