#' @title USGS gage contributing areas
#' @description Shapefile of contributing areas associated with USGS gages
#' @format A shapefile and data frame with 316 rows and 3 variables:
#' @name sitesAll.shp
#' @usage raster::shapefile("data/sitesAll.shp")
#' \describe{
#'   \item{\code{site_no}}{character USGS gaging station ID}
#'   \item{\code{Area}}{double Contributing area in square miles}
#'   \item{\code{geometry}}{list Vertices of polygon describing the contributing area}
#'}
#' @source \url{https://water.usgs.gov/lookup/getspatial?gagesII_Sept2011}
#' @examples
#' myBasinFile <- system.file("data", "sitesAll.shp", package = "mapRandomForest")
#'
#' myBasins <- raster::shapefile(myShapeFile)
#' plot(myBasins)
NULL

#' Monthly streamflow and baseflow summaries
#'
#' This dataset contains monthly streamflow and baseflow summaries for a list of USGS gage IDs pulled
#' from a shapefile of gage drainage basins. The dataset contains almost 21,300 missing or negative
#'  flow values, which were removed in subsequent processing in the original scripts.
#'
#' This dataset also includes results for additional gage IDs that were removed in the original scripts
#' before training the random forest trees. The sites removed in subsequent processing were:
#'
#'   "03320500","03383000","03434500","03436100","03438000","03438220",
#'   "03588000","03601990","03602500","03603000","03604400","03605555",
#'   "03436690","03436700","03584000","03584020","03588400","03588500",
#'   "03599450","03600500","03601630","03604000","03433641"
#'
#'   The variables are as follows:
#'
#' \itemize{
#'   \item siteNo. USGS gage ID
#'   \item Date. Year and month associated with summary statistic (YYYY-MM)
#'   \item Flow. Monthly mean streamflow in cubic feet per second
#'   \item baseFlow. Stream baseflow as estimated by the 'part' method of baseflow separation, in cubic feet per second
#'   \item isSubbed. Internal variable used by the original scripts to note whether a value is observed or imputed ('real' or 'fake')
#' }
#'
#' @docType data
#' @keywords datasets
#' @name dvsMonthly.rds
#' @usage readr::read_rds("data/dvsMonthly.rds")
#' @format A CSV file containing 180989 observations of 5 variables
NULL

#' Unedited random forest model inputs
#'
#' This dataset was used as raw input to the random forest model scripts. The dataset combines the output
#' from several scripts, joining data flow and baseflow summaries with precipitation, air temperature,
#' location, elevation, and generalized geologic units.
#'
#' \itemize{
#' \item siteNo. USGS gage ID
#' \item Date. Date of discharge, precipitation, and temperature observation
#' \item Flow. Total daily average discharge, in cubic feet per second
#' \item baseFlow. Estimated daily average baseflow calculated by means of the HYSEP algorithm, cubic feet per second
#' \item precip. Daily average zonal precipitation calculated for the drainage basin associated with the gage, in millimeters
#' \item tmax. Daily average zonal maximum air temperature calculated for the drainage basin associated with the gage, in degrees Celcius
#' \item tmean. Daily average zonal mean air temperature calculated for the drainage basin associated with the gage, in degrees Celcius
#' \item tmin. Daily average zonal minimum air temperature calculated for the drainage basin associated with the gage, in degrees Celcius
#' \item X. Longitude of gaging basin centroid, decimal degrees
#' \item Y. Latitude of gaging basin centroid, decimal degrees
#' \item ET0Har. Reference evapotranspiration calculated by means of the Hargreaves-Samani relation, in millimeters
#' \item preSub1. Value of `precip` from previous month, in millimeters
#' \item preSub2. Value of `precip` from two months prior to current month, in millimeters
#' \item tmaxSub1. Value of `tmax` from previous month, in degrees Celcius
#' \item tmaxSub2. Value of `tmax` from two months prior to current month, in degrees Celcius
#' \item tmeanSub1. Value of `tmean` from previous month, in degrees Celcius
#' \item tmeanSub2. Value of `tmean` from two months prior to current month, in degrees Celcius
#' \item tminSub1. Value of `tmin` from previous month, in degrees Celcius
#' \item tminSub2. Value of `tmin` from two months prior to current month, in degrees Celcius
#' \item ET0Sub1. Value of `ET0Har` from previous month, in millimeters
#' \item ET0Sub2. Value of `ET0Har` from two months prior to current month, in millimeters
#' \item preTot6. Value of `precip` summed over previous 6 months, in millimeters
#' \item MIN. Minimum elevation of the gaging basin, in meters
#' \item MAX. Maximum elevation of the gaging basin, in meters
#' \item RANGE. Range of elevation of the gaging basin, in meters
#' \item MEAN. Mean elevation of the gaging basin, in meters
#' \item STD. Standard deviation of the elevation of the gaging basin, in meters
#' \item H2o. Percentage of gaging basin classified as open water
#' \item Q. Percentage of gaging basin having geology classified as Quaternary
#' \item pgT. Percentage of gaging basin having geology classified as Paleogene
#' \item K. Percentage of gaging basin having geology classified as Cretaceous
#' \item lPz. Percentage of gaging basin having geology classified as Lower Paleozoic
#' \item nT. Percentage of gaging basin having geology classified as Neogene
#' \item Yv. Percentage of gaging basin having geology classified as Middle Proterozoic
#' \item mPz. Percentage of gaging basin having geology classified as Middle Paleozoic
#' \item uPz. Percentage of gaging basin having geology classified as Upper Paleozoic
#' \item Yg. Percentage of gaging basin having geology classified as Middle Proterozoic
#' \item ZPz. Percentage of gaging basin having geology classified as Late Proterozoic
#' \item drain_area_va. Drainage area of the drainage basin associated with the stream gage, in square miles
#' }
#'
#' @docType data
#' @keywords datasets
#' @name testFlowDat.rds
#' @usage readr::read_rds("extdata/testFlowDat.rds")
#' @format A CSV file containing 158526 observations of 39 variables
NULL
