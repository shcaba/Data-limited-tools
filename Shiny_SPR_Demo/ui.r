library(shiny)

shinyUI(fluidPage(
  titlePanel("Length-based SPR"),
  fluidRow(
    column(2,
      h4("Life history parameters"),
      numericInput("MK", label = ("M/K ratio"), value = 1.5, step=0.05, min=0.1, max=10),
	  numericInput("Linf", label = ("Linf"), value = 100, step=1, min=10),
	  h4("Maturity-at-length"),
	  numericInput("L50", label = ("L50"), value = 66, step=1, min=1),
	  numericInput("L95", label = ("L95"), value = 70, step=1, min=1),
	  sliderInput("steepness",
                  h4("Steepness"),
                  min = 0.2,
                  max = 1,
                  value = 1,
				  step=0.01),
	  tags$hr()
	),
	column(2, 
	  h4("Histogram control"),
	  sliderInput("binswidth",
                  "Width of length bins:",
                  min = 1,
                  max = 10,
                  value = 2),
	  conditionalPanel(
	    "$('li.active a').first().html()==='Simulation'",
        # actionButton("bar","Bar") ),
	  h4("Selectivity-at-length"),
	  numericInput("SL50", label = ("SL50"), value = 66, step=1, min=1),
	  numericInput("SL95", label = ("SL95"), value = 70, step=1, min=1),
	  sliderInput("setSPR",
                  h4("Spawning Potential Ratio"),
                  min = 0,
                  max = 1,
                  value = 0.4,
				  step=0.01)
	  ),
	  conditionalPanel(
	    "$('li.active a').first().html()==='Upload Data'",
		fileInput('file1', 'Choose file to upload',
          accept = c(
            'text/csv',
            'text/comma-separated-values',
            'text/tab-separated-values',
            'text/plain',
            '.csv',
            '.tsv'
            )
        ),
        checkboxInput('header', 'Header', FALSE),
        radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ',')
	   ),
	   conditionalPanel(
	    "$('li.active a').first().html()==='Assessment'",
		br(),
		h4("Steps"),
		tags$ol(
          tags$li("Ensure that data has been uploaded correctly (Upload Data tab)"), 
		  tags$li("Adjust width of length bins to suit data"), 
          tags$li("Set values for biological parameters"), 
          tags$li("Click 'Run Assessment'"),
		  tags$li("Visually check model fit to data"),
		  tags$li("Check estimated selectivity parameters")
        ),
        actionButton("goButton", "Run Assessment"),
        p("")
	  )
	),
    tags$hr(),
	
	column(8,
	mainPanel(
	    tabsetPanel(      
	    tabPanel("Simulation", plotOutput("SPRSimulation", height="auto")),
		tabPanel("Upload Data", 
		  h3("Check that data has been uploaded correctly"),
		  br(),
		  h4("File should be a CSV or text file."),
          h4("Data should be either:"),
		  tags$ul(
           tags$li("A single column of length measurements"), 
           tags$li("Two columns, with length classes in first column, and observations in second column") 
          ),
		  h4("First 6 rows of data file:"),
		  tableOutput("head"),
		  h3(textOutput("datSum"))),
        tabPanel("Assessment", plotOutput("SPRAssessment", height="auto")),
        id = "tabs1"
      ))
	)
  )
  )
 ) 
  
  # , # End simulation tab 
  # # Assessment tab 
    # tabPanel("Assessment",
   # fluidRow(
    # column(2,
      # h4("Life history parameters"),
      # numericInput("MK2", label = ("M/K ratio"), value = 1.5, step=0.05, min=0.1, max=10),
	  # numericInput("Linf2", label = ("Linf"), value = 100, step=1, min=10),
	   # h4("Maturity-at-length"),
	  # numericInput("L502", label = ("L50"), value = 66, step=1, min=1),
	  # numericInput("L952", label = ("L95"), value = 70, step=1, min=1),
	  # sliderInput("steepness",
                  # h4("Steepness"),
                  # min = 0.2,
                  # max = 1,
                  # value = 1,
				  # step=0.01),
	  # tags$hr()
	  # ),
	  # column(2,
	  # h4("Histogram control"),
	  # sliderInput("binswidth2",
                  # "Width of length bins:",
                  # min = 1,
                  # max = 10,
                  # value = 2),
	  # tags$hr(),
 	  # fileInput('file1', 'Choose file to upload',
                # accept = c(
                  # 'text/csv',
                  # 'text/comma-separated-values',
                  # 'text/tab-separated-values',
                  # 'text/plain',
                  # '.csv',
                  # '.tsv'
                # )
      # ),
	  # checkboxInput('header', 'Header', FALSE),
      # radioButtons('sep', 'Separator',
                   # c(Comma=',',
                     # Semicolon=';',
                     # Tab='\t'),
                   # ','),
      # tags$hr()
	 
    # ),
    # column(7, 
      # plotOutput("SPRSAssessment")
	# )
  # )
  # )
# ))


# # library(shiny)

# # shinyUI(fluidPage(
  # # titlePanel("Length-based SPR"),
  # # sidebarLayout(
    # # sidebarPanel(
      # fileInput('file1', 'Choose file to upload',
                # accept = c(
                  # 'text/csv',
                  # 'text/comma-separated-values',
                  # 'text/tab-separated-values',
                  # 'text/plain',
                  # '.csv',
                  # '.tsv'
                # )
      # ),
      # checkboxInput('header', 'Header', FALSE),
      # radioButtons('sep', 'Separator',
                   # c(Comma=',',
                     # Semicolon=';',
                     # Tab='\t'),
                   # ','),
      # tags$hr(), 
	  # # sliderInput("binswidth",
                  # # "Width of length bins:",
                  # # min = 1,
                  # # max = 30,
                  # # value = 2),
	  # # tags$hr(), 
	  # # h2("Life history parameters"),
      # # # Copy the line below to make a slider bar 
      # # numericInput("MK", label = ("M/K ratio"), value = 1.5, step=0.05, min=0.1, max=10),
	  # # numericInput("Linf", label = ("Linf"), value = 100, step=1, min=10),
	  # # numericInput("L50", label = ("L50"), value = 66, step=1, min=1),
	  # # numericInput("L95", label = ("L95"), value = 70, step=1, min=1)
	
    # # ),
    
	# # mainPanel(
      # # tabsetPanel(      
	    # # tabPanel("Data Summary", tableOutput("head")),
        # # tabPanel("Histogram", plotOutput("hist")),
		# # tabPanel("Maturity-at-length", plotOutput("MatCurve")),
		# # tabPanel("SPR", plotOutput("SPRplot")),
        # # id = "tabs1"
      # )
    # # mainPanel(
      # # uiOutput("tb")
    # )
  # )
# ))




