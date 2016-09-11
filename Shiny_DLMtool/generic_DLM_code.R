#Command line example of using the DLMtool
#load library
library(DLMtool)

#Running TAC estimation with DLMobject
#access example data objects
for(i in 1:length(DLMdat))assign(DLMdat[[i]]@Name,DLMdat[[i]])
avail('DLM_data') 
Ex_dlm.data<-new("DLM_data",stock="C:/Users/Jason.Cope/Documents/GitHub/Data-limited-tools/Shiny_DLMtool/DLM_objects_examples/Example_datafile.csv")

#Example:explore dlm object
slotNames(Ex_dlm.data) #checks object inputs
summary(Ex_dlm.data) #Plots summary of removals, abundnace indices and input priors
Can(Ex_dlm.data)   #Methods that can be used
Cant(Ex_dlm.data)  #Methods that cannot be use
Needed(Ex_dlm.data) #What data needed for each "cant" method
#Calculate and plot catch estimates
Ex_dlm.data.TAC<-TAC(Ex_dlm.data)
plot(Ex_dlm.data.TAC)

boxplot(t(Ex_dlm.data.TAC@TAC[,,1]),horizontal=TRUE,ylim=c(0,250),axes=F,xlab="Total Allowable Catches",ylab="")
box()
axis(1)
axis(2,at=c(1:length(Ex_dlm.data.TAC@MPs)),labels= Ex_dlm.data.TAC@MPs,las=2)
#Sensitivity to specified method and its inputs
Example_DCAC_sensi<-Sense(Ex_dlm.data.TAC,"DCAC")

#############################

###### MSE Example ######
