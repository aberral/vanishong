## code to prepare `data` dataset goes here

data <- data.table::fread("inst/app/www/data.csv")
data <- column_to_rownames(data, var = "Vars")
usethis::use_data(data, overwrite = TRUE)
