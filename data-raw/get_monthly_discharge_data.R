# read in shapefile; sites are identified by the attribute 'site_no'
shapefile_name <- system.file("data","sitesAll.shp", package = "mapRandomForest")
sites_sf       <- sf::read_sf(shapefile_name)

site_list <- unique(sites_sf$site_no)


max_clusters <- 8

# Pull USGS gage data for the entire list of sites, summarizing by month
site_numbers <- unique(sites_sp$site_no)

# set up `max_clusters` workers
cl <- parallel::makeCluster(max_clusters)

# must register parallel backend with the 'foreach' package
doParallel::registerDoParallel(cl)


# the foreach function must be supplied with the names of package dependencies to be supplied to
# each of the parallel image environments in which `getFlowDataForSite` is evaluated; evaluation
# of this function is carried out in parallel for each unique site number
monthly_discharge <- foreach::foreach(b=site_numbers,
                                      .combine=rbind,
                                      .packages=c("magrittr","dplyr","dataRetrieval","stringr",
                                                  "data.table","lubridate","DVstats","mapRandomForest"),
                                      .errorhandling='remove') %dopar% {

                                        print(b)
                                        data_list <- mapRandomForest::getFlowDataForSite(b, insideUSGSfirewall=TRUE)
                                        data.table(site_no=rep(b,nrow(data_list$df)),
                                                   date=data_list$df$date,
                                                   discharge=data_list$df$discharge,
                                                   baseflow=data_list$df$baseflow,
                                                   count_non_na=data_list$df$count_non_na,
                                                   is_regulated=data_list$df$is_regulated,
                                                   dec_lat=rep(data_list$siteinfo$dec_lat_va,nrow(data_list$df)),
                                                   dec_lon=rep(data_list$siteinfo$dec_long_va,nrow(data_list$df)),
                                                   area=rep(data_list$siteinfo$drain_area_va,nrow(data_list$df))hist)

                                        # output from the run for each unique site number is concatenated (rbind), with the
                                        # final concatenated data table placed in `monthly_discharge`

                                      }

# eliminate weird negative discharge values and summaries based on less than 25 daily values per month
monthly_discharge <- monthly_discharge %>%
  dplyr::filter(count_non_na > 24) %>%
  dplyr::filter(discharge >= 0)

# write results to a 'rds' file
readr::write_rds(monthly_discharge, "data/monthly_discharge.rds", compression="gz")

parallel::stopCluster(cl)
