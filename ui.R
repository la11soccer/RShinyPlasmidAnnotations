#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  #downloadUI = FALSE,
  # Application title
  titlePanel("Plasmid Gene Annotation"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #function for file ipload
      #checkboxInput("text1", "file1"),
      
      #conditionalPanel(
        #condition = "input.file1 == true",
        fileInput("file", label =  "Choose file", accept = c(".fasta", ".fsa")), 
        #),
        textInput("outputFile", label = "Enter folder you would like annotations to go to", value = Sys.Date(), placeholder = "prokkaOutput"),
        actionButton("button","Annotate"),
      
        downloadButton("downloadData", "Download")
      #)
    
      ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("percentage")
      #checkboxInput("text1", "file1")
    )
    )
  ))

