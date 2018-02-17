library(rvest)
library(dplyr)
library(meetupr)

# meetup groups
api_key <- readRDS("meetup_key.RDS")
all_rladies_groups <- find_groups(text = "r-ladies", api_key = api_key)

# Cleanup
rladies_groups <- all_rladies_groups[grep(pattern = "rladies|r-ladies|rug", 
                                          x = all_rladies_groups$urlname,
                                          ignore.case = TRUE), ]
