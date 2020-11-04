## code to prepare `data` dataset goes here

data <- data.table::fread("inst/app/www/data.csv")
usethis::use_data(data, overwrite = TRUE)
