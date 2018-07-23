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

# Each country/continent
groups_usa <- rladies_groups %>% 
  filter(country == "US")
created_usa <- groups_usa %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")

# Canada
canada <- sort(unique(rladies_groups[grep("Canada", rladies_groups$timezone),]$country))
groups_canada <- rladies_groups %>% 
  filter(country %in% canada)
created_canada <- groups_canada %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")


# Latin America (AR, BR, CL, CO, "CR" "EC" "MX" "PE" "UY" )  
latam <- sort(unique(rladies_groups[grep("America", rladies_groups$timezone),]$country))
groups_latam <- rladies_groups %>% 
  filter(country %in% latam)
created_latam <- groups_latam %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")

# Europe
europe <- sort(unique(rladies_groups[grep("Europe", rladies_groups$timezone),]$country))
groups_europe <- rladies_groups %>% 
  filter(country %in% europe)
# Add Tbilisi to the Europe group
# for some reason Tbilisi uses the timezone `Asia/Tbilisi` therefore
# it got categorized as Asia. However, Tbilisi is located in Europe
groups_europe <- rbind(groups_europe,
                       rladies_groups %>% filter(city == "Tbilisi"))
created_europe <- groups_europe %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")

# Africa
africa <- sort(unique(rladies_groups[grep("Africa", rladies_groups$timezone),]$country))
groups_africa <- rladies_groups %>% 
  filter(country %in% africa)
created_africa <- groups_africa %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")

# Asia
asia <- sort(unique(rladies_groups[grep("Asia", rladies_groups$timezone),]$country))
groups_asia <- rladies_groups %>% 
  filter(country %in% asia) %>% 
  filter(city != "Tbilisi") # Remove Tbilisi from the Asia group
created_asia <- groups_asia %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")

# Australia
australia <- sort(unique(rladies_groups[grep("Australia", rladies_groups$timezone),]$country))
groups_australia <- rladies_groups %>% 
  filter(country %in% australia)
created_australia <- groups_australia %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")
