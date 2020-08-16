#' Get list of all available attachments

#' @param datasetID a Dataset ID. Can be found in the first coulmn of list_datasets() under the name of dataset_id


#'
#' @importFrom attempt stop_if_not
#' @importFrom attempt attempt
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @importFrom httr content
#' @importFrom glue glue
#' @export
#' @rdname get_attachments
#'
#' @return a list
#' @examples
#' \dontrun{
#' datasets<-list_datasets(country = "Saudi Arabia")
#' datasetID<-datasets$dataset_id[1]
#' get_attachments(datasetID)
#' }
#'
get_attachments <- function(datasetID) {



  # Check if datasetID is character
  attempt::stop_if_not(datasetID, is.character, msg = "datasetID should be a character")

  # Check if datasetID`s lenght is 1
  attempt::stop_if_not(datasetID, ~ length(.x) == 1, msg = "You should input one datasetID")


  response <- httr::GET(method(glue::glue("datasets/{datasetID}/attachments")))

  # Check the reposns = 200
  if (httr::status_code(response) >= 400 && httr::status_code(response) <= 499) {
    response
  } else if (httr::status_code(response) >= 500 && httr::status_code(response) <= 599) {
    response
  }


  content <- httr::content(response, "text")
  datasets <- attempt::attempt(jsonlite::fromJSON(content), msg = glue::glue("Try '{query[1]}', intead of {query[1]}"))

  datasets
}

