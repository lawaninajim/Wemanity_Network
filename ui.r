library(shiny)
library(visNetwork)
library(shinydashboard)


ui <- dashboardPage(
  dashboardHeader(title = "Wemanity Network"),
  
  dashboardSidebar(
    width = 400,
    title= h2("Entreprise"),
    
    selectInput("text",
                label = "Choisir une structure",
                choices = list("Wemanity",
                               "WeDigitalGarden",
                               "WeCanopy",
                               "Birdz",
                               "Bare Foot & Co",
                               "Publithings",
                               "Fvrther",
                               "Kyokita",
                               "Weniversity")
                
                ,selected = "Wemanity"
    ),
    
    
    
    
    # box(
    #   width = NULL,   
    #   title="info",
    #   status="primary",
    #   solidHeader = TRUE,
    #   collapsible = TRUE,
    textOutput("select"),
    textOutput("text")
    #visNetworkOutput("network")
  ),
  
  dashboardBody(
    
    box(
      width = NULL,   
      title="Info",
      status="primary",
      # solidHeader = TRUE,
      collapsible = TRUE,
      valueBoxOutput("value1"),
      valueBoxOutput("value2"),
      valueBoxOutput("value3")
    ),
    box(
      width = NULL,   
      collapsible = TRUE,
      title="Agile",
      status="primary",
      background =  "navy",
      # solidHeader = TRUE,
      h2(" The right people talking about the right things at the right time",  align = "center")
      
    ),
    
    box(
      width =NULL,
      title="Réseau",
      status="primary",
      # background = "navy",
      # solidHeader = TRUE,
      collapsible = TRUE,
      visNetworkOutput("network")
    ),
    fluidRow(
      
    )
  )
)
