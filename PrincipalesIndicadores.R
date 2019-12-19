#
library(shiny)
library(dplyr)
library(pxR)
library(ggplot2)


data_3 <- read.px("http://www.ine.es/jaxi/files/_px/es/px/t14/p061/a2016/l0/00001.px?nocab=1") %>% as.data.frame()

library(shiny)

ui<-fluidPage(
  headerPanel(""),
  sidebarPanel("Seleccione",
               
               
               selectInput('Indicadores',
                           label = 'Princpales Indicadores de innovacción tecnológica',
                           choices = c("Gastos en innovación: Total (miles de euros)" ="Gastos en innovación: Total (miles de euros)",
                                       "% de la cifra de negocios en productos nuevos y mejorados" = "% de la cifra de negocios en productos nuevos y mejorados",
                                       "Gastos en innovación: Otras actividades innovadoras (%)" ="Gastos en innovación: Otras actividades innovadoras (%)",
                                       "Gastos en innovación: I+D (internos y externos) (%)" = "Gastos en innovación: I+D (internos y externos) (%)",
                                       "Gastos en innovación: Total (miles de euros)" = "Gastos en innovación: Total (miles de euros)"
                           )#choices
               )#Ramas_SelectedInput
  ),#SidebarPanel
  
  mainPanel("Datos extraídos del INE: Principales indicadores de innovación tecnológica",
            plotOutput('grafico1_1')
  )#main_Panel
  
)#Fluid_Page

server<-function(input, output) {
  
  
  output$grafico1_1 <- renderPlot({
    query = filter(data_3, data_3$Principales.indicadores.de.innovación.tecnológica.2016==input$Indicadores)
    query = query[query$Ramas.de.actividad=="TOTAL EMPRESAS" | query$Ramas.de.actividad=="TOTAL INDUSTRIA" | query$Ramas.de.actividad=="TOTAL SERVICIOS",]
    ggplot(query, aes(x=Ramas.de.actividad, y=value)) + geom_bar(stat="identity", fill="black")
  })

}#server

# Run the application 
shinyApp(ui = ui, server = server)

