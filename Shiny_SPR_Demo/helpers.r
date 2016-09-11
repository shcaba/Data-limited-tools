OptRoutine <- function(FleetPars, LenDat, Stock, SizeBins, FitControl=NULL) {
  Fleet <- NULL
  Fleet$SL50 <- exp(FleetPars)[1] * Stock$Linf
  Fleet$SL95 <- Fleet$SL50  + (exp(FleetPars)[2] * Stock$Linf)
  Fleet$MLLKnife <- NA
  Fleet$FM <- exp(FleetPars)[3]
  runMod <- EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)
  LenProb <- LenDat/sum(LenDat)
  ind <- (LenProb > 0)
  runMod$ExpLenCatchFished[runMod$ExpLenCatchFished == 0] <- 0.000001
  NLL <- -sum(LenDat[ind] * log(runMod$ExpLenCatchFished[ind]/LenProb[ind]))
  return(NLL)
}


# LB-SPR Model 
EqSimMod_LB <- function(Stock, Fleet, SizeBins, FitControl=NULL)  {
  if (length(FitControl) > 0) { # Adjust life-history parameters for fitness
    AdjustM <- FitControl$AdjustM
	if (AdjustM) {
	  OutPath <- FitControl$OutPath
	  PredictPars <- FitControl$PredictPars
      Stock <- AdjustedParsFun(Stock, Fleet, SizeBins, AdjustM=AdjustM, OutPath=OutPath, PredictPars=PredictPars)
    }	  
  }

  # Stock$House-keeping stuff 
  NGTG <- Stock$NGTG 
  GTGLinfBy <- Stock$GTGLinfBy 
  if (!exists("GTGLinfBy")) GTGLinfBy <- NA
  if (is.null(GTGLinfBy)) GTGLinfBy <- NA
  Linf <- Stock$Linf
  CVLinf <- Stock$CVLinf 
  MaxSD <- Stock$MaxSD 
  MK <- Stock$MK 
  L50 <- Stock$L50 
  L95 <- Stock$L95 
  Walpha <- Stock$Walpha 
  Wbeta <- Stock$Wbeta 
  FecB <- Stock$FecB 
  Steepness <- Stock$Steepness 
  Mpow <- Stock$Mpow
  R0 <- Stock$R0 
  CentLinf <- Stock$CentLinf 
  CentMpar <- Stock$CentMpar 
  CentKpar <- Stock$CentKpar
  Mslope <- Stock$Mslope
  
  # These parameters for accounting for differential in fitness across groups 
  if (!exists("CentLinf")) CentLinf <- Linf 
  if (is.null(CentLinf)) CentLinf <- Stock$Linf 
  if (!exists("Mpar")) Mpar <- 0.2 # Only used to calculate M/K ratio
  if (is.null(Mpar)) Mpar <- 0.2
  if (!exists("CentMpar")) CentMpar <- Mpar 
  if (is.null(CentMpar)) CentMpar <- Mpar 
  if (!exists("CentKpar")) CentKpar <- Kpar 
  if (is.null(CentKpar)) CentKpar <- CentMpar / MK
  if (!exists("Mslope")) Mslope <- 0 
  if (is.null(Mslope)) Mslope <- 0 
  	
  SL50 <- Fleet$SL50
  SL95 <- Fleet$SL95 
  MLLKnife <- Fleet$MLLKnife
  FM <- Fleet$FM 
  
  Linc <- SizeBins$Linc 
  ToSize <- SizeBins$ToSize

  # Error Catches #
  if (!(exists("NGTG") | exists("GTGLinfBy"))) stop("NGTG or GTGLinfBy must be specified")
  if (!exists("R0")) R0 <- 1E6
  
  SDLinf <- CVLinf * Linf # Standard Deviation of Length-at-Age # Assumed constant CV here
  
  # Set up Linfs for the different GTGs
  if (exists("NGTG") & !exists("GTGLinfBy")) {
    DiffLinfs <- seq(from=CentLinf-MaxSD*SDLinf, to=CentLinf+MaxSD*SDLinf, length=NGTG)
	GTGLinfBy <- DiffLinfs[2]-DiffLinfs[1]
  } else  if (!exists("NGTG") & exists("GTGLinfBy")) {
    DiffLinfs <- seq(from=CentLinf-MaxSD*SDLinf, to=CentLinf+MaxSD*SDLinf, by=GTGLinfBy)
	NGTG <- length(DiffLinfs)
  } else if (exists("NGTG") & exists("GTGLinfBy")) {
    if (!is.na(GTGLinfBy)) {
	  DiffLinfs <- seq(from=CentLinf-MaxSD*SDLinf, to=CentLinf+MaxSD*SDLinf, by=GTGLinfBy)
	  NGTG <- length(DiffLinfs)
	} 
	if (is.na(GTGLinfBy)) {
	  DiffLinfs <- seq(from=CentLinf-MaxSD*SDLinf, to=CentLinf+MaxSD*SDLinf, length=NGTG)
	  GTGLinfBy <- DiffLinfs[2]-DiffLinfs[1]
	}  
  } 
  # Distribute Recruits across GTGS 
  RecProbs <- dnorm(DiffLinfs, CentLinf, sd=SDLinf)/sum(dnorm(DiffLinfs, CentLinf, sd=SDLinf)) 
  
  # Length Bins 
  if (is.null(ToSize)) ToSize <- max(DiffLinfs, Linf + 3 * SDLinf)
  LenMids <- seq(from=0.5*Linc, by=Linc, to=ToSize)
  LenBins <- seq(from=0, by=Linc, length.out=length(LenMids)+1)
  
  Weight <- Walpha * LenMids^Wbeta
  
  # Maturity and Fecundity for each GTG 
  L50GTG <- L50/Linf * DiffLinfs # Maturity at same relative size
  L95GTG <- L95/Linf * DiffLinfs # Assumes maturity age-dependant 
  DeltaGTG <- L95GTG - L50GTG
  MatLenGTG <- sapply(seq_along(DiffLinfs), function (X) 1.0/(1+exp(-log(19)*(LenMids-L50GTG[X])/DeltaGTG[X])))
  FecLenGTG <- MatLenGTG * LenMids^FecB # Fecundity across GTGs - no scaling parameter atm

  VulLen <- 1.0/(1+exp(-log(19)*(LenBins-(SL50+0.5*Linc))/((SL95+0.5*Linc)-(SL50+0.5*Linc)))) # Selectivity-at-Length
  if (!is.na(MLLKnife)) { # Knife-edge selectivity
    VulLen[LenBins <= MLLKnife] <- 0
	VulLen[LenBins > MLLKnife] <- 1
	SL95 <- SL50 <- NA 
  }

  # Add dome-shaped selectivity curve 
  # Add F-mortality below MLL
  SelLen <- VulLen # Selectivity is equal to vulnerability currently
  
  # Life-History Ratios 
  ModMK <- CentMpar/CentKpar
  MKL <- ModMK * (CentLinf/(LenBins+0.5*Linc))^Mpow # M/K ratio for each length class
  # Matrix of MK for each GTG
  MKMat <- sapply(seq_along(DiffLinfs), function(X) MKL + Mslope*(DiffLinfs[X] - CentLinf))

  # ModMK + Mslope*(DiffLinfs-CentLinf)  #
  # # Debugging
   # matplot(MKMat)

  FK <- FM * ModMK # F/K ratio 
  FKL <- FK * SelLen # F/K ratio for each length class   
  # FkL[Legal == 0] <- FkL[Legal == 0] * DiscardMortFrac 
  ZKLMat <- MKMat + FKL # Z/K ratio (total mortality) for each GTG
    
  # Set Up Empty Matrices 
  NPRFished <- NPRUnfished <- matrix(0, nrow=length(LenBins), ncol=NGTG) # number-per-recruit at length
  NatLUnFishedPop <- NatLFishedPop <- NatLUnFishedCatch <- NatLFishedCatch <- FecGTGUnfished <- matrix(0, nrow=length(LenMids), ncol=NGTG) # number per GTG in each length class 
  NPRFished[1, ] <- NPRUnfished[1, ] <- RecProbs * R0# Distribute Recruits into first length class
  for (L in 2:length(LenBins)) { # Calc number at each size class
    NPRUnfished[L, ] <- NPRUnfished[L-1, ] * ((DiffLinfs-LenBins[L])/(DiffLinfs-LenBins[L-1]))^MKMat[L-1, ]
    NPRFished[L, ] <- NPRFished[L-1, ] * ((DiffLinfs-LenBins[L])/(DiffLinfs-LenBins[L-1]))^ZKLMat[L-1, ]
	ind <- DiffLinfs  < LenBins[L]
	NPRFished[L, ind] <- 0
	NPRUnfished[L, ind] <- 0
  } 
  NPRUnfished[is.nan(NPRUnfished)] <- 0
  NPRFished[is.nan(NPRFished)] <- 0
  NPRUnfished[NPRUnfished < 0] <- 0
  NPRFished[NPRFished < 0] <- 0
  
  for (L in 1:length(LenMids)) { # integrate over time in each size class
    NatLUnFishedPop[L, ] <- (NPRUnfished[L,] - NPRUnfished[L+1,])/MKMat[L, ]
    NatLFishedPop[L, ] <- (NPRFished[L,] - NPRFished[L+1,])/ZKLMat[L, ]  
	FecGTGUnfished[L, ] <- NatLUnFishedPop[L, ] * FecLenGTG[L, ]
  }
 
  VulLen2 <- 1.0/(1+exp(-log(19)*(LenMids-SL50)/(SL95-SL50))) # Selectivity-at-Length
  # print(LenMids)
  # print(c(SL50, SL95))
  # plot(LenMids, VulLen2)
  
  if (!is.na(MLLKnife))  { # Knife-edge selectivity
    VulLen2[LenMids <= MLLKnife] <- 0
	VulLen2[LenMids > MLLKnife] <- 1
	SL95 <- SL50 <- NA 
  }
  
  # points(LenMids, VulLen2, col="red")
  
  # print(cbind(LenMids, VulLen2))
  NatLUnFishedCatch <- NatLUnFishedPop * VulLen2 # Unfished Vul Pop
  NatLFishedCatch <- NatLFishedPop * VulLen2 # Catch Vul Pop
  
  # plot(LenMids, apply(NatLFishedCatch, 1, sum), type="p")
  # matplot(LenMids, (NatLFishedCatch), type="l")
  
  # Expected Length Structure - standardised 
  ExpectedLenCatchFished <- apply(NatLFishedCatch, 1, sum)/sum(apply(NatLFishedCatch, 1, sum))
  ExpectedLenPopFished <- apply(NatLFishedPop, 1, sum)/sum(apply(NatLFishedPop, 1, sum))
  ExpectedLenCatchUnfished <- apply(NatLUnFishedCatch, 1, sum)/sum(apply(NatLUnFishedCatch, 1, sum))
  ExpectedLenPopUnfished <- apply(NatLUnFishedPop, 1, sum)/sum(apply(NatLUnFishedPop, 1, sum))
  
  ExpectedLenCatchUnfished2 <- apply(NatLUnFishedCatch, 1, sum)
  ExpectedLenCatchFished2 <- apply(NatLFishedCatch, 1, sum)
  
  # Calc SPR
  EPR0 <- sum(NatLUnFishedPop * FecLenGTG) # Eggs-per-recruit Unfished
  EPRf <- sum(NatLFishedPop * FecLenGTG) # Eggs-per-recruit Fished
  SPR <- EPRf/EPR0 
  
  # Equilibrium Relative Recruitment
  recK <- (4*Steepness)/(1-Steepness) # Goodyear compensation ratio 
  reca <- recK/EPR0
  recb <- (reca * EPR0 - 1)/(R0*EPR0)
  RelRec <- max(0, (reca * EPRf-1)/(recb*EPRf))
  # RelRec/R0 - relative recruitment 
  YPR <- sum(NatLFishedPop  * Weight * VulLen2) * FM 
  Yield <- YPR * RelRec
    
  # Calc Unfished Fitness 
  Fit <- apply(FecGTGUnfished, 2, sum, na.rm=TRUE) # Total Fecundity per Group
  FitPR <- Fit/RecProbs # Fitness per-recruit
  FitPR <- FitPR/median(FitPR)
  ## Debugging
  # plot(FitPR, ylim=c(0,2)) # Should be relatively flat for equal fitness across GTG
    
  ObjFun <- sum((FitPR - median(FitPR, na.rm=TRUE))^2, na.rm=TRUE) # This needs to be minimised to make fitness approximately equal across GTG - by adjusting Mslope 
  Pen <- 0; if (min(MKMat) <= 0 ) Pen <- (1/abs(min(MKMat)))^2 * 1E12 # Penalty for optimising Mslope   
  ObjFun <- ObjFun + Pen
  # print(cbind(Mslope, ObjFun, Pen))

  # Calculate spawning-per-recruit at each size class
  SPRatsize <- cumsum(rowSums(NatLUnFishedPop * FecLenGTG))
  SPRatsize <- SPRatsize/max(SPRatsize)

  Output <- NULL 
  Output$SPR <- SPR
  Output$Yield <- Yield 
  Output$YPR <- YPR
  Output$ExpLenCatchFished <- ExpectedLenCatchFished
  Output$ExpLenPopFished <- ExpectedLenPopFished
  Output$ExpLenCatchFished2 <- ExpectedLenCatchFished2
  Output$ExpLenPopFished <- ExpectedLenPopFished
  Output$ExpLenCatchUnfished2 <- ExpectedLenCatchUnfished2
  Output$ExpLenPopUnfished <- ExpectedLenPopUnfished
  Output$NatLFishedPop <- NatLFishedPop
  Output$NatLUnFishedCatch <- NatLUnFishedCatch
  Output$NatLUnFishedPop <- NatLUnFishedPop
  Output$NatLFishedCatch <- NatLFishedCatch
  Output$LenBins <- LenBins
  Output$LenMids <- LenMids
  Output$NGTG <- NGTG
  Output$GTGdL <- DiffLinfs[2] - DiffLinfs[1]
  Output$DiffLinfs <- DiffLinfs
  Output$RecProbs <- RecProbs
  Output$Weight <- Weight
  Output$Winf <- Walpha * Linf^Wbeta
  Output$FecLen <- FecLenGTG 
  Output$MatLen <- MatLenGTG 
  Output$SelLen <- SelLen
  Output$MKL <- MKL
  Output$MKMat <- MKMat 
  Output$FKL <- FKL 
  Output$ZKLMat <- ZKLMat 
  Output$ObjFun <- ObjFun 
  Output$Pen <- Pen
  Output$FitPR <- FitPR
  Output$Diff <- range(FitPR)[2] - range(FitPR)[1]
  Output$L50GTG <- L50GTG 
  Output$L95GTG <- L95GTG
  Output$SPRatsize <- SPRatsize
  Output$RelRec <- RelRec
  return(Output)
}

getFMfun <- function(FM, setSPR, Stock, Fleet, SizeBins, FitControl=NULL) {
  Fleet$FM <- exp(FM)
  print(round((c(setSPR, EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)$SPR)),2))
  (setSPR - EqSimMod_LB(Stock, Fleet, SizeBins, FitControl=NULL)$SPR)^2
}

