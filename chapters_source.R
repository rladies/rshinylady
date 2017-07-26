# Meetup

library(rvest)
library(dplyr)

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

