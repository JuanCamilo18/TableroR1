
library(shiny)
library(shinydashboard)

##### ------------------------------------------------------#######
## shiny dashboard: tiene 3 elementos dentro de su estructua
## ui: la interfaz o parte visual del dashboard
## server: es la parte funcional
## el ui llama a los elementos del server
## el 3 elemento es el shinyapp: va coger a ui y server y arrojar el aplicativo

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
                                  menuItem("Primera ventana"),
                                  menuSubItem("Primera sub-ventana"),
                                  # que esten dentro
                                  menuItem("Segunda ventana", id = "chartsID",
                                           menuSubItem("subventana 1"),
                                           menuSubItem("subventana 2"),
                                           menuSubItem("subventana 3", icon = icon("search"))
                                  )
                      )
                    ),
                    ### ---
                    dashboardBody()
                    )

server <- function(input, output){
  
}


shinyApp(ui, server)




