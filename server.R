#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  #output$value <- renderText({
   # require(input$file)
    
    #function to give the filepath of input file
  file_name <-reactive({
    inFile <- input$file
    #print(inFile$datapath)
    #print(getwd())
    return(inFile$datapath)
  })
  
  #print(paste("file_name: ",file_name))
    
  observeEvent(input$button,{
    #session$sendCustomMessage(type = "testmessage", message = "Sequence being annotated...")
    
    output$percentage <- renderTable(
      
      print("System running annotations, please DO NOT press download until system says complete. This may take a few minutes.")
      
    )
    
    output$percentage <- renderText({
      example_file.fasta <- file_name()
      example_file.fasta
      
      
      
      #print("System running annotations....")
      
      system(paste("prokka --outdir ~/Documents/HonorsProject/outDir --force --proteins ~/SummerResearch19/Summer19CompleteDatabase.faa --evalue 0.001 --addgenes ", example_file.fasta))
    #", input$outputFile, "
  })
  
    # output$percentage <- renderTable(
    #   
    #   print("Annotations Complete")
    #   
    # )
    
    #print(paste("output_filename: ", output_filename ))
  })
  
  #data <- TESTER921
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$outputFile, ".zip", sep="")
    },
    content = function(file){
      
      
      fileCopied <- c()
      
      setwd("~/Documents/HonorsProject/outDir/")
      files <- list.files(path = "~/Documents/HonorsProject/outDir/");
      for (i in 1:length(files)){
        fileCopied <- c(paste(files[i]), fileCopied)
      }
      print(files)
      
      zip(zipfile = file, files = fileCopied)
      
      
    },
    contentType = "application/zip")

  
})
    
  
  

  
  
  

