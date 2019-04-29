FROM rocker/tidyverse
LABEL maintainer="Steve Westenbroek <smwesten@usgs.gov>"

RUN echo "options(repos = c(CRAN = 'https://cloud.r-project.org', USGS='https://owi.usgs.gov/R'))"  \
    >> /usr/local/lib/R/etc/Rprofile.site

RUN install2.r --error \
  smwrBase             \
  smwrStats            \
  smwrGraphs           \
  smwrQW               \
  DVstats              \
  dataRetrieval

  RUN R -e 'devtools::install_github("USGS-R/mapRandomForest")'
