#' admin UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_admin_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("ADMIN")
  )
}
    
#' admin Server Function
#'
#' @noRd 
mod_admin_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_admin_ui("admin_ui_1")
    
## To be copied in the server
# callModule(mod_admin_server, "admin_ui_1")
 
