
library(shiny)
library(plotly)
library(gridlayout)
library(bslib)

# UI part of the app
ui <- grid_page(
  layout = c(
    "header  header  ",
    "sidebar plot "
  ),
  row_sizes = c(
    "100px",
    "1fr"
  ),
  col_sizes = c(
    "250px",
    "1fr"
  ),
  gap_size = "1rem",
  grid_card(
    area = "sidebar",
    card_header("Settings"),
    card_body(
      selectInput(
        inputId = "ENCOUNTERCLASS",
        label = "Encounter Class",
        choices = list(
          "Emergency" = "Emergency",
          "Inpatient" = "Inpatient",
          "Outpatient" = "Outpatient",
          "Urgentcare" = "Urgentcare"
        ),
        selected = "Emergency",
        width = "100%"
      ),
      em("Select the encounter class you want to view the total claim cost distribution for.")
    )
  ),
  grid_card_text(
    area = "header",
    content = "Total Claim Cost by Encounter Class - Shiny App",
    alignment = "start",
    is_title = FALSE
  ),
  grid_card(
    area = "plot",
    card_header("Interactive Plot"),
    card_body(
      plotlyOutput(
        outputId = "plot",
        width = "100%",
        height = "100%"
      )
    )
  )
)

# Server part of the app
server <- function(input, output) {
  
  # Load the data
  # Make sure to set the correct path to your CSV file
  encounters <- read.csv("path/to/encounters.csv")
  
  # Render the Plotly plot
  output$plot <- renderPlotly({
    # Filter the data based on the selected encounter class
    filtered_data <- subset(encounters, ENCOUNTERCLASS == input$ENCOUNTERCLASS)
    
    # Create a bar plot with Plotly
    plot_ly(
      data = filtered_data,
      x = ~ENCOUNTERCLASS,
      y = ~TOTAL_CLAIM_COST,
      type = 'bar'
    )
  })
}

# Run the Shiny app
shinyApp(ui, server)