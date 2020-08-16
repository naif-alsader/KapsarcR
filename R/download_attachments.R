
#' Download attachment

#'
#' @param attachments the return from  get_attachments()

#'
#' @importFrom attempt stop_if_not
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @importFrom httr content
#' @importFrom httr write_disk
#' @importFrom fs path_split
#' @importFrom fs path_ext
#' @importFrom glue glue
#' @importFrom purrr map_chr
#' @importFrom purrr map2

#' @export
#' @rdname download_attachments
#'
#' @return a tibble
#' @examples
#' \dontrun{
#' datasets <- list_datasets(country = "Saudi Arabia")
#' datasetID <- datasets$dataset_id[1]
#' attachments <- get_attachments(datasetID)
#' download_attachments(attachments)
#' }
#'
download_attachments <- function(attachments) {


  # maybe we need a progress bar here?
  # tests
  attempt::stop_if(attachments$attachments, ~nrow(.x) < 1, msg = "There is no attachments for this dataset")
  #attempt::stop_if(attachments, ~nrow(.x) > 1, msg = "You can only specify on Attachment try,'attachments[1,]' ")


  #attachment_id <- fs::path_split(attachments$href)[[1]][[9]]
  attachment_id <-purrr::map_chr(fs::path_split(attachments[2]$attachments$href),~.x[9])

  #datasetID <- fs::path_split(attachments$href)[[1]][[7]]
  datasetID <-purrr::map_chr(fs::path_split(attachments[2]$attachments$href),~.x[7])[1]

  extension <- fs::path_ext(attachments[2]$attachments$metas$title)

 if (length(attachment_id) == 1) {
  response <- httr::GET(
    method(glue::glue("datasets/{datasetID}/attachments/{attachment_id}")),
    httr::write_disk(glue::glue("{attachment_id}.{extension}"), overwrite = TRUE)
  )
  response
 } else{

   response<- purrr::map2(attachment_id,extension, ~httr::GET(
      method(glue::glue("datasets/{datasetID}/attachments/{..1}")),
      httr::write_disk(glue::glue("{..1}.{..2}"), overwrite = TRUE)
    ))
    response
  }
  # Check the reposns = 200


  # content = httr::content(response,"text")
  # datasets <- jsonlite::fromJSON(content)
  #
  # datasets
}
