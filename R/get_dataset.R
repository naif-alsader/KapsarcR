#' Get Datasets Records
#'
#' @param datasetID a Dataset ID. Can be found in the first coulmn of list_datasets() under the name of dataset_id


#'
#' @importFrom attempt stop_if_not
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @importFrom httr content
#' @importFrom glue glue
#' @importFrom tibble as_tibble
#' @export
#' @rdname get_dataset
#'
#' @return a tibble
#' @examples
#' \dontrun{
#' get_dataset(datasetID)
#' }
#'
get_dataset <- function(datasetID) {


  # maybe we need a progress bar here?
  # tests

  # Check if datasetID is character
  stop_if_not(datasetID, is.character, msg = "datasetID should be a character")

  # Check if datasetID`s lenght is 1
  stop_if_not(datasetID, ~ length(.x) == 1, msg = "You should input one datasetID")


  response <- httr::GET(method(glue::glue("datasets/{datasetID}/exports/json")))


  # Check the reposnse status
  if (httr::status_code(response) >= 400 && httr::status_code(response) <= 499) {
    response
  } else if (httr::status_code(response) >= 500 && httr::status_code(response) <= 599) {
    response
  }


  content <- httr::content(response, "text")
  datasets <- jsonlite::fromJSON(content)

  tibble::as_tibble(datasets)
}
