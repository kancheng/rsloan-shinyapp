library(shiny)


# UI R File & Object

shinyUI(
  fluidPage(
    includeCSS(path = "./www/main.css"),
    tags$head(
      tags$link(rel = "shortcut icon", href = "https://raw.githubusercontent.com/kancheng/rsloan-shinyapp/master/www/favicon.ico")
    ),
    navbarPage("RSLoan",
               
               tabPanel( "Home",
                         
                         div( id = "home-txtbg",
                              div( id = "home-txtct", "RSLoan"),
                              
                              br(),
                              br(),
                              
                              div( id = "home-micttxt",
                                   "The system is to analyze students' learning performance and economic status.")
                              ,br()),
                         
                         div( titlePanel("About"),
                              "Organization : Lunghwa University of Science and Technology",
                              br(),
                              "Author : ", a("Haoye",href="https://kancheng.github.io/"),
                              br(),
                              "Github : ",a("https://github.com/kancheng/rsloan-shinyapp",href="https://github.com/kancheng/rsloan-shinyapp"),
                              br(),
                              "ResearchGate : ",a("https://www.researchgate.net/profile/Hao_Cheng_Kan",href="https://www.researchgate.net/profile/Hao_Cheng_Kan")
                         )
               ),
               tabPanel("Work",
                        tabsetPanel("Analyze",
                                    tabPanel("Import",
                                             sidebarLayout(
                                               sidebarPanel(width = 3,
                                                            radioButtons("inputdt", "Choose :",
                                                                         c("Sample Data" = "wkdsct","External Data" = "wkupfdt")
                                                            ),
                                                            numericInput("obsr", "Row View:", 15, min = 1, width = "100%"),
                                                            numericInput("obsc", "Col View:", 20, min = 1, width = "100%"),
                                                            submitButton("Update", icon("refresh"), width = "100%"),
                                                            # tags$hr(),
                                                            tags$br(),
                                                            selectInput("dataset", "Sample Data :", 
                                                                        choices = c(
                                                                          "demo")),
                                                            fileInput('upfile', 'External Data : ',
                                                                      accept = c('text/csv', 
                                                                                 'text/comma-separated-values,text/plain',  '.csv')),
                                                            checkboxInput('header', 'Header', TRUE),
                                                            radioButtons('sep', 'Separator',
                                                                         c(Comma=',',
                                                                           Semicolon=';',
                                                                           Tab='\t'),
                                                                         ','),
                                                            radioButtons('quote', 'Quote',
                                                                         c(None='',
                                                                           'Double Quote'='"',
                                                                           'Single Quote'="'"),
                                                                         '"'),
                                                            helpText("Please follow the instruction went Upload dataset.")),
                                               mainPanel(width = 7,
                                                         br(),
                                                         h1("Observations"),
                                                         br(),
                                                         tableOutput("view")
                                               )
                                             )
                                    )
                              )
               ),
               tabPanel("Instruction",
                        sidebarLayout(
                          sidebarPanel("Instruction",
                                       downloadButton('downloadDemo', 'Download')
                          ),
                          mainPanel(
                            # demo data csv
                            tableOutput("swdmtb")
                          )
                        )
               )
    )        
    )
)