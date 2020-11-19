#' plot.table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_plot.table_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      tabsetPanel(
        tabPanel("Datos",
                 # column(width = 4,
                        shinydashboard::box(
                          title = "", 
                          width = "100%", 
                          status = "primary",
                          div(style = 'overflow-x: scroll', 
                              DT::dataTableOutput(ns('table.user')))
                        )
                        # )
                 # div(DT::dataTableOutput(ns('table.user'), width = '100%')))
        )
      )
    )
  )
}
    
#' plot.table Server Function
#'
#' @noRd 
mod_plot.table_server <- function(input, output, session, user){
  ns <- session$ns
  # browser()
  googledrive::drive_auth(cache = ".secrets")
  googlesheets4::gs4_auth(cache = ".secrets")
  # googlesheets4::gs4_auth_configure(api_key = "AIzaSyDqYnMc_tEKqRJkwdzHfuKPojs7BZZkGQs")
  url <- "https://docs.google.com/spreadsheets/d/1H08X4PUsG-AtTehvmiBCSeE3EmXoPV4kX7h_OckitBk/"
  data <- googlesheets4::range_speedread(url, sheet = "Main")
  # browser()
  # rownames(data) <- data[,1]
  # data <- data[,c(1,2)]
  usuario <- user
  dt <- DT::datatable(data[, c('Infor', 'Label', usuario, 'Vanishing')])
  output$orotot <- renderText({paste0('Oro total conseguido: ', data[1,usuario])})
  # browser()
  output$table.user <- DT::renderDT(dt,
                               options = list(
                                 pageLength = 10,
                                 # scrollX = T,
                                 initComplete = I("function(settings, json) {alert('Done.');}")
                               ))
}
    
## To be copied in the UI
# mod_plot.table_ui("plot.table_ui_1")
    
## To be copied in the server
# callModule(mod_plot.table_server, "plot.table_ui_1")
 
