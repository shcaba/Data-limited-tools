library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Estimating life history values"),
    headerPanel("Input parameters"),
       sidebarLayout(
        sidebarPanel
       (
        numericInput("Amax", "Maximum age (years):", value=NA,min=1, max=300, step=0.1),    
        numericInput("Linf","Linf (in cm):", value=NA,min=1, max=1000, step=0.01),
        numericInput("k", "VBGF Growth coeff. k:", value=NA,min = 0.001, max = 1,step=0.01),
        numericInput("t0", "VBGF size at age 0 (t_0)", value=NA,min = -15, max = 15,step=0.01),
        numericInput("Amat","Age at maturity (years)", value=NA,min = 0.01, max = 100,step=0.01),
        numericInput("Winf","Asym. weight (Winf, in g):", value=NA,min = 0, max = 100000,step=0.1),
        numericInput("kw","VBGF Growth coeff. wt. (kw, in g): ", value=NA,min = 0.001, max = 5,step=0.01),
        numericInput("Temp","Water temperature (in C):" , value=NA,min = 0.001, max = 60,step=0.01),
        numericInput("Wdry","Total dry weight (in g):" ,value=NA,min = 0.01, max = 1000000,step=0.01),
        numericInput("Wwet","Total wet weight (in g):" ,value=NA,min = 0.01, max = 1000000,step=0.01),
        numericInput("Bl","Body length (cm):",value=NA,min = 0.01, max = 10000,step=0.01),
        numericInput("GSI","Gonadosomatic index:",value=NA,min = 0, max = 1,step=0.001)
      ),
    # Plot VBGF figure and equation
 #   column(8,
       mainPanel(
          h4("Natural mortality (M) estimates by method"),
          plotOutput("Mplot"),
          h4("Natural mortality (M) values"),
          fluidRow(
            column(6,tableOutput("Mtable")),
            column(6,tableOutput("Mtable2")),
            downloadButton('downloadData', 'Download M values')
          )
        )
    ) 
)
)