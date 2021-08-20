
#import statements 
library(markdown)
library(shiny)
library(shinyWidgets)
library(reticulate)
library(shinyjs)
library(ggplot2)
library(rlang)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    shinyjs::useShinyjs(),
   
    # Application title and home page information
    tags$h2("Plasmid Annotations", style="color:ghostwhite"), setBackgroundColor(color = c("#20B2AA","#1E90FF", "#20B2AA"), gradient = "radial", direction = "bottom"),
    navbarPage("Plasmid Annotation Assistant", 
               tabPanel("Intro",
                                   column(6,h4(strong("Hello! Welcome to my tool to assist with plasmid genome annotation and visualization."), style = "font-size: 25px"), h5(strong("To get started please do read carefully through my short introduction. Enjoy! "), style = "font-size: 19px"),
                                          br(),br(),h5(strong("STEP 1) Upload a FASTA sequence for annotation. Please make sure your sequence is in proper FASTA format (example below). The program reads based off of this format and its spacing, if they are not correct the program
                                             will not run and there will be no error messages.")),h6(strong(">AE017043.1 Yersinia pestis biovar Microtus str. 91001 plasmid pCD1, complete sequence
TGTAACGAACGGTGCAATAGTGATCCACACCCAACGCCTGAAATCAGATCCAGGGGGTAA
TCTGCTCTCCTGATTCAGGAGAGTTTATGGTCACTTTTGAGACAGTTATGGAAATTAAAA
TCCTGCACAAGCAGGGAATGAGTAGCCGGGCGATTGCCAGAGAACTGGGGATCTCCCGCA
ATACCGTTAAACGTTATTTGCAGGCAAAATCTGAGCCGCCAAAATATACGCCGCGACCTG
CTGTTGCTTCACTCCTGGATGAATACCGGGATTATATTCGTCAACGCATCGCCGATGCTC
ATCCTTACAAAATCCCGGCAACGGTAATCGCTCGCGAGATCAGAGACCAGGGATATCGTG
GCGGAATGACCATTCTCAGGGCATTCATTCGTTCTCTCTCGGTTCCTCAGGAGCAGGAGC
CTGCCGTTCGGTTCGAAACTGAACCCGGACGACAGATGCAGGTTGACTGGGGCACTATGC
GTAATGGTCGCTCACCGCTTCACGTGTTCGTTGCTGTTCTCGGATACAGCCGAATGCTGT
ACATCGAATTCACTGACAATATGCGTTATGACACGCTGGAGACCTGCCATCGTAATGCGT
TCCGCTTCTTTGGTGGTGTGCCGCGCGAAGTGTTGTATGACAATATGAAAACTGTGGTTC
TGCAACGTGACGCATATCAGACCGGTCAGCACCGGTTCCATCCTTCGCTGTGGCAGTTCG
GCAAGGAGATGGGCTTCTCTCCCCGACTGTGTCGCCCCTTCAGGGCACAGACTAAAGGTA
AGGTGGAACGGATGGTGCAGTACACCCGTAACAGTTTTTACATCCCACTAATGACTCGCC
TGCGCCCGATGGGGATCACTGTCGATGTTGAAACAGCCAACCGCCACGGTCTGCGCTGGC
")), h5(strong("STEP 2) After file has been uploaded, click the annotate button. This calls PROKKA and starts the gene annotation. Do not expect command line output, there is none.
The gene visualization will pop up when your annotation is completed and ready for download! Alternatively, you can press the download button early and your results will automatically be downloaded after annotation is completed."))),
                                   column(3,
                                          img(src="QF7EcGo.png", height = '275', width = "300"))
                          ),
               #create tabs on home page for application use
               tabPanel("Annotate", fileInput("file", label =  "Choose file", accept = c(".fasta", ".fsa")), 
                        textInput("outputFile", label = "Enter folder you would like annotations to go to", value = Sys.Date(), placeholder = "prokkaOutput"),
                        actionButton("button","Annotate"),
                        downloadButton("downloadData", "Download"), 
                        verbatimTextOutput("outmessage"),
                        plotOutput("plot")
                        
                        )
               
                        
                
    
)))

