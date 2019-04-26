FROM rocker/tidyverse
LABEL maintainer="Steve Westenbroek <smwesten@usgs.gov>"

# Install other libraries
RUN install2.r --error \
        ggmap \
    && R -e "library(devtools); \
        install.packages('DVstats', repos = ''https://owi.usgs.gov/R\'); \"
