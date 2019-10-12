source("chapters_source.R")
source("region_page.R")
library(shinydashboard)
library(shiny)
library(leaflet)
library(htmltools)
library(DT)

## ui.R ##

## UI CONFIG

## Header
header <- dashboardHeader(title = "R-Ladies")

# Sidebar content
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "R-Ladies", tabName = "R-Ladies", icon = icon("dashboard")),
    menuItem(text = "By Region", tabName = "region", icon = icon("dashboard")),
    menuItem(text = "About", tabName = "about", icon = icon("heart"))
  )
)

## Body content
body <-   
  dashboardBody(
    tabItems(
      
      # Front Page
      
      # First sidebar tab - R-Ladies
      tabItem(tabName = "R-Ladies",
              selected = TRUE, 
        
        fluidRow(
          absolutePanel(style = "z-index: 2000", fixed = TRUE, draggable = TRUE,
                        top = 10, left = "auto", right = 20, width = "250px",
                        div(
                          tags$a(target="_blank", 
                                 href = "http://www.rladies.org", 
                                 tags$img(src="R-LadiesGlobal_RBG_online_LogoWithText.png", 
                                          height = "30px", id = "logo") 
                          )
                        )
          ),
          # A static valueBox
          valueBox(dim(rladies_groups)[1], "R-Ladies groups on meetup.com", 
                   icon("meetup", lib = "font-awesome"), width = 3),
          valueBox(length(unique(rladies_groups$country)), "R-Ladies Countries", 
                   icon = icon("map-o"), width = 3),
          valueBox(length(rladies_groups$city), "R-Ladies Cities", 
                   icon = icon("map-marker"), color = "purple", width = 3),
          valueBox(sum(rladies_groups$members), "R-Ladies members on meetup.com", 
                   icon = icon("users"), width = 3)
        ),
        leafletOutput('worldmap', height = 700)
      ),
      
      # Second sidebar tab - Region
      tabItem(tabName = "region",
              navbarPage(title = 'R-Ladies',
                         region_page_UI("USA", "USA", "R-Ladies groups in the US"),
                         region_page_UI("Canada", "Canada", "R-Ladies groups in Canada"),
                         region_page_UI("LatAm", "Latin America", "R-Ladies groups in Latin America"),
                         region_page_UI("Europe", "Europe", "R-Ladies groups in Europe"),
                         region_page_UI("Africa", "Africa", "R-Ladies groups in Africa"),
                         region_page_UI("Asia", "Asia", "R-Ladies groups in Asia"),
                         region_page_UI("AusOc", "Australia/Oceania", "R-Ladies groups in Australia")
              )
      ),
      tabItem(tabName = "about",
               
              
              fluidPage(
                h1(strong("About:")),
                p("This app was developed by ",
                  a("R-Ladies.", href = "http://www.rladies.org"), 
                  "You can find the source code",
                  a("here.", href = "https://github.com/rladies/rshinylady")),
                  
                img(src = "R-LadiesGlobal_RBG_online_LogoWithText.png", height = 300, width = 300)
                
              )
      )))




ui <- dashboardPage(skin = "purple", header, sidebar, body)

icons <- awesomeIcons(icon = "whatever",
                      iconColor = "black",
                      library = "ion",
                      markerColor = "purple")


# Set up popup content for global and regional maps
global_popups <- paste0("<b>", rladies_groups$url, "</b>", "<br/>",
                       "Created: ", as.Date(rladies_groups$created), "<br/>",
                       "Members: ", rladies_groups$members
)
usa_popups <- paste0("<b>", groups_usa$url, "</b>", "<br/>",
                               "Created: ", as.Date(groups_usa$created), "<br/>",
                               "Members: ", groups_usa$members
)
canada_popups <- paste0("<b>", groups_canada$url, "</b>", "<br/>",
                     "Created: ", as.Date(groups_canada$created), "<br/>",
                     "Members: ", groups_canada$members
)
latam_popups <- paste0("<b>", groups_latam$url, "</b>", "<br/>",
                     "Created: ", as.Date(groups_latam$created), "<br/>",
                     "Members: ", groups_latam$members
)
europe_popups <- paste0("<b>", groups_europe$url, "</b>", "<br/>",
                     "Created: ", as.Date(groups_europe$created), "<br/>",
                     "Members: ", groups_europe$members
)
africa_popups <- paste0("<b>", groups_africa$url, "</b>", "<br/>",
                     "Created: ", as.Date(groups_africa$created), "<br/>",
                     "Members: ", groups_africa$members
)
asia_popups <- paste0("<b>", groups_asia$url, "</b>", "<br/>",
                     "Created: ", as.Date(groups_asia$created), "<br/>",
                     "Members: ", groups_asia$members
)
australia_popups <- paste0("<b>", groups_australia$url, "</b>", "<br/>",
                      "Created: ", as.Date(groups_australia$created), "<br/>",
                      "Members: ", groups_australia$members
)


# # Set up popup content

# rladies_groups$fullurl <- paste0("https://www.meetup.com/", rladies_groups$urlname, "/")
# rladies_groups$url <- paste0("<a href='", rladies_groups$fullurl, "'>", rladies_groups$name, "</a>")

# popup_content <- paste0("<b>", rladies_groups$url, "</b>", "<br/>",
#                        "Created: ", as.Date(rladies_groups$created), "<br/>",
#                        "Members: ", rladies_groups$members
# )


server <- function(input, output, session) { 
  
  output$worldmap <- renderLeaflet({
    leaflet(data = rladies_groups) %>% 
      addTiles() %>%
      addAwesomeMarkers(~lon, ~lat, popup = global_popups, icon = icons)
  })
  
  callModule(region_page, "USA", created_usa, groups_usa, usa_popups)
  callModule(region_page, "Canada", created_canada, groups_canada, canada_popups)
  callModule(region_page, "LatAm", created_latam, groups_latam, latam_popups)
  callModule(region_page, "Europe", created_europe, groups_europe, europe_popups)
  callModule(region_page, "Africa", created_africa, groups_africa, africa_popups)
  callModule(region_page, "Asia", created_asia, groups_asia, asia_popups)
  callModule(region_page, "AusOc", created_australia, groups_australia, australia_popups)
  
}


shinyApp(ui, server)








