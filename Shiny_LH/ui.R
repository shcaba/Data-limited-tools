library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Estimating life history values"),
    headerPanel("Input parameters"),
 #   fluidRow(
      #column(5,
       sidebarLayout(
        conditionalPanel(
        condition="input.conditionedPanels==1",
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
       )
        ),
#      column(5,
        conditionalPanel(
          condition="input.conditionedPanels==2",
        sidebarPanel
       (
        numericInput("Amax", "Maximum age (years):",value=NA,min=1, max=100, step=0.1),    
        numericInput("Lmax","Maximum length (cm)", value=NA,min=1, max=1000, step=0.01),
        numericInput("Linf","Linf (in cm):", value=NA,min=1, max=1000, step=0.01),
        numericInput("k", "VBGF Growth coeff. k:",value=NA,min = 0, max = 1,step=0.01),
        numericInput("Amat","Age at maturity (years)" ,value=NA,min = -5, max = 5,step=0.01),
        numericInput("Lmat", "Length at maturity (cm)",value=NA,min = 1, max = 1000,step=0.01),
        numericInput("M", "Natural mortality",value=NA,min = 0.000001, max = 10,step=0.001)
        )
      ),
    
        conditionalPanel(
          condition="input.conditionedPanels==3",
        sidebarPanel
       (
        numericInput("Amax", "Maximum age (years):",value=NA,min=1, max=100, step=0.1),    
        numericInput("Lmax","Maximum length (cm)", value=NA,min=1, max=1000, step=0.01),
        numericInput("Linf","Linf (in cm):", value=NA,min=1, max=1000, step=0.01),
        numericInput("k", "VBGF Growth coeff. k:",value=NA,min = 0, max = 1,step=0.01),
        numericInput("Amat","Age at maturity (years)" ,value=NA,min = -5, max = 5,step=0.01),
        numericInput("Lmat", "Length at maturity (cm)",value=NA,min = 1, max = 1000,step=0.01),
        numericInput("M", "Natural mortality",value=NA,min = 0.000001, max = 10,step=0.001)
        )
      )

#      column(5, 
   #      conditionalPanel(
   #        condition="input.conditionedPanels==3",
   # #       h4("Parameter inputs"),
   #    sidebarPanel
   #     (
   #      numericInput("prop_Linf","Proportion of Linf for Amat",value=1,min=0, max=1, step=0.01),
   #      numericInput("Linf","Linf (in cm):",value=NA,min=1, max=1000, step=0.01),
   #      numericInput("Linf_f","Female Linf (in cm):",value=NA,min=1, max=1000, step=0.01),
   #      numericInput("Linf_m","Male Linf (in cm):",value=NA,min=1, max=1000, step=0.01),
   #      numericInput("k", "VBGF Growth coeff. k:", value=NA,min = 0, max = 1,step=0.01),
   #      numericInput("t0", "VBGF size at age 0 (t_0)", value=NA,min = -5, max = 5,step=0.01),
   #      numericInput("Temp","Water temperature (in C):" ,value=NA,min = 0, max = 40,step=0.01)
   #      )
   #    )
    ),
    # Plot VBGF figure and equation
 #   column(8,
           mainPanel(
              tabsetPanel(
              tabPanel("Natural mortality", value = 1,
          h4("Natural mortality (M) estimates by method"),
          plotOutput("Mplot"),
          h4("Natural mortality (M) values"),
          fluidRow(
            column(6,tableOutput("Mtable")),
            column(6,tableOutput("Mtable2")),
            downloadButton('downloadData', 'Download M values')
          )
        ),
        tabPanel("Growth", value = 2,
            h4("Growth parameters"),
            column(6,plotOutput("VBGFplot")),
            column(6,plotOutput("Loptplot")),
            h4("VBGF values"),
            fluidRow(
              column(6,tableOutput("VBGFtable")),
              downloadButton('downloadData', 'Download values')
            )
        ),
        tabPanel("Maturity", value = 3,
            h4("Lenth at maturity"),
            column(6,plotOutput("Matplot")),
            h4("Maturity values"),
            fluidRow(
              column(6,tableOutput("Maturitytable")),
              downloadButton('downloadData', 'Download values')
            )
      ),
        id = "conditionedPanels"
    )
  )
)
#)
)
#)
#)