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
                 h3("Biological parameters"),
                 numericInput("amax", "Age classes:", value=NA), 
                 numericInput("M", "Natural Mortality",value=NA),
                 numericInput("fish", "Fishing Mortality", value=NA),
                 numericInput("Linf", withMathJax("$$L_\\infty:$$"), value=NA),
                 numericInput("k", "k:", value = NA),
                 numericInput("t0", withMathJax("$$t_0:$$"), value = 0),
                 numericInput("b", "Weight-Length exponent:", value = 3),
                 numericInput("d", "Allometric scaling:",value = NA),
                 numericInput("d", "Length at 50% maturity:",value = NA),
                 numericInput("d", "Length at 95% maturity:",value = NA),
                 h3("Selectivity parameters"),
                 h4("Knife-edged"),
                 numericInput("Knife_selex", "Length at 1st full selectivity",  value=NA),
                 h4("Logistic"),
                 numericInput("Logselex_50%", "Length at 50% selectivity",  value=NA),
                 numericInput("Logselex_95%", "Length at 90% selectivity",value=NA),
                 h4("Dome-shaped"),
                 numericInput("LV_dome", "Length less than full selectivity",  value=NA),
                 numericInput("SelFull_dome", "Length at full selectivity",  value=NA),
                 numericInput("RV_dome", "Length greater than full selectivity",value=NA)
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
