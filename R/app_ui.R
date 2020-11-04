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
      # App title
      titlePanel(
        div(
          HTML('
          <div class="row" style="background-color:#EAEAEA; border-radius:15px; display:flex; justify-content: left; margin: 20px">
            <div class="column" style="margin:20px"><img src="www/golotipo.png" height="auto"></div>
            <div class="column" style="margin-top:40px; font-size: 60px; font:Source Sans Pro; color:#656668"><b>&nbsp Vanishing: Light Boost Data</b></div>
          </div>
               ')
          )
      ),
      # titlePanel(
      #   HTML(
      #   "<div class='parent'>
      #     <div class='child inline-block-child'><b>Vanishing Light Boost Data</b></div>
      #     <div class='child inline-block-child'>"tags$img(src = 'www/golotipo.png', align = 'left')"</div>
      #     </div>"
      #     )
      #   ),
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
    # tags$link(rel = "shortcut icon", href = "www/golotipo.png"),
    tags$style(HTML(
    ".checkbox-inline { 
                    margin-left: 0px;
                    margin-right: 10px;
          }
     .checkbox-inline+.checkbox-inline {
                    margin-left: 0px;
                    margin-right: 10px;
          }
        ")),
    favicon("golotipo.ico"),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'vanishong'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

