#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
    res_auth <- shinymanager::secure_server(
        check_credentials = shinymanager::check_credentials(
          "database.sqlite")
    )
    output$auth_output <- renderPrint({
        reactiveValuesToList(res_auth)
    })
    # browser()
    output$ui <- renderUI({
        if(res_auth$user == 'Superuser' | res_auth$user == 'Admin') {
            return(
                tagList(
                    # Sidebar Layout
                    sidebarLayout(
                        # Sidebar panel for inputs
                        sidebarPanel(
                          # Input: Select the roster
                           checkboxGroupInput(inputId = "checkGroup",
                                              inline = T,
                                              label = "Select the boost members", 
                                              choices = c('Aales', 'Aegui', 'Ainhae', 'Akroggy',
                                                          'Aristocrat', 'Ark', 'Arkanoy', 'Bobulol', 'Bogate', 'Byakura',
                                                          'Cordu', 'Cripy', 'Dalaris', 'Dardragon', 'Deathroll', 'Derser',
                                                          'Destiny', 'Dethwatcher', 'Distur', 'Epar', 'Erish', 'Gaude',
                                                          'Griindhouse', 'Gulraz', 'Ibufropeno', 'JoseTrix', 'Kala',
                                                          'Katty', 'Kaz', 'Kenrayo', 'Leiro', 'Lixie', 'Loliripe', 'Lowy',
                                                          'Lyon90', 'Mandarinas', 'Meryna', 'Mugatsu', 'Nai', 'Niebli',
                                                          'Nooj', 'Notnethber', 'Nuks', 'Nysadra', 'Osura', 'Palomero',
                                                          'Paracetelamo', 'Phsyquic', 'Ryxh', 'Sazed', 'Scizor', 'Shamesh',
                                                          'Shiphidos', 'Supare', 'Swarley', 'Tanatos', 'Tirillas', 'Trolemaga',
                                                          'Ursox', 'Virulenta', 'Voodoomed', 'Wonder', 'Zektuk', 'Ñacañuqui'),
                                              selected = ""),
                           # Input: Paste the amount of gold
                           numericInput(inputId = "gold", 
                                        label   = "Paste the gold amount:",
                                        value   = ""),
                           # Include clarifying label ----
                           textInput(inputId = "label", 
                                     label   = "Enter a suitable label:",
                                     value   = ""),
                           # Include clarifying text ----
                           helpText("Note: please only upload the data once.",
                                    "Duplicated data may cause errors."),
                           # Action Button to add the DATA
                           div(style = "display:inline-block;width:100%;text-align: center;",
                             actionButton("update", "Update Data"),
                             actionButton("reset", "Reset"),
                             actionButton("show", "Show data")
                           )
                        ),
                        mainPanel(
                            mod_plot_ui("plot_ui_1"),
                            mod_datatable_ui("datatable_ui_1"),
                            # actionButton("browser", "browser"),
                            # tags$script("$('#browser').hide();")
                        )
                    )
                )
            )
        } else {
            return(
                tagList(
                    mainPanel(
                        mod_plot.table_ui("plot.table_ui_1")
                        # actionButton("browser", "browser"),
                        # tags$script("$('#browser').hide();")
                    )
                )
            )
        }
    })
  # List the first level callModules here
    observeEvent(input$show,{
      shinyalert::shinyalert("Loading data. Please wait!.",
                             type = "info", 
                             closeOnEsc = F,
                             showConfirmButton = F,
                             html = F
      )
      callModule(mod_plot_server, "plot_ui_1")
      shinyalert::closeAlert()
      })
    observeEvent(input$reset,{
      updateCheckboxGroupInput(inputId = "checkGroup",
                               session = session,
                               inline = T,
                               label = "Select the boost members", 
                               choices = c('Aales', 'Aegui', 'Ainhae', 'Akroggy',
                                           'Aristocrat', 'Ark', 'Arkanoy', 'Bobulol', 'Bogate', 'Byakura',
                                           'Cordu', 'Cripy', 'Dalaris', 'Dardragon', 'Deathroll', 'Derser',
                                           'Destiny', 'Dethwatcher', 'Distur', 'Epar', 'Erish', 'Gaude',
                                           'Griindhouse', 'Gulraz', 'Ibufropeno', 'JoseTrix', 'Kala',
                                           'Katty', 'Kaz', 'Kenrayo', 'Leiro', 'Lixie', 'Loliripe', 'Lowy',
                                           'Lyon90', 'Mandarinas', 'Meryna', 'Mugatsu', 'Nai', 'Niebli',
                                           'Nooj', 'Notnethber', 'Nuks', 'Nysadra', 'Osura', 'Palomero',
                                           'Paracetelamo', 'Phsyquic', 'Ryxh', 'Sazed', 'Scizor', 'Shamesh',
                                           'Shiphidos', 'Supare', 'Swarley', 'Tanatos', 'Tirillas', 'Trolemaga',
                                           'Ursox', 'Virulenta', 'Voodoomed', 'Wonder', 'Zektuk', 'Ñacañuqui'),
                               selected = "")
    })
    # Update data with selection
    # Save changes
    observeEvent(input$update,{
      req(input$gold)
      req(input$checkGroup)
      gold <- input$gold

    })
    observeEvent(res_auth$user, {
      # browser()
      if(res_auth$user == 'Superuser' | res_auth$user == 'Admin') {
        observeEvent(input$update,{
          req(input$gold)
          req(input$checkGroup)
          req(input$label)
          gold    <- input$gold
          members <- input$checkGroup
          label <- input$label
          if (gold < (length(members) + 2)) {
            shinyalert::shinyalert("Invalid gold amount!. Gold must be at least equal to number of members selected plus 2.",
                                   type = "warning", 
                                   closeOnEsc = F,
                                   showConfirmButton = T,
                                   html = F
            )
          } else{
            shinyalert::shinyalert("Uploading and updating data. Please wait!.",
                                   type = "info", 
                                   closeOnEsc = F,
                                   showConfirmButton = F,
                                   html = F
            )
            callModule(mod_datatable_server, "datatable_ui_1", gold, members, label)
            callModule(mod_plot_server, "plot_ui_1")
            shinyalert::closeAlert()
          }
        })
      } else {
        callModule(mod_plot.table_server, "plot.table_ui_1", res_auth$user)
      }      
    })
}
