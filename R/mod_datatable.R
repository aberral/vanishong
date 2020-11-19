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
  tagList()
}
    
#' datatable Server Function
#'
#' @noRd 
mod_datatable_server <- function(input, output, session, gold, members, label){
  ns <- session$ns
  # browser()
  googledrive::drive_auth(cache = ".secrets")
  googlesheets4::gs4_auth(cache = ".secrets")
  # googlesheets4::gs4_auth_configure(api_key = "AIzaSyDqYnMc_tEKqRJkwdzHfuKPojs7BZZkGQs")
  url <- "https://docs.google.com/spreadsheets/d/1H08X4PUsG-AtTehvmiBCSeE3EmXoPV4kX7h_OckitBk/"
  data <- googlesheets4::range_speedread(url, sheet = "Main")
  colnames(data) <- make.names(colnames(data))
  # data <- column_to_rownames(data, var = "Vars")
  # browser()
  # Input data
  gold <- as.integer(gold)
  members <- members
  label <- label
  # Operations
  shares  <- length(members) + 2
  shares.per.person <- round(gold/shares)
  rest <- gold-(shares.per.person*shares)
  
  earnings <- rep(shares.per.person, shares)
  names(earnings) <- c(members, "Vanishing", "Vanishing")
  earnings[length(earnings)-1] <- earnings[length(earnings)] + earnings[length(earnings)-1]
  earnings <- earnings[1:(length(earnings)-1)]
  earnings[names(earnings) %in% 'Vanishing'] <- earnings[names(earnings) %in% 'Vanishing'] + rest
  index <- match(names(earnings), colnames(data))
  

  
  new.run <- c(rep("0", (ncol(data))))
  names(new.run) <- names(data)
  new.run[1] <- format(Sys.time(), "%d-%m-%y_%H-%M-%S")
  new.run[2] <- label
  new.run[index] <- earnings
  
  new.run <- as_tibble(t(new.run)) %>% 
    type_convert()  
  
  datos <- data
  datos <- bind_rows(datos, new.run)
  # browser()
  sum <- apply(datos[-1,c(-1,-2)], 2, sum)
  datos[1,c(-1,-2)] <- t(sum)
  
  # data <- datos
  # googlesheets4::gs4_create("VLBoost2", sheet = "Main")
  # write_sheet(data, url, sheet = "Main")
  googlesheets4::write_sheet(data, url, sheet = "BU")
  googlesheets4::write_sheet(datos, url, sheet = "Main")
  
}
    
## To be copied in the UI
# mod_datatable_ui("datatable_ui_1")
    
## To be copied in the server
# callModule(mod_datatable_server, "datatable_ui_1")
 
