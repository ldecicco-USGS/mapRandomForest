FROM rocker/geospatial:3.5.3
LABEL maintainer="Steve Westenbroek <smwesten@usgs.gov>"

RUN R -e 'install.packages(c("smwrBase","smwrStats","smwrGraphs","smwrQW",  \
           "DVstats","dataRetrieval"),                                       \
         repos=c(CRAN = "https://cloud.r-project.org",                      \
           USGS="https://owi.usgs.gov/R"))' &&                             \
    R -e 'devtools::install_github("USGS-R/mapRandomForest")'
