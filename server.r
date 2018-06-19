#Paquets à charger pour exécuter le projet
`%then%` <- shiny:::`%OR%`
library(ggplot2)
library(plyr)
library(shiny)
library(visNetwork)
library(shinydashboard)

#Chargement des fichiers contenants les données
allLinks<- read.csv("data/Links.csv", sep = ";", header =TRUE)
allnodes<- read.csv("data/Nodes.csv", sep = ";", header =TRUE)

#Liste des différentes structures de Wemanity
listEntreprise <- as.list(as.character(allnodes$id))


#Exécution du code côté serveur
server <- function(input, output) {
  
  # récupérer la valeur selectionnée dans le formulaire de début
  output$text <- renderText({ 
    paste ("Vous avez sélectionné :", input$text)
  })
  
  
  
  
  #création du contenu de la box du nombre de filles
  output$value1 <- renderValueBox({
    Mere<- subset(allLinks, from== input$text)
    countMere <- count(Mere)
    nbFille <- sum(countMere$freq)
    valueBox(
      
      formatC(nbFille, format="d", big.mark=',')
      ,paste('Nombre de filles:')
      ,icon = icon("stats",lib='glyphicon')
      ,color = "purple")
  })
  
  
  #création du contenu de la box  code Postal
  output$value2 <- renderValueBox({ 
    cp <- subset(allnodes$CodePostale, allnodes$label == input$text)
    valueBox(
      formatC(cp, format="s", big.mark=',')
      ,'Code Postal:'
      ,icon = icon("align-center ",lib='glyphicon')
      ,color = "green")  
  })
  
  
  #création du contenu de la box top entreprise
  output$value3 <- renderValueBox({
    li<- subset(allLinks, from== input$text)
    HighValue<-max(li$Pourcentage)
    entrepriseHighMere <- as.character(li$to[li$Pourcentage == HighValue]) 
    valueBox(
      formatC(entrepriseHighMere, format="d", big.mark=',')
      ,paste('Top Entreprise:')
      ,icon = icon("menu-hamburger",lib='glyphicon')
      ,color = "yellow")   
  })

  
  #Etape Affichage du réseau
  output$network <-renderVisNetwork({
    
    #Récupération des filles ou des mères de la structure sélectionnée
    links<- subset(allLinks, from== input$text| to == input$text)
    listLink1 <- as.character(links$from)
    listLink2 <- as.character(links$to)
    listLink<- c(listLink1,listLink2)
    listLink<-as.list(listLink)
    listnodes<-as.list(as.character(allnodes$label))
    finalNodes <- subset(allnodes, (listnodes %in% listLink))
    
    #Custum de l'affichage des noeuds
    finalNodes$shape <- "dot"  
    finalNodes$size <- 50
    finalNodes$shadow <- TRUE # Nodes will drop shadow
    finalNodes$lab <- finalNodes$label # Node label
    finalNodes$label <- finalNodes$label # Node label
    finalNodes$color.border <- "black"
    finalNodes$color.highlight.background <- "orange"
    finalNodes$color.highlight.border <- "darkred"
    
    #Custum de l'affichage des liens
    
    links$width <- 5 # line width
    links$color <- "lightblue"    # line color  
    links$arrows <- "to" # arrows: 'from', 'to', or 'middle'
    links$smooth <- FALSE    # should the edges be curved?
    links$shadow <- FALSE
    links$length <- 200
    #Afficher des informations au clic
    links$label <- paste0(links$Pourcentage,"%")
    links$label.font = "1000px Arial";
    
    #Affichage du réseau
    visNetwork(finalNodes, links,  width="100%", height="500px")
  }) 
}





