library(shiny)

shinyServer(function(input, output, clientData, session) {
  Sys <- Sys.info()['sysname']
  # if (Sys == "Windows") source("helpers.r")
  # if (Sys != "Windows") source("/srv/shiny-server/lbspr/helpers.r")
  source("helpers.r")
  observe({
    Linf <- input$Linf
	L50 <- input$L50
     updateNumericInput(session, "L50", max=round(0.99*Linf,0), step=1)
	 updateNumericInput(session, "L95", min=round(1.01*L50,0), max=round(1.25*Linf,0), step=1)
  })
  
  ChkRange <- reactive({
    Linf <- input$Linf
	L50 <- input$L50
	L95 <- input$L95
	SL50 <- input$SL50
	SL95 <- input$SL95
	if (L50 < 1) updateNumericInput(session, "L50", value=1, min=1, max=round(1.25*Linf,0), step=1)
	if (L50 > L95) updateNumericInput(session, "L95", value=round(1.1*L50,0), min=round(1.01*L50,0),
		max=round(1.25*Linf,0), step=1)
    if (SL50 < 1) updateNumericInput(session, "SL50", value=1, min=1, max=round(1.25*Linf,0), step=1)
	if (SL50 > SL95) updateNumericInput(session, "SL95", value=round(1.1*SL50,0), 
		min=round(1.01*SL50,0), max=round(1.25*Linf,0), step=1)		 
  })
  
  # Life-history simulation 
  output$SPRSimulation <- renderPlot({ 
    Linf <- input$Linf
	L50 <- input$L50
	L95 <- input$L95
	SL50 <- input$SL50
	SL95 <- input$SL95

    ChkRange()
	lens <- seq(from=0, to=max(L50, Linf), length.out=100)
	Matprob <-	1.0/(1+exp(-log(19)*(lens-L50)/(L95-L50)))
	Selprob <-	1.0/(1+exp(-log(19)*(lens-SL50)/(SL95-SL50)))
	
	setSPR <- input$setSPR
    Stock <- NULL
    Stock$NGTG <- 41
    Stock$GTGLinfBy <- NA
    Stock$Linf <- input$Linf
    Stock$CVLinf <- 0.1 # NEED TO ADD THIS TO INPUT VARIABLES
    Stock$MaxSD <- 2 
    Stock$MK  <- input$MK
    Stock$L50 <- input$L50
    Stock$L95 <- input$L95
    Stock$Walpha <- 1
    Stock$Wbeta <- 3
    Stock$FecB  <- 3
    Stock$Steepness <- h <- max(0.20001, input$steepness) 
	Stock$Steepness <- h <- min(h, 0.99)
    Stock$Mpow <- 0
    Stock$R0  <- 1000
    Stock$CentLinf <- NULL
    Stock$CentMpar <- NULL
    Stock$CentKpar <- NULL
    Stock$Mslope <- 0 
	Fleet <- NULL
    Fleet$SL50 <- input$SL50
    Fleet$SL95 <- input$SL95
    Fleet$MLLKnife <- NA
    Fleet$FM <- 0
	SizeBins <- NULL
    SizeBins$Linc <- input$binswidth
    SizeBins$ToSize <- input$Linf*1.25
	
	# Calc SPR v F/M 
    FMVec <- seq(from=0, to=5, length.out=100)
    run <- sapply(1:length(FMVec), function (xx) {
      Fleet$FM <- FMVec[xx]
      EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)
    })
	SaveSPR <- sapply(1:length(FMVec), function(X) run[,X]$SPR)
	SaveYield1 <- sapply(1:length(FMVec), function(X) run[,X]$Yield)
    SaveYield <- SaveYield1/max(SaveYield1)
    FTarg <- FMVec[max(which(SaveSPR >= setSPR))]
  	
	# getFM <- optimise(getFMfun, interval=c(0, 100), setSPR=setSPR, Stock=Stock, Fleet=Fleet, SizeBins=SizeBins, FitControl=NULL)
	# print(getFM)
	Fleet$FM <- FTarg
    runMod <- EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)
	currYield <- runMod$Yield/max(SaveYield1)
	
	# Plots 
	R1 <- 100
	R2 <- max(0, (4*h*runMod$SPR+h-1)/((5*h-1)*runMod$SPR)) * R1
	MCex <- 1.3
	ind <- 1 # min(which(runMod$ExpLenCatchUnfished2 > 0.01))
	ind2 <- length(runMod$ExpLenCatchUnfished2)
	par(mfrow=c(2,2), mar=c(3,4,2,0), oma=c(2,2,2,1))
	tt <- barplot(runMod$ExpLenCatchUnfished2[ind:ind2]*R1, names.arg=round(runMod$LenMids[ind:ind2],0), axes=FALSE)
	axis(side=1, at=tt, label=FALSE)
	axis(side=2, label=FALSE)
    tt <- barplot(runMod$ExpLenCatchFished2[ind:ind2]*R2, names.arg=round(runMod$LenMids[ind:ind2],0), add=TRUE, col="blue", axes=FALSE)
	title(paste0("SPR = ", round(runMod$SPR,2)), xpd=NA, cex=1.5)
	mtext(side=1, line=2.5, "Length", cex=MCex)
	mtext(side=2, line=2, "Relative Frequency", cex=MCex, xpd=NA)
	
	
	plot(lens, Matprob, ylim=c(0,1), bty="n", lwd=3, type="l", las=1, xlab="", ylab="")
	lines(lens, Selprob, lty=2, lwd=3)
	mtext(side=1, line=2.5, "Length", cex=MCex)
	mtext(side=2, line=2.5, "Probability", cex=MCex)
	legend(c(lens[1], 1.3), bty="n", c("Maturity", "Selectivity"), lwd=3, lty=1:2,
	    seg.len=3, xpd=NA)
	
	plot(c(0,5), c(0,1), type="n", bty="n", las=1, xlab="", ylab="")
	lines(FMVec, SaveSPR, lwd=3)
	mtext(side=1, line=2.5, expression(italic(F/M)), cex=MCex)
	mtext(side=2, line=2.5, "SPR", cex=MCex)
	points(FTarg, runMod$SPR, pch=19, cex=3, xpd=NA)

	SPRcrash <- (1-h)/(4*h)
	SPRlim <- -(2*(h-1))/(3*h+1)

	if (h < 0.99) {
	  lines(range(FMVec), c(SPRcrash, SPRcrash), lty=3, col="red", lwd=2)
	  lines(range(FMVec), c(SPRlim, SPRlim), lty=3, col="blue", lwd=2)
	  legend("topright", bty="n", lty=c(3,3), legend=c(expression(SPR[crash]), expression(SPR[limit])),
	    col=c("red", "blue"), lwd=2)
	}

	plot(c(0,5), c(0,1), type="n", bty="n", las=1, xlab="", ylab="")
	lines(FMVec, SaveYield, lwd=3)
	mtext(side=1, line=2.5, expression(italic(F/M)), cex=MCex)
	mtext(side=2, line=2.5, "Relative Yield", cex=MCex)
	points(FTarg, currYield, pch=19, cex=3, xpd=NA)

  # }, res=100, height=600)
  }, res=100, height= function() session$clientData$output_SPRSimulation_width 
  )
  
  values <- reactiveValues(shouldShow = FALSE)
  observeEvent(input$goButton, {
    if(input$goButton == 0) return(NULL)
    values$shouldShow = TRUE
  })
  
  observeEvent(input$file1, {
    values$shouldShow = FALSE
  })
   
  output$SPRAssessment <- renderPlot({
    if(is.null(data())) return(NULL)
    Linf <- input$Linf
	L50 <- input$L50
	L95 <- input$L95
	SL50 <- input$SL50
	SL95 <- input$SL95
	ChkRange()
	
	loadDat <- data()
	Dim <- dim(loadDat)
	if (Dim[2] == 1) {
	  lendat <- unlist(loadDat)
	  MaxLen <- round(max(1.25*Linf, 1.1*max(lendat)),0)
	  LenBins <- seq(from=0, to=MaxLen, by=input$binswidth)
	  LenMids <- seq(from=0.5*input$binswidth, by=input$binswidth, length.out=length(LenBins)-1)
	  LenDat <- as.vector(table(cut(lendat,LenBins)))
	  SizeBins <- NULL
      SizeBins$Linc <- input$binswidth
      SizeBins$ToSize <- max(LenBins)
	}
	if (Dim[2] == 2) {
	  LenDat <- loadDat[,2]
	  LenMids <- loadDat[,1]
	  By <- LenMids[2] - LenMids[1]
	  LenBins <- seq(from=0, by=By, length.out=length(LenMids)+1)
	  SizeBins <- NULL
      SizeBins$Linc <- By
      SizeBins$ToSize <- max(LenBins)
	}
	setSPR <- input$setSPR
    Stock <- NULL
    Stock$NGTG <- 41
    Stock$GTGLinfBy <- NA
    Stock$Linf <- input$Linf
    Stock$CVLinf <- 0.1 # NEED TO ADD THIS TO INPUT VARIABLES
    Stock$MaxSD <- 2 
    Stock$MK  <- input$MK
    Stock$L50 <- input$L50
    Stock$L95 <- input$L95
    Stock$Walpha <- 1
    Stock$Wbeta <- 3
    Stock$FecB  <- 3
    Stock$Steepness <- h <- max(0.20001, input$steepness) 
	Stock$Steepness <- h <- min(h, 0.99)
    Stock$Mpow <- 0
    Stock$R0  <- 1000
    Stock$CentLinf <- NULL
    Stock$CentMpar <- NULL
    Stock$CentKpar <- NULL
    Stock$Mslope <- 0 
	Fleet <- NULL
    Fleet$SL50 <- NA
    Fleet$SL95 <- NA
    Fleet$MLLKnife <- NA
    Fleet$FM <- 0
	
	SL50Start <- LenMids[which.max(LenDat)]
    DeltaStart <- 0.1 * SL50Start
    FMStart <- 1 
    Starts <- log(c(SL50Start/Linf, DeltaStart/Linf, FMStart))
    Lower <- log(c(0.1, 0.1, 0.001))
    Upper <- log(c(0.9, 0.9, 20))
	
	MCex <- 1.3
    par(mfrow=c(2,2), mar=c(3,4,2,0), oma=c(2,2,2,1))
	# tt <- barplot(runMod$ExpLenCatchUnfished2*R1, names.arg=round(runMod$LenMids[ind:ind2],0), axes=FALSE)
	N <- sum(LenDat)
	tt <- barplot(LenDat, names.arg=round(LenMids,0))#, axes=FALSE)
	axis(side=1, at=tt, label=FALSE)
	axis(side=2, label=FALSE)
	
	if (values$shouldShow) {
      # run optimization
      Opt <- nlminb(Starts, OptRoutine, LenDat=LenDat, Stock=Stock, SizeBins=SizeBins, 
	  lower=Lower, upper=Upper)
	  N <- sum(LenDat)
      Fleet <- NULL
      Fleet$SL50 <- exp(Opt$par)[1] * Stock$Linf
      Fleet$SL95 <- Fleet$SL50  + exp(Opt$par)[2] * Stock$Linf
      Fleet$MLLKnife <- NA
      Fleet$FM <- exp(Opt$par)[3]
      runMod <- EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)
	  
	  lines(tt, runMod$ExpLenCatchFished*N, lwd=3)
	  title(paste0("Estimated SPR = ", round(runMod$SPR,2)), xpd=NA, cex=1.5)
	  
	  	# Calc SPR v F/M 
      FMVec <- seq(from=0, to=5, length.out=100)
      run <- sapply(1:length(FMVec), function (xx) {
        Fleet$FM <- FMVec[xx]
        EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)
      })
	  SaveSPR <- sapply(1:length(FMVec), function(X) run[,X]$SPR)
	  SaveYield1 <- sapply(1:length(FMVec), function(X) run[,X]$Yield)
      SaveYield <- SaveYield1/max(SaveYield1)
	  currYield <- runMod$Yield/max(SaveYield1)
      FTarg <- FMVec[max(which(SaveSPR >= setSPR))]
	  
	  lens <- seq(from=0, to=max(L50, Linf), length.out=100)
	  Matprob <- 1.0/(1+exp(-log(19)*(lens-L50)/(L95-L50)))
	  Selprob <- 1.0/(1+exp(-log(19)*(lens-Fleet$SL50)/(Fleet$SL95 -Fleet$SL50)))
	  
	  plot(lens, Matprob, ylim=c(0,1), bty="n", lwd=3, type="l", las=1, xlab="", ylab="")
	  lines(lens, Selprob, lty=2, lwd=3)
	  mtext(side=1, line=2.5, "Length", cex=MCex)
	  mtext(side=2, line=2.5, "Probability", cex=MCex)
	  legend(c(lens[1], 1.3), bty="n", c("Maturity", "Selectivity"), lwd=3, lty=1:2,
	    seg.len=3, xpd=NA)
	  estSL50 <- round(Fleet$SL50,0)
	  estSL95 <- round(Fleet$SL95,0)
	  text(lens[length(lens)], 1.2, bquote(SL[50]~ " = "~ .(estSL50)), xpd=NA, cex=1.25, pos=2)
	  text(lens[length(lens)], 1.1, bquote(SL[95]~ " = "~ .(estSL95)), xpd=NA, cex=1.25, pos=2)
	  
	  plot(c(0,5), c(0,1), type="n", bty="n", las=1, xlab="", ylab="")
	  lines(FMVec, SaveSPR, lwd=3)
	  mtext(side=1, line=2.5, expression(italic(F/M)), cex=MCex)
	  mtext(side=2, line=2.5, "SPR", cex=MCex)
	  points(Fleet$FM, runMod$SPR, pch=19, cex=3, xpd=NA)
      
	  SPRcrash <- (1-h)/(4*h)
	  SPRlim <- -(2*(h-1))/(3*h+1)

	  if (h < 0.99) {
	    lines(range(FMVec), c(SPRcrash, SPRcrash), lty=3, col="red", lwd=2)
	    lines(range(FMVec), c(SPRlim, SPRlim), lty=3, col="blue", lwd=2)
	    legend("topright", bty="n", lty=c(3,3), legend=c(expression(SPR[crash]), expression(SPR[limit])),
	      col=c("red", "blue"), lwd=2)
	  }
	  
	  plot(c(0,5), c(0,1), type="n", bty="n", las=1, xlab="", ylab="")
	  lines(FMVec, SaveYield, lwd=3)
	  mtext(side=1, line=2.5, expression(italic(F/M)), cex=MCex)
	  mtext(side=2, line=2.5, "Relative Yield", cex=MCex)
	  points(Fleet$FM, currYield, pch=19, cex=3, xpd=NA)
	}  
	
	
  # }, res=100, height=600)
  }, res=100, height= function() session$clientData$output_SPRSimulation_width )
  
  
  # Read CSV file 
  data <- reactive({
    file1 <- input$file1
	if (is.null(file1)) return(NULL)
	read.csv(file1$datapath, header = input$header,
             sep = input$sep, quote = input$quote)
	})		 
  
  # Print out first 6 observations 
  output$head <- renderTable({
    if(is.null(data())) return(NULL)
	dat <- head(data())
  })
  output$datSum <- renderText({
    if(is.null(data())) return(NULL)
	dat <- data()
	if(!is.null(dim(dat))) {
	  if (ncol(dat) > 2) {
	    str1 <- paste("Warning! More than two columns in data file. ")
        str2 <- paste("Only Columns 1 and 2 will be used")
        str3 <- (paste(str1, str2))
	    return(str3)
	  } 
	  if (ncol(dat) == 2) return(paste("A total of", sum(dat[,2]), "observations"))
	}
	if (ncol(dat)==1) return(paste("A total of", length(unlist(dat)), "observations"))
  })
  
  # Create histogram of data
  output$hist <- renderPlot({
    if(is.null(data())) return(NULL)
	lendat <- unlist(data())
    bins <- seq(0, max(lendat)*1.25, by = input$binswidth)
	hist(lendat, breaks=bins, col="darkgray", border="white")
  })
  
  
  
  # Not used 
  # output$tb <- renderUI({
    # ChkRange()
    # if(is.null(data())) {
	  # p("no data")
	# } else {
	  # tabsetPanel(tabPanel("Data", tableOutput("head")), 
		# tabPanel("Histogram", plotOutput("hist")),
		# tabPanel("Maturity curve", plotOutput("MatCurve"))
		# )
    # }
  # })

})
