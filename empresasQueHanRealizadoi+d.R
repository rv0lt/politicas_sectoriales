#
library(shiny)
library(dplyr)
library(pxR)
library(ggplot2)


data_2 <- read.px("http://www.ine.es/jaxi/files/_px/es/px/t14/p061/a2016/l0/01002.px?nocab=1") %>% as.data.frame()

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
  
  mainPanel("Datos extraídos del INE: Empresas que han realizado I+D",
            plotOutput('grafico1_1'),
            dataTableOutput('grafico1_2')
  )#main_Panel
  
)#Fluid_Page

server<-function(input, output) {
  
  
  output$grafico1_1 <- renderPlot({
    query = filter(data_2, data_2$Ramas.de.actividad==input$Ramas)
    query = query[query$Tipo.de.indicador!="Total" & (query$Tipo.de.indicador=="-De manera contínua" |query$Tipo.de.indicador=="-De manera ocasional"),]
    ggplot(query, aes(x=Tamaño.de.la.empresa, y=value, fill=Tipo.de.indicador)) + geom_bar(stat="identity")
  })
  output$grafico1_2 <- renderDataTable({
    query = filter(data_2, data_2$Ramas.de.actividad==input$Ramas)
    query = query[query$Tipo.de.indicador!="Total" & (query$Tipo.de.indicador!="-De manera contínua" & query$Tipo.de.indicador!="-De manera ocasional"),]

  })
  
}#server

# Run the application 
shinyApp(ui = ui, server = server)

