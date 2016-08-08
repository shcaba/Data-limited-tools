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
    
    #Growth relationships
    #Linf
    FnB_Linf<-function(Lmax)
    {
      Linf<-exp(0.044+0.9841*log(Lmax))
      return(Linf)
    }
    
    FnB_K<-function(Lmat,Linf,Amat)
    {
      k<- -log(1+Lmat/Linf)/Amat
      return(k)
    }
    
    Taylor_k<-function(Amax)
    {
      k<-3/Amax
      return(k)
    }
    
    FnB_Lopt<-function(Lmat,Linf,M,k)
    {
      Lopt_1<-exp(1.053*log(Lmat)-0.0565)
      Lopt_2<-exp(1.0421*log(Linf)-0.2742)
      Lopt_3<-3*Linf*(3+M*k^-1)^-1
      Lopt<-c(Lopt_1,Lopt_2,Lopt_3)
      return(Lopt)
    }
    
    #Maturity
    FnB_Lm<-function(Linf,Linf_f,Linf_m,T)
    {
      Lm_1<-log(0.8979*log(Linf)-0.0782)
      Lm_2<-log(0.9469*log(Linf_f)-0.1162)
      Lm_3<-log(0.8915*log(Linf_m)-0.1032)
      Lm_4<-log(-0.0431+0.8917*log(Linf)-0.001531*log(T))      
      Lm<-c(Lm_1,Lm_2,Lm_3,Lm_4)
      return(Lm)
    }
    
    FB_Amat<-function(Linf,k,t0,Lmat,prop_Linf)
    {
      Amat<-t0-log(1-Lm/(Linf*prop_Linf))/k
      return(Amat)
    }
    
    #Longevity
    FnB_Amax<-function(Amat)
    {
      Amax<-exp(0.5496+0.957*log(Amat))
      return(Amax)      
    }
    
    # 
    # M_vals_out<-reactiveValues({
    #   Pauly80lt_M<-Pauly80wt_M<-AnC75_M<-Roff_M<-GnD_GSI_M<-PnW_M<-Lorenzen96_M<-Gislason_M<-NA
    #   Then_M_Amax<-Then_M(input$Amax)
    #   if(!(anyNA(c(input$k,input$Amax)))){AnC75_M<-M.empirical(Kl=input$k,tmax=input$Amax,method=4)[1]}
    #   Then_M_VBGF<-Then_VBGF(input$Linf*10,input$k)
    #   Jensen_M_VBGF<-Jensen_M_k(input$k) 
    #   if(!(anyNA(c(input$Linf,input$k,input$B1)))){Gislason_M<-M.empirical(Linf=input$Linf,Kl=input$k,B1=input$B1,method=9)[1]}
    #   CnW_M_VBGF<-Chen_N_Wat_M(input$Amax,iput$Amat,input$k,input$t0)
    #   if(!(anyNA(c(input$k,input$Amat)))){Roff_M<-M.empirical(Kl=input$k,tm=input$Amat,method=5)[1]}
    #   Jensen_M_Amat<-Jensen_M_amat(input$Amat)
    #   if(!(anyNA(c(input$Wdry)))){PnW_M<-M.empirical(Wdry=input$Wdry,method=7)[1]}
    #   if(!(anyNA(c(input$Wwet)))){Lorenzen96_M<-M.empirical(Wwet=input$Wwet,method=8)[1]}
    #   if(!(anyNA(c(input$Linf,input$k,input$Temp)))){Pauly80lt_M<-M.empirical(Linf=input$Linf,Kl=input$k,T=input$Temp,method=1)[1]}
    #   if(!(anyNA(c(input$Winf,input$kw,input$Temp)))){Pauly80wt_M<-M.empirical(Linf=input$Winf,Kw=input$kw,T=input$Temp,method=2)[1]}
    #   if(!(anyNA(c(input$GSI)))){GnD_GSI_M<-M.empirical(GSI=input$GSI,method=6)[1]}
      
    #   M_vals_all<-c(Then_M_Amax,AnC75_M,Then_M_VBGF,Jensen_M_VBGF,Pauly80lt_M,Pauly80wt_M,Gislason_M,CnW_M_VBGF,Roff_M,Jensen_M_Amat,PnW_M,Lorenzen96_M,GnD_GSI_M)
    #   M_methods<-c("Then_Amax 1","Then_Amax 2","Then_Amax 3","Hamel_Amax","AnC","Then_VBGF","Jensen_VBGF 1","Jensen_VBGF 2","Pauly_lt","Pauly_wt","Gislason","Chen-Wat","Roff","Jensen_Amat","PnW","Lorenzen","GSI")
      
    #})
    
    output$VBGFplot <- renderPlot(
      {
        #Calculate VBGF parameter values
        Linf_out<-FnB_Linf(input$Lmax)
        Linf_methods<-c("Froese_Bin")
        
        k_outpu1<-FnB_K(input$Lmat,input$Linf,input$Amat)
        k_outpu2<-Taylor_k(input$Amax)
        k_out<-c(k_outpu1,k_outpu2)
        k_methods<-c("Froese_Bin","Taylor")
        
        #Plot values
        par(mfrow=c(2,2), mar=c(3,4,2,0), oma=c(2,2,2,1))
        
        plot(Linf_out, col = "black",bg=c("blue"),xlab=" ",ylab="Linf",ylim=c(0,max(Linf_out*1.1)),pch=22,cex=1.5,axes=F,main="Linf")
        box()
        axis(1,at=1:length(Linf_out),labels=Linf_methods,las=3)
        axis(2)
        
        plot(k_out, col = "black",bg="gray",xlab=" ",ylab="VB growth coefficient (k)",ylim=c(0,max(k_out*1.1)),pch=22,cex=1.5,axes=F,main="k")
        box()
        axis(1,at=1:length(k_out),labels=k_methods,las=3)
        axis(2)
      }
    )  
    
    output$Loptplot <- renderPlot(
      {
        Lopt_out<-FnB_Lopt(input$Lmat,input$Linf,input$M,input$k)
        Lopt_methods<-c("Lopt 1","Lopt 2","Lopt 3")
        
        par(mar=c(3,4,2,0), oma=c(2,2,2,1))
        plot(Lopt_out, col = "black",bg=c("darkred"),xlab=" ",ylab="Length that optimizes cohort biomass (Lopt)",ylim=c(0,max(Lopt_out*1.1)),pch=22,cex=1.5,axes=F,main="Lopt")
        box()
        axis(1,at=1:length(Lopt_out),labels=Lopt_methods,las=3)
        axis(2)
      }
    )  

    #Maturity
    output$Matplot <- renderPlot(
      {
        Lmat_out<-FnB_Lm(input$Linf,input$Linf_f,input$Linf_m,input$T)
        Lmat_methods<-c("F&B combo","F&B females","F&B males","F&B temp")
        Amat_out<-FB_Amat(input$Linf,input$k,input$t0,input$Lmat,prop_Linf)
          
        par(mfrow=c(2,2),mar=c(3,4,2,0), oma=c(2,2,2,1))
        plot(Lmat_out, col = "black",bg=c("darkred"),xlab=" ",ylab="Length at maturity (cm)",ylim=c(0,max(Lmat_out*1.1)),pch=22,cex=1.5,axes=F,main="Lmat")
        box()
        axis(1,at=1:length(Lmat_out),labels=Lmat_methods,las=3)
        axis(2)
      }
    )  

    output$VBGFtable <- renderTable({
      Linf_out<-FnB_Linf(input$Lmax)
      Linf_methods<-c("Linf: Froese_Bin")
      
      k_outpu1<-FnB_K(input$Lmat,input$Linf,input$Amat)
      k_outpu2<-Taylor_k(input$Amax)
      k_out<-c(k_outpu1,k_outpu2)
      k_methods<-c("k: Froese_Bin","k: Taylor")
      
      Lopt_out<-FnB_Lopt(input$Lmat,input$Linf,input$M,input$k)
      Lopt_methods<-c("Lopt:F&B combo","Lopt: F&B females","Lopt: F&B males","Lopt: F&B temp")
      
      VBGF_table<-data.frame(c(Linf_out,k_out,Lopt_out))
      VBGF_methods<-c(Linf_methods, k_methods,Lopt_methods)
      rownames(VBGF_table)<-VBGF_methods
      colnames(VBGF_table)<-"VBGF values"
      VBGF_table
    })
    
    output$Maturitytable <- renderTable(
      {
        Lmat_out<-FnB_Lm(input$Linf,input$Linf_f,input$Linf_m,input$T)
        Lmat_methods<-c("F&B combo","F&B females","F&B males","F&B temp")
        Amat_out<-FB_Amat(input$Linf,input$k,input$t0,input$Lmat,prop_Linf)
        
        Mat_table<-data.frame(c(Lmat_out,Amat_out))
        Mat_methods<-c(Lmat_methods, "Amat")
        rownames(VBGF_table)<-Mat_methods
        colnames(VBGF_table)<-"Maturity values"
        Mat_table
      }
    )  

    output$Mplot <- renderPlot(
      {
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
      }
    )
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
      content = function(file) {
        write.csv(M_vals_out, file)
      }
    )
  }
)
    