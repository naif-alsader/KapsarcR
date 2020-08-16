## code to prepare `DATASET` dataset goes here

library(devtools)
library(usethis)
library(desc)

# Remove default DESC
unlink("DESCRIPTION")
# Create and clean desc
my_desc <- description$new("!new")

# Set your package name
my_desc$set("Package", "KapsarcR")

# Set your name
my_desc$set("Authors@R", "person('Naif', 'Alsader', email = 'naif.alsader@gmail.com', role = c('cre', 'aut'))")

# Remove some author fields
my_desc$del("Maintainer")

# Set the version
my_desc$set_version("0.0.0.9000")

# The title of your package
my_desc$set(Title = "An API Wrapper for the King Abdullah Petroleum Studies and Research Center (KAPSARC)")
# The description of your package
my_desc$set(Description = "TODO")
# The urls
my_desc$set("URL", "TODO")
my_desc$set("BugReports", "TODO")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
use_mit_license(name = "Naif Alsader")
use_code_of_conduct()
use_lifecycle_badge("Experimental")
use_news_md()

# Add Readme
use_readme_rmd()

# Get the dependencies
use_package("httr")
use_package("jsonlite")
use_package("curl")
use_package("attempt")
use_package("tibble")
use_package("glue")
use_package("fs")
use_package("purrr")
use_package("stringr")
use_package("rvest")
use_package("xml2")


# Clean your description
use_tidy_description()
