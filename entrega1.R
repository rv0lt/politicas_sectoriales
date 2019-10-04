library(pxR)


#Innovación tecnológica en el período 2014-2016: Empresas innovadoras según la clase de empresa por ramas de actividad, tipo de indicador y tamaño de la empresa.
data_1 <- read.px("http://www.ine.es/jaxi/files/_px/es/px/t14/p061/a2016/l0/01006.px?nocab=1") %>% as.data.frame()

#Actividades para la innovación tecnológica 2016: Empresas que han realizado I+D por ramas de actividad, tipo de indicador y tamaño de la empresa.
data_2 <- read.px("http://www.ine.es/jaxi/files/_px/es/px/t14/p061/a2016/l0/01002.px?nocab=1") %>% as.data.frame()

#Principales indicadores de innovación tecnológica 2016 por rama de actividad
data_3 <- read.px("http://www.ine.es/jaxi/files/_px/es/px/t14/p061/a2016/l0/00001.px?nocab=1") %>% as.data.frame()






