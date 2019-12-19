#
library(shiny)
library(dplyr)
library(pxR)
library(ggplot2)


data_1 <- read.px("http://www.ine.es/jaxi/files/_px/es/px/t14/p061/a2016/l0/01006.px?nocab=1") %>% as.data.frame()

library(shiny)

ui<-fluidPage(
  headerPanel(""),
  sidebarPanel("Seleccione",
              
               
               selectInput('Ramas',
                           label = 'Ramas de Actividad',
                           choices = c("TOTAL EMPRESAS" ="TOTAL EMPRESAS",
                                       "TOTAL SERVICIOS" = "TOTAL SERVICIOS",
                                       "TOTAL INDUSTRIA" ="TOTAL INDUSTRIA",
                                       "29.1. Servicios de I+D (CNAE 72)" = "29.1. Servicios de I+D (CNAE 72)"
                           )#choices
               )#Ramas_SelectedInput
  ),#SidebarPanel
  
  mainPanel("Datos extraídos del INE: Empresas innovadoras",
            plotOutput('grafico1_1')
  )#main_Panel
  
)#Fluid_Page

server<-function(input, output) {
  
  
  output$grafico1_1 <- renderPlot({
    query = filter(data_1, data_1$Ramas.de.actividad==input$Ramas)
    ggplot(query, aes(x=Tamaño.de.la.empresa, y=value, fill=Tipo.de.indicador)) + geom_bar(stat="identity")
  })
  
    }#server

# Run the application 
shinyApp(ui = ui, server = server)

