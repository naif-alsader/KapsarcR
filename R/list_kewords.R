#' list keywords
#'

#'
#' @export
#' @rdname list_keywords
#' @return a vector of charechters
#' @examples
#' \dontrun{
#' list_keywords()
#' }
#'
list_keywords <- function() {
  keywords <- list_datasets()$metas$default$keyword
  sort(unique(unlist(keywords)))
}
