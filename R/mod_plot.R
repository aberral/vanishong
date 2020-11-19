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
    fluidRow(
      # column(width = 4,
             shinydashboard::box(
               title = "", 
               width = "100%", 
               status = "primary",
               div(style = 'overflow-x: scroll', 
                   DT::dataTableOutput(ns('table')))
             )
           # )
    )
    # fluidPage(DT::dataTableOutput(ns('table'), width = '100%'))
        # shinydashboard::box(
        #   title = "Boost Runs Data",
        #   width = 4,
        #   status = "primary",
        #   solidHeader = T,
        #   DT::dataTableOutput(ns('table')))
        # )
    )
}
    
#' plot Server Function
#'
#' @noRd 
mod_plot_server <- function(input, output, session){
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
  data <- DT::datatable(data) %>% 
    DT::formatStyle(
      'Vanishing',
      backgroundColor = DT::styleEqual(c(0, 1), c("gray", '#85c1e9'))
  )
  
  output$table <- DT::renderDT(data,
                               options = list(
                                 pageLength = 10,
                                 # scrollX = T,
                                 initComplete = I("function(settings, json) {alert('Done.');}")
                              ))
}
    
## To be copied in the UI
# mod_plot_ui("plot_ui_1")
    
## To be copied in the server
# callModule(mod_plot_server, "plot_ui_1")
 
