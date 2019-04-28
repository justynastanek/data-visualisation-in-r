rm(list=ls())
library(officer)
library(graphics)
library(lubridate)

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
plot(x = wigData$Data,y = wigData$Otwarcie, type = "l", col = "#00008B", main = "Szeregi czasowe cen", xlab = "Data", ylab = "Cena",
    col.main = "#00008B", col.lab = "#00008B", cex.lab = 1.5, cex.main = 2)
lines(x = wigData$Data, y = wigData$Najwyzszy, col = "#8B6508")
lines(x = wigData$Data, y = wigData$Najnizszy, col = "#006400")
lines(x = wigData$Data, y = wigData$Zamkniecie, col = "#8B0000")
grid(nx = 6, ny = 8, col = "gray", lty = "dotted")
legend(x="bottomright", legend=c("Otwarcie", "Najwy¿szy", "Najni¿szy", "Zamkniêcie"), col=c("#00008B", "#8B6508", "#006400", "#8B0000"), lty=1, cex=1.5,
      text.col = c("#00008B", "#8B6508", "#006400", "#8B0000"))
dev.off()

#slide2
my_pres <- add_slide(my_pres,layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "title", str = "Szeregi czasowe")
my_pres <- ph_with_text(my_pres,type = "ftr", str = "Data visualisation in R")
my_pres <- ph_with_text(my_pres,type = "dt", str = format(Sys.Date()))
my_pres <- ph_with_text(my_pres,type = "sldNum", str = "str. 2")
my_pres <- ph_with_img_at(my_pres, src = "plot1.png", left = 0.75 , top =1.35,  width = 8.5, height = 5.25)

#plot2
png("plot2.png", width = 900, height = 600)
plot(x = wigData$Data,y = wigData$Wolumen, type = "l", col = "#8B0000", main = "Szereg czasowy wolumenu", xlab = "Data", ylab = "Wolumen",
     col.main = "#8B4726", col.lab = "#8B4726", cex.lab = 1.5, cex.main = 2)
abline(h=mean(wigData$Wolumen), col = "grey12", lty = 2)
text(x = as.Date("1993-01-01"), y = mean(wigData$Wolumen)+25000000, "œrednia",  col="grey12", cex=0.75)
dev.off()

#slide3
my_pres <- add_slide(my_pres,layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "title", str = "Szeregi czasowe cd.")
my_pres <- ph_with_text(my_pres,type = "ftr", str = "Data visualisation in R")
my_pres <- ph_with_text(my_pres,type = "dt", str = format(Sys.Date()))
my_pres <- ph_with_text(my_pres,type = "sldNum", str = "str. 3")
my_pres <- ph_with_img_at(my_pres, src = "plot2.png", left = 0.75 , top =1.35,  width = 8.5, height = 5.25)

#plot3
png("plot3.png", width = 900, height = 600)
hist(wigData$Zamkniecie - wigData$Otwarcie, breaks = 8, col = '#FFF8DC', freq = F, border = "#8B0000", xlab = "Ró¿nica kursów zamkniêcia i otwarcia",
     ylab = "Gêstoœæ", main = "Histogram ró¿nic kursów zamkniêcia i otwarcia", col.main = "#8B0000", col.lab = "#8B0000", cex.lab = 1.5, cex.main = 2)
lines( density(wigData$Zamkniecie - wigData$Otwarcie), col = "#8B0000", lwd = 1)
dev.off()

#slide4
my_pres <- add_slide(my_pres,layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "title", str = "Histogram")
my_pres <- ph_with_text(my_pres,type = "ftr", str = "Data visualisation in R")
my_pres <- ph_with_text(my_pres,type = "dt", str = format(Sys.Date()))
my_pres <- ph_with_text(my_pres,type = "sldNum", str = "str. 4")
my_pres <- ph_with_img_at(my_pres, src = "plot3.png", left = 0.75 , top =1.35,  width = 8.5, height = 5.25)

#plot4
wigData$Dzien <- wday(wigData$Data, label=T, abbr=F)
levels(wigData$Dzien)
png("plot4.png", width = 900, height = 600)
boxplot(wigData$Zamkniecie - wigData$Otwarcie ~ wigData$Dzien, xlab="Dzieñ tygodnia", ylab="Ró¿nica kursów",col=c("#7FFFD4","#FFE4C4"),varwidth=T, 
        main = "Boxplot ró¿nic kursów max i min dla typów dni", cex.lab = 1.5, cex.main = 2, border = "#474747")
dev.off()

#slide5
my_pres <- add_slide(my_pres,layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "title", str = "Boxplot")
my_pres <- ph_with_text(my_pres,type = "ftr", str = "Data visualisation in R")
my_pres <- ph_with_text(my_pres,type = "dt", str = format(Sys.Date()))
my_pres <- ph_with_text(my_pres,type = "sldNum", str = "str. 5")
my_pres <- ph_with_img_at(my_pres, src = "plot4.png", left = 0.75 , top =1.35,  width = 8.5, height = 5.25)

#table1
otwarcie <- summary(wigData$Otwarcie)
zamkniecie <- summary(wigData$Zamkniecie)
najwyzszy <- summary(wigData$Najwyzszy)
najnizszy <- summary(wigData$Najnizszy)
table1 <- as.data.frame(rbind(otwarcie, zamkniecie, najwyzszy, najnizszy))

#slide6
my_pres <- add_slide(my_pres,layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with_text(my_pres,type = "title", str = "Podstawowe statystyki")
my_pres <- ph_with_text(my_pres,type = "ftr", str = "Data visualisation in R")
my_pres <- ph_with_text(my_pres,type = "dt", str = format(Sys.Date()))
my_pres <- ph_with_text(my_pres,type = "sldNum", str = "str. 6")
my_pres <- ph_with_table(my_pres,type = "body", value = table1, first_column = T)
?ph_with_table
#save in .pptx format
print(my_pres, target = "presentation.pptx")