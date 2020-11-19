#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Main structure
    fluidPage(
      shinyalert::useShinyalert(),
      # App title
      titlePanel(
        div(
          HTML('
          <div class="row" style="background-color:#656668; border-radius:15px; display:flex; justify-content: left; margin: 20px">
            <div class="column" style="margin:20px"><img src="www/golotipo.png" height="130px"></div>
            <div class="column" style="margin-top:40px; font-size: 60px; font:Source Sans Pro; color:#EAEAEA"><b>&nbsp Vanishing: Light Boost Data</b></div>
          </div>
               ')
          )
      ),
      uiOutput("ui")
    ))
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  add_resource_path(
    'www', app_sys('app/www')
  )
  tags$head(
    tags$link(rel = "icon", href = "golotipo.png"),
    tags$style(HTML("
    .shiny-options-group 
    {
      -webkit-column-count: 3; /* Chrome, Safari, Opera /
      -moz-column-count: 3;    / Firefox */
      column-count: 3;
      -moz-column-fill: balanced;
      -column-fill: balanced;
    }
    .checkbox-inline+.checkbox-inline, .radio-inline+.radio-inline 
    {
      margin-left: unset;
    }
    .checkbox-inline 
    { 
      margin-left: 0px;
      width: 100%;
      margin-right: 20px;
    }
        ")),
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'VLBoost'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

