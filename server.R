library(shiny)
library(shinydashboard)
library(DT)
library(dplyr)
library(plotly)

shinyServer(function(input, output) {
  
  
CategoryData <- reactive({

ks %>% 
    filter(., main_category %in% input$differences)
  })

TimeData <- reactive({
  
ks %>%
    group_by_(input$changes) %>% 
    summarise(Success = sum(state == "successful")/n())

})

CountryData <- reactive({
ks %>%
    group_by(countryname, countrycode) %>% 
    summarise_(Total = sum('input$legend')) %>% 
    filter(countrycode != 'USA')
  
})

#DATA TABLE
  output$table <- DT::renderDataTable({
    datatable(ks, rownames=FALSE) %>%
      formatStyle(input$selected, 
                  background="skyblue", fontWeight='bold')
  })

  
#OUTPUT FOR BUBBLE  
  output$bubble <- renderPlotly({
    plot_ly(CategoryData(), x = ~log10(goal), y = ~log10(usdpledged), 
                   text = ~paste('Name:', name, '<br> Goal:', goal, '<br> Raised (USD):', pledged), 
                   color = ~CategoryData()[[2]], type = 'scatter', mode = 'markers',
                 marker = list(size = ~ log(percentage,base = exp(0.25)), opacity = 0.5)) %>%
      layout(title = 'Success on Success',
             xaxis = list(showgrid = FALSE),
             yaxis = list(showgrid = FALSE),
             paper_bgcolor = 'rgb(243, 243, 243)',
             plot_bgcolor = 'rgb(243, 243, 243)')
    
  })
  
#OUTPUT FOR MAP
  
output$maps <- renderPlotly({
  plot_geo(CountryData()) %>%
    add_trace(
      z = ~CountryData()[[3]], color = ~CountryData()[[3]], colors = 'Blues',
      text = ~countryname, locations = ~countrycode,
      marker = list(line = list(color = toRGB("grey"), width = 0.5))) %>%
    colorbar(title = 'Can this change?') %>%
    layout(
      title = 'International Coverage of Kickstarter',
      geo = list(
        showframe = FALSE,
        showcoastlines = TRUE,
        projection = list(type = 'Mercator')
      )

    )
})


#OUTPUT FOR TIME CHART
output$clocks <- renderPlotly({

  plot_ly(TimeData(), x = TimeData()[[1]], y = TimeData()[[2]], type = 'bar', 
               text = TimeData()[[2]], textposition = 'auto',
               marker = list(color = 'rgb(158,202,225)',
                             line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
    layout(title = "Success over Time",
           xaxis = list(title = "Time Scale"),
           yaxis = list(title = "% of Success"))
  
})
  
  
  })

  

  


