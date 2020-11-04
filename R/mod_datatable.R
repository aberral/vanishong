#' datatable UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_datatable_ui <- function(id){
  ns <- NS(id)
  tagList(
  )
}
    
#' datatable Server Function
#'
#' @noRd 
mod_datatable_server <- function(input, output, session, gold, members){
  ns <- session$ns
  load("data/data.rda")
  colnames(data) <- make.names(colnames(data))
  # browser()
  # Input data
  gold <- as.integer(gold)
  members <- members
  # Operations
  shares  <- length(members) + 2
  shares.per.person <- round(gold/shares)
  rest <- gold-(shares.per.person*shares)
  
  earnings <- rep(shares.per.person, shares)
  names(earnings) <- c(members, "Vanishing", "Vanishing")
  
  index <- match(names(earnings), data$Raider)
  date <- format(Sys.time(), "%d-%m-%y_%H-%M-%S")
  datos <- data
  
  datos <- cbind(datos, date = 0)
  datos$date[index] <- earnings
  datos$date[datos$Raider %in% "Vanishing"] <- datos$date[datos$Raider %in% "Vanishing"]*2 + rest
  colnames(datos)[length(colnames(datos))] <- date
  
  datos$Gold.Earned <- apply(datos[,-1], 1, sum)
  
  data <- datos
  save(data, file = "data/data.rda")
  
}
    
## To be copied in the UI
# mod_datatable_ui("datatable_ui_1")
    
## To be copied in the server
# callModule(mod_datatable_server, "datatable_ui_1")
 
