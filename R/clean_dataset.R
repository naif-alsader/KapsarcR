#' clean_dataset
#'
#' @description this function will clean the messy dataset from list_datasets.
#' @param datasets a tibble object returned from list_datasets()
#'
#' @importFrom stringr str_sub
#' @importFrom purrr map_chr
#' @importFrom purrr pluck
#' @importFrom purrr map
#' @importFrom tibble tibble
#' @export
#' @rdname clean_dataset
#'
#' @return a tibble
#' @examples
#' \dontrun{
#' datasets <- list_datasets(country = "Saudi Arabia")
#' clean_dataset(datasets)
#' }
#'

clean_dataset <- function(datasets) {
  tibble(dataset_id = datasets$dataset_id,
         country = datasets$metas$custom$country,
         title = datasets$metas$default$title,
         description = map_chr(datasets$metas$default$description, clean_html),
         themes = datasets$metas$default$theme,
         keywords = datasets$metas$default$keyword,
         number_of_observations = datasets$metas$default$records_count,
         count_of_attchments = datasets$attachments_count,
         date_created = datasets$metas$dcat$created,
         modified = stringr::str_sub(datasets$metas$default$modified, start = 1, end = 7),
         reference = datasets$metas$default$references,
         temporal = datasets$metas$dcat$temporal,
         fields_label = map(datasets$fields, pluck,2),
         fields_type = map(datasets$fields, pluck,3),
         fields_name = map(datasets$fields, pluck,4)
  )

}


