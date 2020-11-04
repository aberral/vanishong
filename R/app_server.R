#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
    res_auth <- shinymanager::secure_server(
        check_credentials = shinymanager::check_credentials(
            data.frame(
                user = c("nysa", "admin", "pleb"), # mandatory
                password = c("nysa", "cucharilla", "deptus"), # mandatory
                admin = c(TRUE, FALSE, FALSE),
                stringsAsFactors = FALSE
            )
        )
    )
    output$auth_output <- renderPrint({
        reactiveValuesToList(res_auth)
    })
    
    output$ui <- renderUI({
        if(res_auth$user == 'nysa' | res_auth$user == 'admin') {
            return(
                tagList(
                    # Sidebar Layout
                    sidebarLayout(
                        # Sidebar panel for inputs
                        sidebarPanel(
                            # Input: Select the roster
                            tags$div(align = 'left', 
                                     class = 'multicol',
                                     style = 'column-count:3',
                                     checkboxGroupInput(inputId = "checkGroup",
                                                        inline = T,
                                                        label = "Select the boost members", 
                                                        choices = c('Aales','Aegui',
                                                                    'Ainhae','Akroggy',
                                                                    'Aristocrat','Ark',
                                                                    'Byakura','Cordu',
                                                                    'Cripy','Dalaris',
                                                                    'Dardragon','Deathroll',
                                                                    'Derser','Destiny',
                                                                    'Dethwatcher','Distur',
                                                                    'Epar','Erish',
                                                                    'Gaude','Griindhouse',
                                                                    'Gulraz','Jose Trix',
                                                                    'Kala','Kaz',
                                                                    'Leiro','Lixie',
                                                                    'Lowy','Lyon90',
                                                                    'Mandarinas','Mugatsu',
                                                                    'Must','Niebli',
                                                                    'Nooj','Nuks',
                                                                    'Nysadra','Osura',
                                                                    'Phsyquic','Riddya',
                                                                    'Ryxh','Sazed',
                                                                    'Scizor','Shamesh',
                                                                    'Shareya','Shiphidos',
                                                                    'Sigi','Strought',
                                                                    'Supare','Swarley',
                                                                    'Tanatos','Tirillas',
                                                                    'Trancaman','Trolemaga',
                                                                    'Ursox','Virulenta',
                                                                    'Voodoomed','Wonder'),
                                                        selected = "")),
                            # textAreaInput(inputId = "roster", 
                            #               label   = "Paste the roster split by ',':",
                            #               value   = "Osura,Nysadra,Boiga"),
                            # Input: Paste the amount of gold
                            numericInput(inputId = "gold", 
                                         label   = "Paste the gold amount:",
                                         value   = ""),
                            # Include clarifying text ----
                            helpText("Note: please only upload the data once.",
                                     "Duplicated data may cause errors."),
                            # Action Button to add the DATA
                            actionButton("update", "Update Data")
                        ),
                        mainPanel(
                            # Output: Header + table of distribution ----
                            mod_plot_ui("plot_ui_1"),
                            mod_datatable_ui("datatable_ui_1"),
                            # actionButton("browser", "browser"),
                            # tags$script("$('#browser').hide();")
                        )
                    )
                )
            )
        } else if(res_auth$user == 'pleb') {
            return(
                tagList(
                    mainPanel(
                        # Output: Header + table of distribution ----
                        mod_plot_ui("plot_ui_1"),
                        actionButton("browser", "browser"),
                        tags$script("$('#browser').hide();")
                    )
                )
            )
        }
    })
  # List the first level callModules here
    # Update data with selection
    # Save changes
    callModule(mod_plot_server, "plot_ui_1")
    # Module to save changes
    observeEvent(input$update,{
        req(input$gold)
        req(input$checkGroup)
        gold    <- input$gold
        members <- input$checkGroup
        callModule(mod_datatable_server, "datatable_ui_1", gold, members)
        callModule(mod_plot_server, "plot_ui_1")
    })
    # Browser to check things
    # observeEvent(input$browser,{
    #     browser()
    # })
    # callModule(mod_Home_server, "Home_ui_1")
    # callModule(mod_admin_server, "admin_ui_1")
    # callModule(mod_user_server, "user_ui_1")
}
