library(shiny)
library(reticulate)
library(ggplot2)
library(rlang)

os <- import("os")
# Define server logic required to draw a histogram
reticulate::source_python('~/Documents/HonorsProject/outDir/FunctionTest.py')

withConsoleRedirect <- function(containerId, expr) {
    # Change type="output" to type="message" to catch stderr
    # (messages, warnings, and errors) instead of stdout.
    txt <- capture.output(results <- expr, type = "message")
    if (length(txt) > 0) {
        insertUI(paste0("#", containerId), where = "beforeEnd",
                 ui = paste0(txt, "\n", collapse = "")
        )
    }
    results
}

shinyServer(function(input, output) {
    
    #function to give the filepath of input file
    file_name <-reactive({
        inFile <- input$file
        #print(inFile$datapath)
        #print(getwd())
        return(inFile$datapath)
    })
    
    #print(paste("file_name: ",file_name))
    
    observeEvent(input$button,{
        
           example_file.fasta <- file_name()
             example_file.fasta
            
                    system(paste("rm ~/Documents/HonorsProject/outDir/ourDir1/PROKKA*"))
                    system(paste("prokka --outdir ~/Documents/HonorsProject/outDir/ourDir1 --force --proteins ~/Documents/HonorsProject/outDir/Summer19CompleteDatabase.faa --evalue 0.001 --addgenes ", example_file.fasta))
                    
                    #get the tbl file so we can pass it into the scripts
                    files <- list.files(path = "~/Documents/HonorsProject/outDir/ourDir1", pattern = "tbl")
                    print(files)
                    setwd("~/Documents/HonorsProject/outDir/ourDir1")
                    fullRun("PROKKA",files)
                    print("here")
                    
                    output$plot <- renderPlot({
                    inFile = "PROKKARCompatibleTable.csv"
                    df <- read.csv(inFile, header = TRUE)
                    p <- ggplot(data =df[4], aes(x= ResType, colour = ResType, fill=ResType, label = "Count")) 
                    #p + coord_cartesian(ylim = c(0,20))
                    p + theme(axis.text.x = element_text(angle = 90) ) + geom_bar() 
                    
                   
                    })
                    print("done")
    
    output$downloadData <- downloadHandler(
       
        filename = function() {
            paste(input$outputFile, ".zip", sep="")
        },
        content = function(file){
            
            
            fileCopied <- c()
            
            setwd("~/Documents/HonorsProject/outDir/ourDir1")
            files <- list.files(path = "~/Documents/HonorsProject/outDir/ourDir1", pattern = "[^(csv)]$")
            for (i in 1:length(files)){
                fileCopied <- c(paste(files[i]), fileCopied)
            }
            print(files)
            
            zip(zipfile = file, files = fileCopied)
            
            
        },
        contentType = "application/zip")
    
    
}) })
