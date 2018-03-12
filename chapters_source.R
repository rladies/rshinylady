library(rvest)
library(tidyverse)
library(meetupr)

# meetup groups
api_key <- readRDS("meetup_key.RDS")
all_rladies_groups <- find_groups(text = "r-ladies", api_key = api_key)

# Cleanup
rladies_groups <- all_rladies_groups[grep(pattern = "rladies|r-ladies|rug", 
                                          x = all_rladies_groups$urlname,
                                          ignore.case = TRUE), ]

# Each country
groups_usa <- rladies_groups %>% 
  filter(country == "US")
created_usa <- groups_usa %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "dt_created", "members")
  
  
