# ui.R

library(shiny)
library(ggplot2)
library(dplyr)

# Load the dataset
customer_data <- read.csv("realistic_customer_data.csv")

# Define the user interface
ui <- fluidPage(
  titlePanel("Customer Purchase Behavior Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("customer_id", "Select Customer:",
                  choices = unique(customer_data$CustomerID),
                  selected = unique(customer_data$CustomerID)[1]),
      sliderInput("quantity_range", "Select Quantity Range:",
                  min = 1, max = 5, value = c(1, 5), step = 1)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Histogram", plotOutput("histogram")),
        tabPanel("Line Plot", plotOutput("lineplot")),
        tabPanel("Bar Chart", plotOutput("barchart")),
        tabPanel("Scatter Plot", plotOutput("scatterplot"))
      )
    )
  )
)
