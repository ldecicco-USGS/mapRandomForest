#' Calculate monthly mean raster values for a set of polygons
#'
#' @param shp An sp object created from a polygon shapefile
#' @param rasterDir Fully qualified directory name containing PRISM *.bil files for processing
#' @param dateSeq A list of POSIX date objects defining the YYYY-MM
#'
#' @return data.frame
#' @export
#'
processPRISMRasters <- function(shp, rasterDir, dateSeq) {

  mytable <- shp@data

  for ( n in 1:length(dateSeq) ) {

    rasterFilename <- list.files(paste(rasterDir,"/",sep=""),full.names=TRUE,
                                 pattern=glob2rx(paste("*",year(dateSeq[n]),format(dateSeq[n],"%m"),"*.bil",sep="")))

    print( paste("Reading", rasterFilename) )
    myRaster <- raster::raster(rasterFilename)
    vals <- getRasterMean(myRaster, shp)
    mytable <- cbind(mytable, vals)

  }

  return(mytable)

}
