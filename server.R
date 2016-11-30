library(shiny)
library(ggplot2)
library(magrittr)
library(dplyr)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
server <- function(input, output, session) {
   output$countryOutput <- renderUI({
       selectInput("countryInput", "Country",
                    sort(unique(bcl$Country)),
                    selected = "CANADA")
     })
  
  filtered <- reactive({
    ##IF statement make it so we dont get errors thornw up while the country input data is loading
    if(is.null(input$countryInput)) {
      return(NULL)
    }
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })
  
  
  output$coolplot <- renderPlot( { 
    ##IF statements make it so we dont get errors while all the data is loading 
    if(is.null(filtered())) {
      return()
    }
    
   ggplot(filtered(), aes(Alcohol_Content)) + geom_histogram() }) 

  
  output$results <- renderTable({
    filtered()
    
  })
}
