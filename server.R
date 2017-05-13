set.seed(929)

library(shiny)

# SERVER R File & Object

server = function(input, output, session) {
  
  # tem
  tmsp = reactiveValues()

  # source r file
  source("./data/demo.R")
  
  # Instruction
  output$swdmtb = renderTable({demo}, caption = paste("If you want to use the RSLoan, Please download demo csv file."),
                              caption.placement = getOption("xtable.caption.placement", "top"),
                              caption.width = getOption("xtable.caption.width", NULL)
  )

  # all table name
  # tablename = dbGetQuery(conn, "SHOW TABLES")
  
  # Data Input
  
  output$view = renderTable({
    indsw = switch(input$inputdt,
                   
                   wkupfdt = {
                     inFile = input$upfile
                     if (is.null(inFile)){ return(NULL) }
                     tmsp$cudf = read.csv(inFile$datapath, header = input$header, sep = input$sep,  quote = input$quote)
                     if ( length(colnames(tmsp$cudf)) < 20 ){
                       head( tmsp$cudf , n = input$obsr)[1:length(colnames(tmsp$cudf))]
                     }else{
                       head( tmsp$cudf , n = input$obsr)[1:input$obsc]
                     }
                     
                   },
                   
                   wkdsct = {
                     tmsp$cudf = datasetInput()
                     if ( length(colnames(tmsp$cudf)) < 20 ){
                       head( tmsp$cudf , n = input$obsr)[1:length(colnames(tmsp$cudf))]
                     }else{
                       head( tmsp$cudf , n = input$obsr)[1:input$obsc]
                     }
                     
                   }
    )
  })
  
  datasetInput = reactive({
    switch(input$dataset,
           # "table" = tablename,
           "demo" = demo
    )
  })
  
  # Instruction
  
  output$downloadDemo = downloadHandler(
    filename = function() { 
      paste( "demo", '.csv', sep = '') 
    },
    content = function(file) {
      write.csv(demo, file)
    }
  )
}