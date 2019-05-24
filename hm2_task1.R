rm(list=ls())

library(ggplot2)
library(ggimage)
library(gridExtra)
library(lubridate)
setwd('C:/Users/you/Desktop/SGH MGR/II semestr/Prezentacja i wizualizacja danych/homework1')

#load data
wigData <- as.data.frame(read.csv(file = "https://stooq.pl/q/d/l/?s=wig&i=d", sep="," , dec="." , header=T , stringsAsFactors=F))

wigData$Wolumen[is.na(wigData$Wolumen)] <- 0

wigData$Data <- as.Date(wigData$Data)

#1. Visualisation of time series- prices and volumes

img <- "./sgh.png"

wyk1 <- (
  
  ggplot(wigData, aes(x = Data))
+
  geom_line(aes(y = Otwarcie, colour = "Otwarcie"))
+
  geom_line(aes(y = Najwyzszy, colour = "Najwyzszy"))
+
  geom_line(aes(y = Najnizszy, colour = "Najni¿szy"))
+
  geom_line(aes(y = Zamkniecie, colour = "Zamkniecie"))
+ 
  labs(title = "Notowania WIG")
+
  theme(axis.title.x=element_blank(), axis.title.y=element_blank(), plot.title=element_text(size=8), panel.background = element_rect(fill = "transparent",colour = NA), legend.text=element_text(size=8), legend.title=element_text(size=8) )
+
  scale_color_manual("Legenda", values = c("rosybrown", "green4",  "deepskyblue2", "lightslateblue", NA))
+
  geom_image(aes(x = Data[20], y = 60000, image=img), size = 0.15, asp = 1.5)
)

wyk2 <- (
  ggplot(wigData, aes(x = Data))
+
  geom_line(aes(y = Wolumen))
+
  labs(title = "Wolumen")
+
  theme(axis.title.x=element_blank(), axis.title.y=element_blank(), plot.title=element_text(size=8), panel.background = element_rect(fill = "transparent",colour = NA))
+
  geom_image(aes(x = Data[20], y =609113947, image=img), size = 0.125, asp = 1.65)
)

x11();grid.arrange(
  arrangeGrob(wyk1,wyk2,ncol=1))

#2. Histogram

hist <- (
  
  ggplot(wigData, aes(wigData$Zamkniecie - wigData$Otwarcie))
+
  geom_histogram(bins = 30, col= 'orchid4', fill = 'orchid3')
+
  labs(title="Histogram ró¿nic kursów zamkniêcia i otwarcia", x="ró¿nica kursów", y="iloœæ")
+
  theme(axis.title.y=element_text(size=10), axis.title.x=element_text(size=10), plot.title = element_text(size=12))

         )

hist <- ggbackground(hist, img, color="gray77")

x11();print(hist)

#3. Boxplot

wigData$Dzien <- wday(wigData$Data, label=T, abbr=F)

boxplot <- (
  ggplot(wigData, aes(wigData$Dzien, wigData$Najwyzszy-wigData$Najnizszy))
+
  geom_boxplot(colour = 'navy', fill = 'slateblue2')
+
  labs( x="dzieñ tygodnia", y="ró¿nica kursów max i min", title ="Ró¿nice kursów max i min")
+
  theme(axis.title.x=element_text(size=9),axis.title.y=element_text(size=9), plot.title = element_text(size=11))

)

boxplot <- ggbackground(boxplot, img, color = "gray77")

x11();print(boxplot)

#4. 

 