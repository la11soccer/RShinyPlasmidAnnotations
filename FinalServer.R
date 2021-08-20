#import statements
library(shiny)
library(reticulate)
library(ggplot2)
library(rlang)
os <- import("os")

#use retuculate package to use python script
reticulate::source_python('~/Documents/HonorsProject/outDir/FunctionTest.py')

# block of code below is an example of what getting PROKKA run output to user might look like  
#######################################################
'''withConsoleRedirect <- function(containerId, expr) {
    # Change type="output" to type="message" to catch stderr
    # (messages, warnings, and errors) instead of stdout.
    txt <- capture.output(results <- expr, type = "message")
    if (length(txt) > 0) {
        insertUI(paste0("#", containerId), where = "beforeEnd",
                 ui = paste0(txt, "\n", collapse = "")
        )
    }
    results
}'''
##########################################################
#shiny server function
shinyServer(function(input, output) {
    
    #function to give the filepath of input file
    file_name <-reactive({
        inFile <- input$file
        return(inFile$datapath)
    })
    
    #function observes user action for when they press a button
    observeEvent(input$button,{
        
            #fasta file input by user
           example_file.fasta <- file_name()
             example_file.fasta
                    #remove the results from previous PROKKA run
                    system(paste("rm ~/Documents/HonorsProject/outDir/ourDir1/PROKKA*"))
                    #call to PROKKA with new user input file
                    system(paste("prokka --outdir ~/Documents/HonorsProject/outDir/ourDir1 --force --proteins ~/Documents/HonorsProject/outDir/Summer19CompleteDatabase.faa --evalue 0.001 --addgenes ", example_file.fasta))
                    
                    #get the tbl file from PROKKA output so we can pass it into the scripts
                    files <- list.files(path = "~/Documents/HonorsProject/outDir/ourDir1", pattern = "tbl")
                    #print(files)
                    #set directory to direct the output files from the python script run 
                    setwd("~/Documents/HonorsProject/outDir/ourDir1")
                    
                    #call python script on on tbl file 
                    fullRun("PROKKA",files)
                    #print("here")
                    
                    #code for histogram 
                    output$plot <- renderPlot({
                    inFile = "PROKKARCompatibleTable.csv"
                    df <- read.csv(inFile, header = TRUE)
                    p <- ggplot(data =df[4], aes(x= ResType, colour = ResType, fill=ResType, label = "Count")) 
                    #p + coord_cartesian(ylim = c(0,20))
                    p + theme(axis.text.x = element_text(angle = 90) ) + geom_bar() 
                    
                    })
                    print("done") #print to council
    #allow for user download of files
    output$downloadData <- downloadHandler(
       #zip files for download
        filename = function() {
            paste(input$outputFile, ".zip", sep="")
        },
        content = function(file){
            fileCopied <- c()
            setwd("~/Documents/HonorsProject/outDir/ourDir1")
            #do not include python script output files in downloaded files - advised by Dr. Page. Python files only needed for visualization
            files <- list.files(path = "~/Documents/HonorsProject/outDir/ourDir1", pattern = "[^(csv)]$")
            for (i in 1:length(files)){
                fileCopied <- c(paste(files[i]), fileCopied)
            }
            #print(files)
            #zip up appropriate files
            zip(zipfile = file, files = fileCopied)
        },
        contentType = "application/zip")
    
    
}) })
