# server.R

library(shiny)
library(ggplot2)
library(dplyr)

# Load the dataset
customer_data <- read.csv("realistic_customer_data.csv")

# Define the server logic
server <- function(input, output) {
  
  # Reactive subset of the dataset based on user inputs
  filtered_data <- reactive({
    customer_data %>%
      filter(CustomerID == as.numeric(input$customer_id),
             QuantityPurchased >= input$quantity_range[1] & QuantityPurchased <= input$quantity_range[2])
  })
  
  # Histogram
  output$histogram <- renderPlot({
    ggplot(filtered_data(), aes(x = PurchaseAmount)) +
      geom_histogram(binwidth = 20, fill = "skyblue", color = "black") +
      labs(title = "Purchase Amount Distribution",
           x = "Purchase Amount",
           y = "Frequency") +
      theme_minimal()
  })
  
  # Line Plot
  output$lineplot <- renderPlot({
    ggplot(filtered_data(), aes(x = PurchaseDate, y = PurchaseAmount, group = 1)) +
      geom_line(color = "blue") +
      labs(title = "Purchase Amount Over Time",
           x = "Purchase Date",
           y = "Purchase Amount") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Bar Chart
  output$barchart <- renderPlot({
    ggplot(filtered_data(), aes(x = ReviewGiven, fill = factor(ReviewGiven))) +
      geom_bar() +
      labs(title = "Review Distribution",
           x = "Review Given",
           y = "Frequency") +
      theme_minimal()
  })
  
  # Scatter Plot
  output$scatterplot <- renderPlot({
    ggplot(filtered_data(), aes(x = QuantityPurchased, y = PurchaseAmount, color = factor(Frequency))) +
      geom_point() +
      labs(title = "Scatter Plot of Quantity vs Purchase Amount",
           x = "Quantity Purchased",
           y = "Purchase Amount") +
      theme_minimal()
  })
}

# Create Shiny app
# shinyApp(ui, server)
