#load library
library(DLMtool)
#access data objects
for(i in 1:length(DLMdat))assign(DLMdat[[i]]@Name,DLMdat[[i]])
avail('DLM_data') 
Kenya_stock<-new("DLM_data",stock="C:/Program Files/R/R-3.2.3/library/DLMtool/Kenya_stock.csv")

#China rockfish example
slotNames(China_rockfish) #checks object inputs
summary(China_rockfish) #Plots summary of removals, abundnace indices and input priors
Can(China_rockfish)   #Methods that can be used
Cant(China_rockfish)  #Methods that cannot be use
Needed(China_rockfish) #What data needed for each "cant" method
#Calculate and plot catch estimates
ChinaTAC<-TAC(China_rockfish)
plot(ChinaTAC)

boxplot(t(ChinaTAC@TAC[,,1]),horizontal=TRUE,ylim=c(0,250),axes=F,xlab="Total Allowable Catches",ylab="")
box()
axis(1)
axis(2,at=c(1:length( ChinaTAC@MPs)),labels= ChinaTAC@MPs,las=2)
#Sensitivity to specified method and its inputs
China_DCAC_sensi<-Sense(ChinaTAC,"DCAC")
