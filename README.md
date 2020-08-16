
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KapsarcR

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

R clint to access the data portal’s API of King Abdullah Petroleum
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
#> ── Attaching packages ──────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
#> ✓ tibble  3.0.3     ✓ dplyr   1.0.0
#> ✓ tidyr   1.1.0     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.4.0
#> ── Conflicts ─────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

datasets<-list_datasets()
```

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

There are two ways filter two arguments: 1. if both arguments appear
together (use operation = `and`) *the default value* 2. if either
arguments one or two appears (use operation = `or`)\]

``` r

datasets<-list_datasets(keyword  = "Water", theme = "Water", operation = "or")
```

  - filter using The Opendatasoft Query Language (ODSQL)

<!-- end list -->

``` r
datasets<-list_datasets(q =  "default.theme = 'Water' or default.theme = 'Transportation'")


datasets<-list_datasets(q =  "default.modified > '2019'")


datasets<-list_datasets(q =  "default.records_count > 1000000")
```

The fileds that can be used in the query can be found in the meta column
(its actually 4 datasets in one column) of the dataset
`datasets$metas$default` or `datasets$metas$custom`

here is the complete list:

*default.records\_count*, *default.modified*,
*default.source\_domain\_address*, *default.references*,
*default.keyword*, *default.source\_domain\_title*,
*default.geographic\_reference*, *default.timezone*, *default.title*,
*default.parent\_domain*, *default.theme*,
*default.modified\_updates\_on\_data\_change*,
*default.metadata\_processed*, *default.data\_processed*,
*default.territory*, *default.description*,
*default.modified\_updates\_on\_metadata\_change*,
*default.shared\_catalog*, *default.source\_domain*,
*default.attributions*, *default.geographic\_reference\_auto*,
*default.publisher*, *default.language*, *default.license*,
*default.source\_dataset*, *default.metadata\_languages*,
*default.oauth\_scope*, *default.federated* and *default.license\_url*

*custom.predecessor*, *custom.restricted-comment*,
*custom.expected-next-release*, *custom.country*,
*custom.publisher-periodicity*, *custom.iso-region*,
*custom.last-checked-date*, *custom.related-datasets*, *custom.contact*,
*custom.data-classification*, *custom.source-copyrights*,
*custom.unit-of-measure* and *custom.discontinued-data*

## Retrive Datasets

``` r
df <- get_dataset(datasets$dataset_id[1])
```

## List attachments

``` r
attachments <- get_attachments(datasets$dataset_id[1])
```

## Download attachments

``` r
download_attachments(attachments)
```

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
