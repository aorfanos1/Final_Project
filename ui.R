library(shiny)
library('shinythemes')


bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)


ui <- fluidPage(theme = shinytheme('superhero'),
  titlePanel('BC Liquor Store Prices'),
  sidebarLayout(
    sidebarPanel(
      sliderInput('priceInput', 'Price', min = 0, max = 100, value = c(25,40), pre = '$'
      ),
      radioButtons('typeInput', "Product Type", choices = c('BEER', 'WINE', 'REFRESHEMENT', 'SPIRITS'), selected = 'WINE'),
      uiOutput("countryOutput")
    ),
    mainPanel(plotOutput('coolplot'),
              br(),br(),
              tableOutput('results'))
  )
)


