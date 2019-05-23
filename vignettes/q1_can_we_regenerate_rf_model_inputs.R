## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

# ugly hack to get skimr histograms to render properly in knitr
old_locale <- Sys.getlocale("LC_CTYPE")
Sys.setlocale("LC_CTYPE", "Chinese")
library(magrittr)

## ------------------------------------------------------------------------

new_rf_inputs_file <- system.file("data","random_forest_model_stream_temp_ET0_inputs.rds", package = "mapRandomForest")
new_rf_inputs <- readr::read_rds(new_rf_inputs_file) %>%
                   dplyr::mutate(date=yyyymmdd) %>%
                   dplyr::select(site_no:baseflow,
                                 precip:precip_sum_6m,
                                 tmin:lat,
                                 Hargreaves_ET0:ET0_lag_2m,
                                 area)

new_rf_inputs_summary <- new_rf_inputs %>% 
                           skimr::skim_to_wide() %>%
                           dplyr::select(type:n,mean,sd,p0,p50,p100,hist)

knitr::kable(new_rf_inputs_summary)


## ------------------------------------------------------------------------

training_datafile <- system.file("data","testFlowDat.rds", package = "mapRandomForest")
original_rf_inputs <- readr::read_rds(training_datafile) %>%
                        dplyr::select("siteNo":"preTot6","drain_area_va")


## ----removeSites---------------------------------------------------------
removeSites <- c("03320500","03383000","03434500","03436100","03438000","03438220", 
                 "03588000","03601990","03602500","03603000","03604400","03605555", 
                 "03436690","03436700","03584000","03584020","03588400","03588500", 
                 "03599450","03600500","03601630","03604000","03433641")

# remove sites as listed above, eliminate records where flows are negative,
# and remove records that are missing predictor variables
original_rf_inputs <- original_rf_inputs %>% 
                        dplyr::filter(!siteNo %in% removeSites) %>%
                        dplyr::filter(Flow >= 0) %>%
                        dplyr::filter(complete.cases(.)) %>%
                        dplyr::filter(tmean > -40) %>%                   
                        dplyr::filter(tmean < 50) %>%
                        dplyr::filter(tmeanSub1 > -40) %>%
                        dplyr::filter(tmeanSub1 < 50) %>%
                        dplyr::filter(tmeanSub2 > -40) %>%
                        dplyr::filter(tmeanSub2 < 50)


original_rf_inputs_summary <- original_rf_inputs %>% 
                                skimr::skim_to_wide() %>%
                                dplyr::select(type:n,mean,sd,p0,p50,p100,hist)
                                
knitr::kable(original_rf_inputs_summary)

## ------------------------------------------------------------------------

unmatched_df <- dplyr::anti_join(x=original_rf_inputs, y=new_rf_inputs,
                                 by=c("siteNo"="site_no","Date"="date"))
unmatched2_df <- dplyr::anti_join(x=new_rf_inputs, y=original_rf_inputs, 
                                 by=c("site_no"="siteNo","date"="Date"))


