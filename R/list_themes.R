#' List themes
#'



#' @export
#' @rdname list_themes
#' @return a vector of charechters
#' @examples
#' \dontrun{
#' list_datasets()
#' }
#'
list_themes <- function() {
  theme <- list_datasets()$metas$default$theme
  sort(unique(unlist(theme)))
}
