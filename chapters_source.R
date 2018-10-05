library(rvest)
library(tidyverse)
library(meetupr)

# meetup groups
# `api_key <- readRDS("meetup_key.RDS")` this code doesn't work if you follow the readme instructions to set up your API key
api_key <- Sys.getenv("MEETUP_KEY")
all_rladies_groups <- find_groups(text = "r-ladies", api_key = api_key)

# Cleanup
rladies_groups <- all_rladies_groups[grep(pattern = "rladies|r-ladies", 
                                          x = all_rladies_groups$name,
                                          ignore.case = TRUE), ]

# Add extra columns to set up popup content in the app
rladies_groups$fullurl <- paste0("https://www.meetup.com/", rladies_groups$urlname, "/")
rladies_groups$url <- paste0("<a href='", rladies_groups$fullurl, "'>", rladies_groups$name, "</a>")

# Each country/continent
# We need to exclude remote 
# The R-Ladies chapter is Remote, ie, they don't have a specific location since
# everything the group does is online. 
# But when you create a group on meetup.com, you can't leave the location blank, 
# you need to specify a city. 
# Therefore, for the Remote chapter, we used San Francisco as their location even 
# though there are not "located" in San Francisco.
groups_usa <- rladies_groups %>% 
  filter(country == "US", name != "R-Ladies Remote")
created_usa <- groups_usa %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")

# For subsetting, the follwing countries, I'm using the time zone as a proxy
# of where the chapter is located
# unique(rladies_groups$timezone)
# unique(sub(pattern = "\\/.*", "", unique(rladies_groups$timezone)))
# [1] "Europe"    "America"   "Australia" "Africa"    
#  "Canada"    "Asia"      "US"        "Pacific" 
# Please note that Auckland has TZ "Pacific/Auckland"


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

#  Australia/Oceania
australia <- sort(unique(rladies_groups[grep("Australia|Pacific/Auckland", rladies_groups$timezone),]$country))
groups_australia <- rladies_groups %>% 
  filter(country %in% australia)
created_australia <- groups_australia %>% 
  mutate(dt_created = substr(created, 1, 10)) %>% 
  arrange(desc(dt_created)) %>% 
  select("city", "state", "country", "dt_created", "members")
