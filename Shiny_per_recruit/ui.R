### per recruit analysis
### teaching tool
### Merrill Rudd
### March 2016


library(shiny)

shinyUI(fluidPage(
  
  #  Application title
  titlePanel("Per Recruit Analysis"),
  
  tabsetPanel(
    tabPanel("Growth",
             sidebarLayout(
               sidebarPanel(
                 numericInput("amax", "Age classes:", value=20), 
                 numericInput("Linf", withMathJax("$$L_\\infty:$$"), value=100),
                 numericInput("k", "k:", value = 0.1),
                 numericInput("t0", withMathJax("$$t_0:$$"), value = 0),
                 numericInput("b", "Weight-Length exponent:", value = 3),
                 numericInput("d", "Allometric scaling:",value = 0.0067)
                 ),
                mainPanel(
                  column(5, plotOutput("VBGFplot")),
                  column(5, plotOutput("WeightAtAge"))
                  )
               )
             
             ),
    tabPanel("Selectivity and Maturity",
             sidebarLayout(
               sidebarPanel(
                 numericInput("aselex", "Age at Selectivity",  value=4),
                 numericInput("amat", "Age at Maturity",value=4),
                 numericInput("M", "Natural Mortality",value=0.3),
                 numericInput("fish", "Fishing Mortality", value=0.3)
                 ),
               mainPanel(
                 column(5, plotOutput("SelexMature")),
                 column(5, plotOutput("NumbersAtAge"))
                 )
               )
             ),
    tabPanel("Per Recruit",
             sidebarLayout(
               sidebarPanel(
                 strong(textOutput("SPR"), 
                 br(),
                 numericInput("Fref", "Target spawning biomass (% of unfished)", value=30))
                 ),
               mainPanel(
                 column(5, plotOutput("SBPRplot")),
                 column(5, plotOutput("Kobe"))
                 )
               )
             )
    )
  
))
