#' List all Datasets
#'
#' @param q text search over all the meta
#' @param country Country name to filter datasets on
#' @param theme theme name to filter datasets on [look list_themes()]
#' @param keyword keword name to filter datasets on [look list_keywords()]
#' @param operation query operation [and , or(the Default value)]

#'
#' @importFrom attempt stop_if_none
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @importFrom httr content
#' @importFrom stats na.omit
#' @importFrom tibble tibble
#' @export
#' @rdname list_datasets
#'
#' @return a tibble
#' @examples
#' \dontrun{
#' list_datasets(country = "Saudi Arabia")
#' list_datasets(q = "custom.country = 'Saudi Arabia'")
#' list_datasets(theme = "water", keyword = "Water", operation = "or")
#' }
#'
list_datasets <- function(q = NULL,
                          country = NULL,
                          theme = NULL,
                          keyword = NULL,
                          operation = "and") {
  args <- as.list(match.call())[-1]

  # attempt::stop_if_none(args,is.character, glue::glue('queries should be all characters, try "{args}" '))

  args_names <- names(args)



  query <- c(ifelse(args_names == "q", args$q,
    ifelse(args_names == "keyword", paste0("default.keyword = '", args$keyword, "'"),
      ifelse(args_names == "country", paste0("custom.country = '", args$country, "'"),
        ifelse(args_names == "theme", paste0("default.theme = '", args$theme, "'"), NA)
      )
    )
  ))



  query <- paste(na.omit(query), collapse = paste(" ", operation, " "))
  query <- list(where = query)

  response <- httr::GET(method("exports/json"), query = query)

  if (httr::status_code(response) >= 400 && httr::status_code(response) <= 499) {
    response
  } else if (httr::status_code(response) >= 500 && httr::status_code(response) <= 599) {
    response
  }

  content <- httr::content(response, "text")
  #datasets <- jsonlite::fromJSON(content)
  datasets <- attempt::attempt(jsonlite::fromJSON(content), msg = glue::glue("Try '{query[1]}', intead of {query[1]}"))



  return(tibble::tibble(datasets))
}
