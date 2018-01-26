library(shiny)
library(shinydashboard)
library(data.table)
library(plotly)

shinyUI(dashboardPage(
  dashboardHeader(title = 'Kickstarter Project'),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map", tabName = "maps", icon = icon("map")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem('Bubble', tabName = 'giggity', icon = icon("cog", lib = "glyphicon")),
      menuItem('Time', tabName = 'clocks', icon = icon("cog", lib = 'glyphicon')),
      
    selectInput('differences',
                label = "Choose a category to display",
                choices = unique(ks$main_category), #SORT IN ALPHABETICAL ORDER
                selected = "Art"),
    selectizeInput('changes',
                label = "Choose a time frame",
                choices = c('Year', 'Month', 'Hour', 'Weekday'),
                selected = 'Year'),
    
    sliderInput('percentage', 'Percentage Raised:',
     min = 0, max = 1000,
     step = 100, value = c(100,600)),
    
    selectInput('legend', 'Sort the data by:',
                choices = c('Number of Backers' = 'Number_of_Backers', 'Dollars Pledged' = 'Dollars_Pledged', 'Number of Projects' = 'Number_of_Projects'),
                selected = 'Number of Backers')
    

  )),
  
  
  dashboardBody(
    tabItems(
    tabItem(tabName = "maps",
            fluidPage(plotlyOutput('maps', height = 900L),
                      height = 1100L, width = 12L)),
    
    tabItem(tabName = "data",
            fluidRow(box(DT::dataTableOutput('table')))),
    
    tabItem(tabName = 'giggity',
         fluidPage(plotlyOutput('bubble', height = 900L),
                   height = 1100L, width = 12L)),
    
    tabItem(tabName = 'clocks',
            fluidPage(plotlyOutput('clocks', height = 900L),
                      height = 1100L, width = 12L))
    )
)))

