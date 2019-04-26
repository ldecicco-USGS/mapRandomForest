# This script based on a post found here:
# https://www.joelnitta.com/post/docker-and-packrat/
# with a GitHub repo here:
# https://github.com/joelnitta/docker-packrat-example

# Install packages to a docker image with packrat

### Specify repositories ###
CRAN <- "https://cloud.r-project.org"
USGS <- "https://owi.usgs.gov/R"

# Install packrat
install.packages("packrat", repos = CRAN)


# Initialize packrat, but don't let it try to find packages to install itself.
packrat::init(
  infer.dependencies = FALSE,
  enter = TRUE,
  restart = FALSE)

# Install packages that install packages.
install.packages("BiocManager", repos = CRAN)
install.packages("remotes", repos = CRAN)

# Specify repositories so they get included in
# packrat.lock file.
my_repos <- BiocManager::repositories()
my_repos["CRAN"] <- CRAN
my_repos["USGS"] <- USGS
options(repos = my_repos)

### Install packages ###

# All packages will be installed to
# the project-specific packrat library.

# Here we are just installing one package per repository
# as an example. If you want to install others, just add
# them to the vectors.

# Install CRAN packages
cran_packages <- c("caret","dplyr","readr","ggplot2","magrittr","sf","lubridate","velox")
install.packages(cran_packages)

# Install USGS packages from GRAN
usgs_packages <- c("DVstats","dataRetrieval","smwrBase","smwrGraphs","smwrStats")
install.packages(usgs_packages)

# Install bioconductor packages
#bioc_packages <- c("BiocVersion")
#BiocManager::install(bioc_packages)

# Install github packages
#github_packages <- c("joelnitta/minimal")
#remotes::install_github(github_packages)

### Take snapshot ###

packrat::snapshot(
  snapshot.sources = FALSE,
  ignore.stale = TRUE,
  infer.dependencies = FALSE)
