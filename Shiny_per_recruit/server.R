# Define server logic required to draw figure
library(shiny)

shinyServer(
  function(input, output) 
  {    

################################
## population dynamic functions
################################
    ## length at age
get_lengths <-function(Linf,k,t0,b,d,ages)
{
  Lengths_exp<-Linf*(1-exp(-k*b*(1-d)*(ages-t0)))^(1/(b*(1-d)))
  return(Lengths_exp)
}

  ## selectivity at age
get_selex <- function(aselex, ages){
  Selex_a <- rep(0, length(ages))
  Selex_a[which(ages>=aselex)] <- 1
  return(Selex_a)
}

  ## numbers at age
get_Na <- function(ages, aselex, M, fish, R0){
  S_a <- get_selex(aselex, ages)
  N_a <- rep(NA, length(ages))
  N_a[1] <- R0
  for(i in 2:length(ages)){
    if(i<length(ages)) N_a[i] <- exp(-M-S_a[i-1]*fish)*N_a[i-1]
    if(i==length(ages)) N_a[i] <- (N_a[i-1]*exp(-M-fish*S_a[i-1]))/(1-exp(-M-fish*S_a[i-1]))
  }
  return(N_a)
}

  ## weight at age
get_weight <- function(ages, Linf,k,t0,lwa, lwb){
  L_a <- get_lengths(Linf,k,t0,lwb,lwa,ages)
  W_a <- sapply(1:length(L_a), function(x) lwa*L_a[x]^lwb)
  return(W_a)
}


  ## proportion mature at age
get_mature <- function(agemat, ages){
  Mat_a <- rep(0, length(ages))
  Mat_a[which(ages>=agemat)] <- 1
  return(Mat_a)
}


  ## fecundity at age
get_fec <- function(agemat, ages, Linf, k, t0, lwa, lwb){
  Mat_a <- get_mature(agemat, ages)
  weight <- get_weight(ages, Linf, k, t0, lwa, lwb)
  Fec_a <- Mat_a*weight
  return(Fec_a)
}

  ## spawning biomass at age
get_SB <- function(ages, agemat, Linf, k, t0, lwa, lwb, aselex, M, fish, R0){
  N_a <- get_Na(ages, aselex, M, fish, R0)
  Fec_a <- get_fec(agemat, ages, Linf, k, t0, lwa, lwb)
  
  SB <- Fec_a*N_a
  return(SB)
}

  ## catch at age
get_catch <- function(ages, aselex, M, fish, R0, Linf,k,t0,lwa, lwb){
  N_a <- get_Na(ages, aselex, M, fish, R0)
  S_a <- get_selex(aselex, ages)
  weight <- get_weight(ages, Linf, k, t0, lwa, lwb)
  Cb_a <- N_a*weight*(1-exp(-M-S_a*fish))*fish*S_a/(M+S_a*fish)
  return(Cb_a)
}

  ## spawning biomass per recruit, either in the fished or unfished conditions
get_SBPR <- function(agemat, Linf, k, t0, lwa, lwb, aselex, M, fish, R0, unfished, text){
  ages <- c(1:input$amax)
  SB <- get_SB(ages, agemat, Linf, k, t0, lwa, lwb, aselex, M, fish, R0)
  SBPR <- sum(SB)/R0
  if(text==TRUE & unfished==FALSE) return(paste0("SBPR(fished) = ", round(SBPR,0)))
  if(text==TRUE & unfished==TRUE) return(paste0("SBPR(unfished) = ", round(SBPR,0)))
  
  if(text==FALSE) return(round(SBPR,0))
}

  ## spawning potential ratio
get_SPR <- function(agemat, Linf, k, t0, lwa, lwb, aselex, M, fish, R0, text=TRUE){
  ages <- c(1:input$amax)
  SBf <- get_SB(ages, agemat, Linf, k, t0, lwa, lwb, aselex, M, fish, R0)
  SBPRf <- sum(SBf)/R0
  
  SB0 <- get_SB(ages, agemat, Linf, k, t0, lwa, lwb, aselex, M, 0, R0)
  SBPR0 <- sum(SB0)/R0
  
  if(text==TRUE) return(paste0("Spawning Potential Ratio = ", round(SBPRf/SBPR0, 3)))
  if(text==FALSE) return(round(SBPRf/SBPR0, 3))
}

  ## yield per recruit
get_YPR <- function(aselex, M, fish, Linf,k,t0,lwa, lwb, R0, text)
{
  ages <- c(1:input$amax)
  Cb_a <- get_catch(ages, input$aselex, input$M, input$fish, 1, input$Linf, input$k, input$t0, input$d, input$b)
  YPR <- sum(Cb_a)/R0 
  if(text==TRUE) return(paste0("YPR = ", round(YPR,0)))
  if(text==FALSE) return(YPR)
}

find_Fref <- function(SBref, agemat, Linf, k, t0, lwa, lwb, aselex, M, fish, R0, unfished=FALSE, text=FALSE){
  SBcalc <- get_SBPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, fish, 1, unfished=FALSE, text=FALSE)
  SBdiff <- SBcalc - SBref
  return(SBdiff)
}

################################
## output
################################

## length
output$VBGFplot <- renderPlot(
{
  ages<-c(1:input$amax)
  lengths.out<- get_lengths(input$Linf,input$k,input$t0,input$b,input$d,ages)
  # plot VBGF
  plot(ages, lengths.out, col = "steelblue",
       xlab="Age",ylab="Length (cm)",xlim=c(0,input$amax),
       ylim=c(0,input$Linf*1.1),type="l",lwd=5,
       main="Length at age", xaxs="i", yaxs="i")
}
    )

## numbers alive at age
output$NumbersAtAge <- renderPlot(
{
  ages <- c(1:input$amax)
  N_a <- get_Na(ages, input$aselex, input$M, input$fish, 1)
  ## plot numbers at age
  plot(ages, N_a, col = "darkgreen",
       xlab="Age",ylab="Numbers Alive",xlim=c(0,input$amax),
       ylim=c(0,1.1),type="l",lwd=5, main="Numbers at age", xaxs="i", yaxs="i")
  
}
  )

## weight at age
output$WeightAtAge <- renderPlot(
  {
    ages <- c(1:input$amax)
    W_a <- get_weight(ages, input$Linf, input$k, input$t0, input$d, input$b)
    plot(ages, W_a, col="navyblue", xlab="Age", ylab="Weight (g)",
         xlim=c(0, input$amax), ylim=c(0, max(W_a)*1.1), type="l", lwd=5,
         main="Weight At Age", xaxs="i", yaxs="i")
  })


## maturity at age
output$MatureAtAge <- renderPlot(
{
  ages <- c(1:input$amax)
  Mat_a <- get_mature(input$amat, ages)
  plot(ages, Mat_a, col="goldenrod",
       xlab="Age", ylab="Proportion Mature", xlim=c(0, input$amax),
       ylim=c(0, max(Mat_a)*1.1), type="l", lwd=5, main="Maturity at Age", xaxs="i", yaxs="i")
}
  )

## fecundity at age
output$FecundityAtAge <- renderPlot(
  {
    ages <- c(1:input$amax)
    Fec_a <- get_fec(input$amat, ages, input$Linf, input$k, input$t0, input$d, input$b)
    plot(ages, Fec_a, col = "goldenrod4",
         xlab="Age", ylab="Fecundity", xlim=c(0, input$amax),
         ylim=c(0,max(Fec_a)*1.1), type="l", lwd=5, main="Fecundity at age", xaxs="i", yaxs="i")
  })


## selectivity at age
output$SelexAtAge <- renderPlot(
{
  ages <- c(1:input$amax)
  S_a <- get_selex(input$aselex, ages)
  plot(ages, S_a, col = "forestgreen",
       xlab="Age", ylab="Selectivity", xlim=c(0, input$amax),
       ylim=c(0,max(S_a)*1.1), type="l", lwd=5, main="Selectivity at age", xaxs="i", yaxs="i")
})

## selectivity and maturity
output$SelexMature <- renderPlot(
  {
    ages <- c(1:input$amax)
    S_a <- get_selex(input$aselex, ages)
    Mat_a <- get_mature(input$amat, ages)
    plot(ages, S_a, col="black", xlab="Age", ylab="Proportion vulnerable/mature", 
         xlim=c(0, input$amax), ylim=c(0, max(S_a)*1.1), type="l", lwd=4, main="Selectivity and Maturity", xaxs="i", yaxs="i")
    lines(ages, Mat_a, col="gray", lty=2, lwd=4)
    legend("bottomright", xpd=NA, legend=c("Selectivity", "Maturity"), lwd=4, lty=c(1,2), col=c("black", "gray"), border=NA, cex=1.3)
  })


## spawning biomass at age
output$SpawnBioAtAge <- renderPlot(
{
  ages <- c(1:input$amax)
  SB <- get_SB(ages, input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, input$fish, 1)
  plot(ages, SB, col="tomato3", xlim=c(0, input$amax),
       ylim=c(0, max(SB)*1.1), type="l", lwd=5, main="Spawning Biomass at age", xaxs="i", yaxs="i")
}
  )

## catch at age
output$CatchAtAge <- renderPlot(
  {
    ages <- c(1:input$amax)
    Cb_a <- get_catch(ages, input$aselex, input$M, input$fish, 1, input$Linf, input$k, input$t0, input$d, input$b)
    plot(ages, Cb_a, col="darkred", xlim=c(0, input$amax), 
         ylim=c(0, max(Cb_a)*1.1), type="l", lwd=5, main="Catch at age", xaxs="i", yaxs="i")
    
  })

## spawning biomass per recruit in fished condition
output$SBPRf <- renderText(
  {
    get_SBPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, input$fish, 1, unfished=FALSE, text=TRUE)
  })


## spawning biomass per recruit in unfished condition
output$SBPR0 <- renderText(
  {
    get_SBPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, 0, 1, unfished=TRUE, text=TRUE)
  })

## spawning potential ratio
output$SPR <- renderText(
  {
    get_SPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, input$fish, 1)
  })


## yield per recruit
output$YPR <- renderText(
  {
    get_YPR(input$aselex, input$M, input$fish, input$Linf, input$k, input$t0, input$d, input$b, 1, text=TRUE)
  }
)

output$YPRplot <- renderPlot(
  {
    uvec <- seq(0,2, by=0.02)
    YPRvec <- sapply(1:length(uvec), function(x) get_YPR(input$aselex, input$M, uvec[x], input$Linf, input$k, input$t0, input$d, input$b, 1, text=FALSE))
    plot(uvec, YPRvec, pch=19, cex=1.5, col="darkred", xlim=c(min(uvec), max(uvec)), ylim=c(0, max(YPRvec)*1.1), 
         xlab="Fation Rate", ylab="Yield Per Recruit", xaxs="i", yaxs="i")
  })

output$SBPRplot <- renderPlot(
{
  uvec <- seq(0,2, by=0.02)
  SBPRvec <- sapply(1:length(uvec), function(x) get_SBPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, uvec[x], 1, unfished=FALSE, text=FALSE))
  plot(uvec, SBPRvec, pch=19, cex=1.5, col="tomato3", xlim=c(min(uvec), max(uvec)), ylim=c(0, max(SBPRvec)*1.1),
       xlab="Fation Rate", ylab="Spawning Biomass Per Recruit", xaxs="i", yaxs="i", main="Find reference point")
  SBref <- (input$Fref/100)*SBPRvec[1] ## target percentage of spawning biomass from unfished state
  Fval <- uniroot(find_Fref, lower=uvec[1], upper=uvec[length(uvec)], SBref=SBref, agemat=input$amat, Linf=input$Linf, k=input$k, t0=input$t0, 
                  lwa=input$d, lwb=input$b, aselex=input$aselex, M=input$M, R0=1)$root  
  segments(x0=0, x1=Fval, y0=SBref, y1=SBref, lty=2)
  segments(x0=Fval, x1=Fval, y0=0, y1=SBref, lty=2)
  points(x=Fval, y=SBref, pch=16, cex=2.5)
  text(x=0.8, y=max(SBPRvec)*0.8, paste0("F", input$Fref, " = ", round(Fval, 2)), cex=2, font=2)

})

output$Kobe <- renderPlot(
  {
    plot(x=1, y=1, type="n", xlim=c(0, 1), ylim=c(0, 2), xaxs="i", yaxs="i",
         xlab="Spawning Potential Ratio", ylab="F/Fref", main="Status relative to reference point")
    abline(v=input$Fref/100, lty=2)
    abline(h=1, lty=2)
    SPRval <- get_SPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, input$fish, 1, text=FALSE)
    
    uvec <- seq(0,2, by=0.02)
    SBPRvec <- sapply(1:length(uvec), function(x) get_SBPR(input$amat, input$Linf, input$k, input$t0, input$d, input$b, input$aselex, input$M, uvec[x], 1, unfished=FALSE, text=FALSE))
    SBref <- (input$Fref/100)*SBPRvec[1] ## target percentage of spawning biomass from unfished state
    Fval <- uniroot(find_Fref, lower=uvec[1], upper=uvec[length(uvec)], SBref=SBref, agemat=input$amat, Linf=input$Linf, k=input$k, t0=input$t0, 
                    lwa=input$d, lwb=input$b, aselex=input$aselex, M=input$M, R0=1)$root  
    
    polygon(x=c(0, input$Fref/100, input$Fref/100, 0), y=c(1, 1, 2, 2), col="#AA000050", border=NA)
    polygon(x=c(input$Fref/100, 1, 1, input$Fref/100), y=c(0, 0, 1, 1), col="#00AA0050", border=NA)
    
    points(x=SPRval, y=input$fish/Fval, pch=19, col="blue", cex=2)
  })




## end
}
)

