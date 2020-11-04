#' user UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_user_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("USER")
  )
}
    
#' user Server Function
#'
#' @noRd 
mod_user_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_user_ui("user_ui_1")
    
## To be copied in the server
# callModule(mod_user_server, "user_ui_1")
 
