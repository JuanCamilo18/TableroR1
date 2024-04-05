
library(shiny)
library(shinydashboard)

##### ------------------------------------------------------#######
## shiny dashboard: tiene 3 elementos dentro de su estructua
## ui: la interfaz o parte visual del dashboard
## server: es la parte funcional
## el ui llama a los elementos del server
## el 3 elemento es el shinyapp: va coger a ui y server y arrojar el aplicativo

##### -------------------------------------------------------------

library(tidyverse)
#options(download.file.method = "wininet") # evitar no descargue paquete
#devtools::install_github("manosaladata/contrataciones-estado-emergencia", subdir = "Roxygen/opencontracts")
#library(opencontracts)

## procesando datos
datas120<- load("data120.rda")
#View(data120)
class(data120)

montos <- ggplot(data120[1:5,], aes(x=Proveedor, y=Monto_Soles_Millones)) +
  geom_bar(stat = "identity", position = "dodge", fill="white", col="steelblue") +
  labs(title = "Montos de contratos adjudicados por proveedor - Top 5",
       subtitle = "(en millones de soles", y="Montos", x="Proveedor", caption = "Jc") + 
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 00, hjust = 0.5, vjust = 0.5)
        ) +
        scale_x_discrete(labels = scales::label_wrap(17)) #ajustar etq -x
montos



##### -------------------------------------------------------------

ui <- dashboardPage(title = "Dashboard", skin = "green",
                    ### ---
                    dashboardHeader(
                      title = "Proyecto",
                      # Create a dropdown menu
                      dropdownMenu(type = "messages",
                                   messageItem(from = "Juan",
                                               "Hola"),
                                   messageItem("Juan2",
                                               "Bienvenidos")
                                   ),
                      dropdownMenu(type = "notifications",
                                   notificationItem(text = "Aprendamos juntos",
                                                    icon = icon("redo")),
                                   notificationItem("Saludos"), # default pone triangulo
                                   notificationItem("Saludos1", icon("list-alt")),
                                   notificationItem("Saludos2", icon("table", lib = "font-awesome")), # default is font-awesome
                                   notificationItem("Saludos2", icon("house", lib = "font-awesome")),
                                   notificationItem("Saludos2", icon("phone", lib = "font-awesome")),
                                   notificationItem("Saludos3", icon("glyphicon glyphicon-play", lib = "glyphicon")),
                                   notificationItem("Saludos3", icon("glyphicon glyphicon-folder-open", lib = "glyphicon")),
                                   notificationItem("Saludos3", icon("glyphicon glyphicon-globe", lib = "glyphicon"))
                                   # icon: https://fontawesome.com/search
                                   # Glyphicons: https://getbootstrap.com/docs/3.3/components/#glyphicons
                                   ),
                      dropdownMenu(type = "tasks",
                                   taskItem(text = "Avance dashboard",
                                            value = 50, color = "blue"),
                                   taskItem("Avance de los ejercicios",
                                            value = 80, color = "yellow")
                                   )
                    ),
                    ### ---
                    dashboardSidebar(
                      sidebarSearchForm("searchText", "buttonSearch", "Buscar",
                                        icon = shiny::icon("magnifying-glass")),
                      sidebarMenu(id="siderbarID",
                                  menuItem("Primera ventana", tabName = "montos"),
                                  menuSubItem("Primera sub-ventana"),
                                  # que esten dentro los submenus
                                  menuItem("Segunda ventana", id = "chartsID",
                                           menuSubItem("subventana 1", 
                                                       tabName = "datos", icon = icon("eye")),
                                           menuSubItem("subventana 2"),
                                           menuSubItem("subventana 3", 
                                                       icon = icon("search"))
                                  )
                      )
                    ),
                    ### ---
                    dashboardBody(
                      tabItems(tabItem(tabName = "datos", #este no igual nombre
                                       DT::dataTableOutput("datos")),
                               
                               tabItem(tabName = "montos",
                                       plotOutput("montos"))
                               )
                    )
                    
    )

server <- function(input, output){
  output$datos <- DT::renderDataTable(data120)
  output$montos <- renderPlot({montos})
}


shinyApp(ui, server)



###
# https://www.andrewheiss.com/blog/2022/06/23/long-labels-ggplot/#option-d-rotate-the-labels





