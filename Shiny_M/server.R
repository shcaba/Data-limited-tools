library(shiny)
library(fishmethods)
shinyServer(
  function(input, output) 
  {    
    
    Then_M<-function(Amax)
    {
      M_vals<-rep(NA,4)
      M_vals[1]<-4.889*Amax^-0.916
      M_vals[2]<-5.109/Amax
      M_vals[3]<-exp(1.717-1.01*log(Amax))
      M_vals[4]<-5.4/Amax
      return(M_vals)
    }
    
    Then_VBGF<-function(Linf,k)
    {
      M_val_vbgf<-4.11*k^0.73*Linf^-0.33
      return(M_val_vbgf)
    }
    
    Jensen_M_amat<-function(Amat)
    {
      M_val_Jensen<-1.65/Amat
      return(M_val_Jensen)
    }
    
    Jensen_M_k<-function(k)
    {
      M_val_Jensen_k<-k*c(1.5,1.6)
      return(M_val_Jensen_k)
    }
    
    Chen_N_Wat_M<-function(Amax,Amat,k,t0)
    {
      if(anyNA(c(Amax,k,t0))){M.out<-NA}
      else
      {
        M_ages<-rep(NA,length(c(1:Amax)))
        tM<--1/k*(log(abs(1-exp(k*t0)))+t0)
        a0<-1-exp(-k*(tM-t0))
        a1<-k*exp(-k*(tM-t0))
        a2<--0.5*k^2*exp(-k*(tM-t0))
        for(a in 1:Amax)
        {
          if(a<=tM){M_ages[a]<-k/(1-exp(-k*(a-t0)))}
          if(a>tM){M_ages[a]<-k/(a0+a1*(a-tM)+a2*(a-tM)^2)}
        }
        M.out<-mean(M_ages)
      }
      return(M.out)
      #return(M_ages)
    }
    
    
     M_vals<- reactive({
      Pauly80lt_M<-Pauly80wt_M<-AnC75_M<-Roff_M<-GnD_GSI_M<-PnW_M<-Lorenzen96_M<-Gislason_M<-NA
      Then_M_Amax<-Then_M(input$Amax)
      if(!(anyNA(c(input$k,input$Amax)))){AnC75_M<-M.empirical(Kl=input$k,tmax=input$Amax,method=4)[1]}
      Then_M_VBGF<-Then_VBGF(input$Linf*10,input$k)
      Jensen_M_VBGF<-Jensen_M_k(input$k) 
      if(!(anyNA(c(input$Linf,input$k,input$Bl)))){Gislason_M<-M.empirical(Linf=input$Linf,Kl=input$k,Bl=input$Bl,method=9)[1]}
      CnW_M_VBGF<-Chen_N_Wat_M(input$Amax,iput$Amat,input$k,input$t0)
      if(!(anyNA(c(input$k,input$Amat)))){Roff_M<-M.empirical(Kl=input$k,tm=input$Amat,method=5)[1]}
      Jensen_M_Amat<-Jensen_M_amat(input$Amat)
      if(!(anyNA(c(input$Wdry)))){PnW_M<-M.empirical(Wdry=input$Wdry,method=7)[1]}
      if(!(anyNA(c(input$Wwet)))){Lorenzen96_M<-M.empirical(Wwet=input$Wwet,method=8)[1]}
      if(!(anyNA(c(input$Linf,input$k,input$Temp)))){Pauly80lt_M<-M.empirical(Linf=input$Linf,Kl=input$k,T=input$Temp,method=1)[1]}
      if(!(anyNA(c(input$Winf,input$kw,input$Temp)))){Pauly80wt_M<-M.empirical(Winf=input$Winf,Kw=input$kw,T=input$Temp,method=2)[1]}
      if(!(anyNA(c(input$GSI)))){GnD_GSI_M<-M.empirical(GSI=input$GSI,method=6)[1]}
      M_vals_all<-c(Then_M_Amax,AnC75_M,Then_M_VBGF,Jensen_M_VBGF,Pauly80lt_M,Pauly80wt_M,Gislason_M,CnW_M_VBGF,Roff_M,Jensen_M_Amat,PnW_M,Lorenzen96_M,GnD_GSI_M)
      M_methods<-c("Then_Amax 1","Then_Amax 2","Then_Amax 3","Hamel_Amax","AnC","Then_VBGF","Jensen_VBGF 1","Jensen_VBGF 2","Pauly_lt","Pauly_wt","Gislason","Chen-Wat","Roff","Jensen_Amat","PnW","Lorenzen","GSI")
      M_table<-data.frame(cbind(M_methods,M_vals_all))
      colnames(M_table)<-c("Method","M")
      M_table
     })
    
     M_vals_all<- reactive({
       Pauly80lt_M<-Pauly80wt_M<-AnC75_M<-Roff_M<-GnD_GSI_M<-PnW_M<-Lorenzen96_M<-Gislason_M<-NA
       Then_M_Amax<-Then_M(input$Amax)
       if(!(anyNA(c(input$k,input$Amax)))){AnC75_M<-M.empirical(Kl=input$k,tmax=input$Amax,method=4)[1]}
       Then_M_VBGF<-Then_VBGF(input$Linf*10,input$k)
       Jensen_M_VBGF<-Jensen_M_k(input$k) 
       if(!(anyNA(c(input$Linf,input$k,input$Bl)))){Gislason_M<-M.empirical(Linf=input$Linf,Kl=input$k,Bl=input$Bl,method=9)[1]}
       CnW_M_VBGF<-Chen_N_Wat_M(input$Amax,iput$Amat,input$k,input$t0)
       if(!(anyNA(c(input$k,input$Amat)))){Roff_M<-M.empirical(Kl=input$k,tm=input$Amat,method=5)[1]}
       Jensen_M_Amat<-Jensen_M_amat(input$Amat)
       if(!(anyNA(c(input$Wdry)))){PnW_M<-M.empirical(Wdry=input$Wdry,method=7)[1]}
       if(!(anyNA(c(input$Wwet)))){Lorenzen96_M<-M.empirical(Wwet=input$Wwet,method=8)[1]}
       if(!(anyNA(c(input$Linf,input$k,input$Temp)))){Pauly80lt_M<-M.empirical(Linf=input$Linf,Kl=input$k,T=input$Temp,method=1)[1]}
       if(!(anyNA(c(input$Winf,input$kw,input$Temp)))){Pauly80wt_M<-M.empirical(Winf=input$Winf,Kw=input$kw,T=input$Temp,method=2)[1]}
       if(!(anyNA(c(input$GSI)))){GnD_GSI_M<-M.empirical(GSI=input$GSI,method=6)[1]}
       M_vals_all<-c(Then_M_Amax,AnC75_M,Then_M_VBGF,Jensen_M_VBGF,Pauly80lt_M,Pauly80wt_M,Gislason_M,CnW_M_VBGF,Roff_M,Jensen_M_Amat,PnW_M,Lorenzen96_M,GnD_GSI_M)
       M_vals_all
     })
     
     output$Mplot <- renderPlot({
  # mvals_all<-dataInput()
        Pauly80lt_M<-Pauly80wt_M<-AnC75_M<-Roff_M<-GnD_GSI_M<-PnW_M<-Lorenzen96_M<-Gislason_M<-NA
        Then_M_Amax<-Then_M(input$Amax)
        if(!(anyNA(c(input$k,input$Amax)))){AnC75_M<-M.empirical(Kl=input$k,tmax=input$Amax,method=4)[1]}
        Then_M_VBGF<-Then_VBGF(input$Linf*10,input$k)
        Jensen_M_VBGF<-Jensen_M_k(input$k) 
        if(!(anyNA(c(input$Linf,input$k,input$Bl)))){Gislason_M<-M.empirical(Linf=input$Linf,Kl=input$k,Bl=input$Bl,method=9)[1]}
        CnW_M_VBGF<-Chen_N_Wat_M(input$Amax,iput$Amat,input$k,input$t0)
        if(!(anyNA(c(input$k,input$Amat)))){Roff_M<-M.empirical(Kl=input$k,tm=input$Amat,method=5)[1]}
        Jensen_M_Amat<-Jensen_M_amat(input$Amat)
        if(!(anyNA(c(input$Wdry)))){PnW_M<-M.empirical(Wdry=input$Wdry,method=7)[1]}
        if(!(anyNA(c(input$Wwet)))){Lorenzen96_M<-M.empirical(Wwet=input$Wwet,method=8)[1]}
        if(!(anyNA(c(input$Linf,input$k,input$Temp)))){Pauly80lt_M<-M.empirical(Linf=input$Linf,Kl=input$k,T=input$Temp,method=1)[1]}
        if(!(anyNA(c(input$Winf,input$kw,input$Temp)))){Pauly80wt_M<-M.empirical(Winf=input$Winf,Kw=input$kw,T=input$Temp,method=2)[1]}
        if(!(anyNA(c(input$GSI)))){GnD_GSI_M<-M.empirical(GSI=input$GSI,method=6)[1]}
      
      M_vals_all<-c(Then_M_Amax,AnC75_M,Then_M_VBGF,Jensen_M_VBGF,Pauly80lt_M,Gislason_M,CnW_M_VBGF,Roff_M,Jensen_M_Amat,Pauly80wt_M,PnW_M,Lorenzen96_M,GnD_GSI_M)
      M_methods<-c("Then_Amax 1","Then_Amax 2","Then_Amax 3","Hamel_Amax","AnC","Then_VBGF","Jensen_VBGF 1","Jensen_VBGF 2","Pauly_lt","Gislason","Chen-Wat","Roff","Jensen_Amat","Pauly_wt","PnW","Lorenzen","GSI")
  # plot M
  if(all(is.na(M_vals_all))){ymax<-0.5}
  if(!(all(is.na(M_vals_all)))){ymax<-ceiling((max(M_vals_all,na.rm=TRUE)*1.1*10))/10}
  par(mar=c(8,4,2,6),xpd =TRUE)
  plot(M_vals_all, col = "black",bg=c("blue","blue","blue","blue","green","green","green","green","yellow","yellow","orange","red","red","black","black","black","purple"),xlab=" ",ylab="Natural mortality",ylim=c(0,ymax),pch=22,cex=1.5,axes=F)
  box()
  axis(1,at=1:length(M_vals_all),labels=M_methods,las=3)
  axis(2)
  legend(x="topright",legend=c("Amax","VBGF","VBGF:Temp","VBGF;Amat","Amat","Weight","GSI"),pch=22,col="black",pt.bg=c("blue","green","yellow","orange","red","black","purple"),bty="n",horiz=FALSE,cex=1,inset=c(-0.125,0))
})

# Show the first "n" observations
output$Mtable <- renderTable({
  #colnames(M_table)<-c("M","Method")
  Pauly80lt_M<-Pauly80wt_M<-AnC75_M<-Roff_M<-GnD_GSI_M<-PnW_M<-Lorenzen96_M<-Gislason_M<-NA
  Then_M_Amax<-Then_M(input$Amax)
  if(!(anyNA(c(input$k,input$Amax)))){AnC75_M<-M.empirical(Kl=input$k,tmax=input$Amax,method=4)[1]}
  Then_M_VBGF<-Then_VBGF(input$Linf*10,input$k)
  Jensen_M_VBGF<-Jensen_M_k(input$k) 
  if(!(anyNA(c(input$Linf,input$k,input$Bl)))){Gislason_M<-M.empirical(Linf=input$Linf,Kl=input$k,Bl=input$Bl,method=9)[1]}
  CnW_M_VBGF<-Chen_N_Wat_M(input$Amax,iput$Amat,input$k,input$t0)
  if(!(anyNA(c(input$k,input$Amat)))){Roff_M<-M.empirical(Kl=input$k,tm=input$Amat,method=5)[1]}
  Jensen_M_Amat<-Jensen_M_amat(input$Amat)
  if(!(anyNA(c(input$Wdry)))){PnW_M<-M.empirical(Wdry=input$Wdry,method=7)[1]}
  if(!(anyNA(c(input$Wwet)))){Lorenzen96_M<-M.empirical(Wwet=input$Wwet,method=8)[1]}
  if(!(anyNA(c(input$Linf,input$k,input$Temp)))){Pauly80lt_M<-M.empirical(Linf=input$Linf,Kl=input$k,T=input$Temp,method=1)[1]}
  if(!(anyNA(c(input$Winf,input$kw,input$Temp)))){Pauly80wt_M<-M.empirical(Winf=input$Winf,Kw=input$kw,T=input$Temp,method=2)[1]}
  if(!(anyNA(c(input$GSI)))){GnD_GSI_M<-M.empirical(GSI=input$GSI,method=6)[1]}
  
  M_vals_all<-c(Then_M_Amax,AnC75_M,Then_M_VBGF,Jensen_M_VBGF)
  M_methods<-c("Then_Amax 1","Then_Amax 2","Then_Amax 3","Hamel_Amax","AnC","Then_VBGF","Jensen_VBGF 1","Jensen_VBGF 2")
  M_table<-data.frame(M_vals_all)
  colnames(M_table)<-"M"
  rownames(M_table)<-M_methods
  M_table
})
# Show the first "n" observations
output$Mtable2 <- renderTable({
  #colnames(M_table)<-c("M","Method")
  Pauly80lt_M<-Pauly80wt_M<-AnC75_M<-Roff_M<-GnD_GSI_M<-PnW_M<-Lorenzen96_M<-Gislason_M<-NA
  Then_M_Amax<-Then_M(input$Amax)
  if(!(anyNA(c(input$k,input$Amax)))){AnC75_M<-M.empirical(Kl=input$k,tmax=input$Amax,method=4)[1]}
  Then_M_VBGF<-Then_VBGF(input$Linf*10,input$k)
  Jensen_M_VBGF<-Jensen_M_k(input$k) 
  if(!(anyNA(c(input$Linf,input$k,input$Bl)))){Gislason_M<-M.empirical(Linf=input$Linf,Kl=input$k,Bl=input$Bl,method=9)[1]}
  CnW_M_VBGF<-Chen_N_Wat_M(input$Amax,iput$Amat,input$k,input$t0)
  if(!(anyNA(c(input$k,input$Amat)))){Roff_M<-M.empirical(Kl=input$k,tm=input$Amat,method=5)[1]}
  Jensen_M_Amat<-Jensen_M_amat(input$Amat)
  if(!(anyNA(c(input$Wdry)))){PnW_M<-M.empirical(Wdry=input$Wdry,method=7)[1]}
  if(!(anyNA(c(input$Wwet)))){Lorenzen96_M<-M.empirical(Wwet=input$Wwet,method=8)[1]}
  if(!(anyNA(c(input$Linf,input$k,input$Temp)))){Pauly80lt_M<-M.empirical(Linf=input$Linf,Kl=input$k,T=input$Temp,method=1)[1]}
  if(!(anyNA(c(input$Winf,input$kw,input$Temp)))){Pauly80wt_M<-M.empirical(Winf=input$Winf,Kw=input$kw,T=input$Temp,method=2)[1]}
  if(!(anyNA(c(input$GSI)))){GnD_GSI_M<-M.empirical(GSI=input$GSI,method=6)[1]}
  
  M_vals_all<-c(Pauly80lt_M,Pauly80wt_M,Gislason_M,CnW_M_VBGF,Roff_M,Jensen_M_Amat,PnW_M,Lorenzen96_M,GnD_GSI_M)
  M_methods<-c("Pauly_lt","Pauly_wt","Gislason","Chen-Wat","Roff","Jensen_Amat","PnW","Lorenzen","GSI")
  M_table<-data.frame(M_vals_all)
  rownames(M_table)<-M_methods
  colnames(M_table)<-"M"
  M_table
})
output$downloadData <- downloadHandler(
  filename = function() { paste("M_values", '.csv', sep='') },
  content = function(file) {write.csv(M_vals(), file=)}
)

#Plot Composite M
output$Mcomposite<- renderPlot({    
  M.wts<-c(input$Then_Amax_1,input$Then_Amax_2,input$Then_Amax_3,input$Hamel_Amax,input$AnC,input$Then_VBGF,input$Jensen_VBGF_1,input$Jensen_VBGF_2,input$Pauly_lt,input$Gislason,input$Chen_Wat,input$Roff,input$Jensen_Amat,input$Pauly_wt,input$PnW,input$Lorenzen,input$Gonosoma)
  NA.ind<-attributes(na.omit(M_vals_all()))$na.action
  M.sub<-M_vals_all()[-NA.ind]
  M.melt<-melt(M.sub)
  M.wts.sub<-M.wts[-NA.ind]
  M.wts.sub.stand<-M.wts.sub/sum(M.wts.sub)
  Mcomposite.densityplot<- ggplot(data=M.melt,aes(value, weight=M.wts.sub.stand))+geom_density(fill="gray") +xlim(0,quantile(M.melt,0.95,na.rm=T))+labs(x="Natural Mortality",y="Density")+ geom_vline(xintercept = quantile(M.melt,0.5,na.rm=T),color="darkblue",size=1.2)
  print(Mcomposite.densityplot)
  M.densum<-density(M_vals_all()[-NA.ind],weights=M.wts.sub.stand)
  output$downloadMcompositedensityplot <- downloadHandler(
    filename = function() { paste('Mcomposite_densityplot',Sys.time(), '.png', sep='')},
    content = function(file) {
      png(file, type='cairo',width=800,height=720)
      print(Mcomposite.densityplot)
      dev.off()},contentType = 'image/png') 
  output$downloadMcompositedist <- downloadHandler(
    filename = function() {  paste0("Mcomposite",Sys.time(),".DMP", sep='') },
    content = function(file) {save(M.densum,file=file)}) 
})
  }
)

