#' plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        shinydashboard::box(
          title = "",
          width = 12,
          DT::dataTableOutput(ns('table')))
      )
    )
  )
}
    
#' plot Server Function
#'
#' @noRd 
mod_plot_server <- function(input, output, session){
  ns <- session$ns
  load("data/data.rda")
  # browser()
  # rownames(data) <- data[,1]
  # data <- data[,-1]
  data <- DT::datatable(data) %>% 
    DT::formatStyle(
      'Raider',
      target = 'row',
      backgroundColor = DT::styleEqual(c("Vanishing"), c('#85c1e9'))
  )
  
  output$table <- DT::renderDT(data,
                               options = list(
                                 pageLength = 5,
                                 initComplete = I("function(settings, json) {alert('Done.');}")
                              ))
}
    
## To be copied in the UI
# mod_plot_ui("plot_ui_1")
    
## To be copied in the server
# callModule(mod_plot_server, "plot_ui_1")
 
