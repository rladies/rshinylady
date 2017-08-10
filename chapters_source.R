# Meetup
# devtools::install_github("rladies/meetupr")
library(rvest)
library(dplyr)
library(meetupr)

# read the page where the list of chapters is located
page <- read_html("https://github.com/rladies/starter-kit/blob/master/Current-Chapters.md")


## Get the cities of the chapters
cities <- page %>%
  html_nodes("#readme strong") %>% 
  html_text() %>% 
  tbl_df()

cities_plus_dc <- page %>%
  html_nodes("h3:nth-child(150) , #readme strong") %>% 
  html_text() 
n_cities <- length(cities_plus_dc)

# get the countries of the chapters ----------------------------
countries <- page %>% 
  html_nodes("ul+ h2 , p+ h2") %>% 
  html_text()
n_countries <- length(countries)


# meetup numbers
# api_key <- readRDS("../../../meetup_api_key.RDS")
# doc.raw <- RCurl::getURL("https://raw.githubusercontent.com/rladies/starter-kit/master/Current-Chapters.md")
# meetups <- stringr::str_match_all(doc.raw, "www.meetup.com/(.*?)/")[[1]][,2]
# meetups <- unique(meetups)
# 
# n_members <- sapply(meetups, function(x) meetupr::get_members(x, api_key = api_key))




