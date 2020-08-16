
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KapsarcR

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

**This library is in early development, if you face any problem please
open an issue**

R Client to access the data portal’s API of King Abdullah Petroleum
Studies and Research Center

The documentations of the API can be found
[here](https://datasource.kapsarc.org/api/v2/console#!/)

## Installation

``` r
devtools::install_github("naif-alsader/KapsarcR")
```

## List Datasets

  - list all datasets

<!-- end list -->

``` r
library(KapsarcR)
library(tidyverse)
#> ── Attaching packages ───────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
#> ✓ tibble  3.0.3     ✓ dplyr   1.0.0
#> ✓ tidyr   1.1.0     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.4.0
#> ── Conflicts ──────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

datasets<-list_datasets()
```

The dataset returned from `list_datasets()` is not tidy. You can use
`clean_dataset()` to get a more tidy dataset

``` r
datasets %>%
  clean_dataset() %>%
  head()
#> # A tibble: 6 x 15
#>   dataset_id country title description themes keywords number_of_obser…
#>   <chr>      <list>  <chr> <chr>       <list> <list>              <int>
#> 1 daily-cha… <NULL>  Dail… "Sources:J… <NULL> <chr [1…              895
#> 2 balance-o… <chr [… Bala… "This data… <chr … <chr [8…             7456
#> 3 growth-ra… <chr [… Grow… "<table><t… <chr … <chr [1…              105
#> 4 the-econo… <chr [… The … "About the… <chr … <chr [4…                0
#> 5 electrici… <chr [… Elec… "This data… <chr … <chr [1…               18
#> 6 weekly-us… <chr [… Week… "This data… <chr … <chr [5…               52
#> # … with 8 more variables: count_of_attchments <int>, date_created <chr>,
#> #   modified <chr>, reference <chr>, temporal <chr>, fields_label <list>,
#> #   fields_type <list>, fields_name <list>
```

and the column names are

    #>  [1] "dataset_id"             "country"                "title"                 
    #>  [4] "description"            "themes"                 "keywords"              
    #>  [7] "number_of_observations" "count_of_attchments"    "date_created"          
    #> [10] "modified"               "reference"              "temporal"              
    #> [13] "fields_label"           "fields_type"            "fields_name"

  - Filter the search

<!-- end list -->

``` r
# by Country
datasets<-list_datasets(country = "Saudi Arabia")

# by Theme
datasets<-list_datasets(theme  = "Water")

# by Keyword
datasets<-list_datasets(keyword  = "Water")
```

  - Filter by two arguments

There are two ways filter two arguments:

1.  if both arguments appear together (use operation = `and`) *the
    default value*

2.  if either argument one or two appears (use operation = `or`)\]

<!-- end list -->

``` r

datasets<-list_datasets(keyword  = "Water", theme = "Water", operation = "or")
```

  - Filter using The Opendatasoft Query Language (ODSQL)

<!-- end list -->

``` r
datasets<-list_datasets(q =  "default.theme = 'Water' or default.theme = 'Transportation'")


datasets<-list_datasets(q =  "default.modified > '2019'")


datasets<-list_datasets(q =  "default.records_count > 1000000")
```

The fields that can be used in the query can be found in the meta column
(its actually 4 datasets in one column) of the dataset
`datasets$metas$default` or `datasets$metas$custom`

here is the complete list:

\_ default.records\_count\_, \_ default.modified\_, \_
default.source\_domain\_address\_, \_ default.references\_, \_
default.keyword\_, \_ default.source\_domain\_title\_, \_
default.geographic\_reference\_, \_ default.timezone\_, \_
default.title\_, \_ default.parent\_domain\_, \_ default.theme\_, \_
default.modified\_updates\_on\_data\_change\_, \_
default.metadata\_processed\_, \_ default.data\_processed\_, \_
default.territory\_, \_ default.description\_, \_
default.modified\_updates\_on\_metadata\_change\_, \_
default.shared\_catalog\_, \_ default.source\_domain\_, \_
default.attributions\_, \_ default.geographic\_reference\_auto\_, \_
default.publisher\_, \_ default.language\_, \_ default.license\_, \_
default.source\_dataset\_, \_ default.metadata\_languages\_, \_
default.oauth\_scope\_, \_ default.federated\_ and \_
default.license\_url\_

\_ custom.predecessor\_, \_ custom.restricted-comment\_, \_
custom.expected-next-release\_, \_ custom.country\_, \_
custom.publisher-periodicity\_, \_ custom.iso-region\_, \_
custom.last-checked-date\_, \_ custom.related-datasets\_, \_
custom.contact\_, \_ custom.data-classification\_, \_
custom.source-copyrights\_, \_ custom.unit-of-measure\_ and \_
custom.discontinued-data\_

\_ dcat.created\_, \_ dcat.issued\_, \_ dcat.temporal\_, \_
dcat.granularity\_, \_ dcat.contributor\_, \_ dcat.publisher\_type\_, \_
dcat.contact\_email\_, \_ dcat.accrualperiodicity\_, \_ dcat.spatial\_,
\_ dcat.dataquality\_, \_ dcat.contact\_name\_ and \_ dcat.creator\_

## Retrieve Datasets

  - One dataset

<!-- end list -->

``` r
df <- get_dataset(datasets$dataset_id[1])
```

  - All datasets that matches the search

<!-- end list -->

``` r
library(purrr)

df_list <- map(datasets$dataset_id, get_dataset)
```

## List attachments

  - One dataset’s attachments

<!-- end list -->

``` r
attachments <- get_attachments(datasets$dataset_id[1])
```

  - All datasets’ attachments that matches the search

<!-- end list -->

``` r
attachments_list <- map(datasets$dataset_id, get_attachments)
```

## Download attachments

  - One dataset attachments

<!-- end list -->

``` r
download_attachments(attachments)
```

  - All datasets’ attachments that matches the search

<!-- end list -->

``` r
map(attachments_list, download_attachments)
```

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
