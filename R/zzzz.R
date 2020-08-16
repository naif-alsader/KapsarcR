#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
#' @importFrom stringr str_detect
#' @importFrom rvest html_text
#' @importFrom xml2 read_html
check_internet <- function() {
  stop_if_not(.x = has_internet(), msg = "Please check your internet connexion")
}

#' @importFrom httr status_code
check_status <- function(res) {
  stop_if_not(
    .x = status_code(res),
    .p = ~ .x == 200,
    msg = "The API returned an error"
  )
}


baseurl <- "https://datasource.kapsarc.org/api/v2/catalog"

method <- function(method) {
  paste0(baseurl, "/", method)
}


clean_html  <- function(x) {
  # test weathere there is an html tags

  ifelse(str_detect(x, "(</.>)"), rvest::html_text(xml2::read_html(x)),x)

}
