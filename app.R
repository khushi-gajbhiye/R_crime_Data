# ================== LIBRARIES ==================
library(shiny)
library(shinydashboard)
library(readxl)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)
library(leaflet)
library(htmltools)
library(rnaturalearth)
library(sf)
library(scales)
library(shinyWidgets)

# ================== DATA ==================
data <- read_excel("Crime Against Women.xlsx")

data$Area_Name <- tolower(trimws(data$Area_Name))

data$Area_Name[data$Area_Name=="nct of delhi"] <- "delhi"
data$Area_Name[data$Area_Name=="odisha"] <- "orissa"
data$Area_Name[data$Area_Name=="uttarakhand"] <- "uttaranchal"

names(data) <- gsub("_"," ",names(data))

# ================== UI ==================
ui <- dashboardPage(
  
  dashboardHeader(
    title = tags$span(icon("chart-line"),
                      " Crime Analytics Dashboard")
  ),
  
  dashboardSidebar(
    width = 260,
    
    sidebarMenu(
      menuItem("Overview", tabName="overview", icon=icon("dashboard")),
      menuItem("State Analysis", tabName="state", icon=icon("chart-bar")),
      menuItem("Crime Trends", tabName="trends", icon=icon("chart-line")),
      menuItem("Crime Map", tabName="map", icon=icon("globe"))
    ),
    
    br(),
    div(style="padding:15px;",
        checkboxInput("top10","Show Top 10 States Only", value=FALSE)
    )
  ),
  
  dashboardBody(
    
    tags$head(tags$style(HTML("
.content-wrapper,.right-side{
background:linear-gradient(135deg,#eef2f3,#dfe9f3);
}
.box{
border-radius:18px;
box-shadow:0 8px 20px rgba(0,0,0,0.15);
border:none;
}
.small-box{border-radius:15px;}
.dataTables_wrapper{overflow-x:auto;}
body{font-family:'Segoe UI',sans-serif;}
"))),
    
    tabItems(
      
      # ================= OVERVIEW =================
      tabItem(tabName="overview",
              
              fluidRow(
                box(width=12,
                    h2("National Crime Overview"),
                    p("High-level summary of crimes against women across India.")
                )
              ),
              
              fluidRow(
                valueBoxOutput("total_cases"),
                valueBoxOutput("max_state"),
                valueBoxOutput("avg_cases")
              ),
              
              fluidRow(
                box(width=12,title="State-wise Crime Comparison",
                    plotlyOutput("state_bar",height=500))
              )
      ),
      
      # ================= STATE ANALYSIS =================
      tabItem(tabName="state",
              
              fluidRow(
                box(width=12,
                    h2("State-Level Crime Analysis"),
                    p("Select state and crime category to explore trends.")
                )
              ),
              
              # ---- STATE SELECT ----
              fluidRow(
                box(width=12,title="Select State",
                    pickerInput(
                      "state","Choose State:",
                      choices=sort(unique(data$`Area Name`)),
                      options=list(`live-search`=TRUE)
                    ))
              ),
              
              # ---- NEW CRIME TYPE SELECT ----
              fluidRow(
                box(width=12,title="Select Crime Type",
                    pickerInput(
                      "crime_type",
                      "Choose Crime Type:",
                      choices=sort(unique(data$`Group Name`)),
                      options=list(`live-search`=TRUE)
                    ))
              ),
              
              fluidRow(
                box(width=12,
                    title=uiOutput("state_title"),
                    plotlyOutput("state_plot",height=450))
              ),
              
              fluidRow(
                box(width=12,title="Detailed State Dataset",
                    DTOutput("table"))
              )
      ),
      
      # ================= TRENDS =================
      tabItem(tabName="trends",
              
              fluidRow(
                box(width=12,
                    h2("Crime Trend Analysis Over Years"))
              ),
              
              fluidRow(
                box(width=12,title="Yearly Crime Trend",
                    plotlyOutput("trend_plot",height=500))
              )
      ),
      
      # ================= MAP =================
      tabItem(tabName="map",
              
              fluidRow(
                box(width=12,
                    h2("Geographical Crime Distribution Map"))
              ),
              
              fluidRow(
                box(width=12,
                    leafletOutput("india_map",height=600))
              )
      )
      
    )
  )
)

# ================== SERVER ==================
server <- function(input, output) {
  
  # ---------- STATE SUMMARY ----------
  state_crime <- reactive({
    
    df <- data %>%
      group_by(`Area Name`) %>%
      summarise(total_cases=sum(`Cases Reported`,na.rm=TRUE),
                .groups="drop")
    
    if(input$top10)
      df <- df %>% arrange(desc(total_cases)) %>% slice_head(n=10)
    
    df
  })
  
  # ---------- FILTERED DATA (UPDATED) ----------
  filtered_data <- reactive({
    req(input$state, input$crime_type)
    
    data %>%
      filter(`Area Name`==input$state,
             `Group Name`==input$crime_type)
  })
  
  # VALUE BOXES
  output$total_cases <- renderValueBox({
    valueBox(comma(sum(data$`Cases Reported`,na.rm=TRUE)),
             "Total Crimes Reported",
             icon=icon("list"),
             color="purple")
  })
  
  output$max_state <- renderValueBox({
    m <- state_crime() %>% arrange(desc(total_cases)) %>% slice(1)
    
    valueBox(tools::toTitleCase(m$`Area Name`),
             "State with Highest Cases",
             icon=icon("exclamation-triangle"),
             color="yellow")
  })
  
  output$avg_cases <- renderValueBox({
    valueBox(comma(round(mean(data$`Cases Reported`,na.rm=TRUE))),
             "Average Cases per Record",
             icon=icon("chart-line"),
             color="green")
  })
  
  # BAR
  output$state_bar <- renderPlotly({
    
    p <- ggplot(state_crime(),
                aes(reorder(`Area Name`,total_cases),total_cases))+
      geom_col(fill="#667eea")+
      coord_flip()+
      scale_y_continuous(labels=comma)+
      theme_minimal()
    
    ggplotly(p)
  })
  
  # TITLE
  output$state_title <- renderUI({
    req(input$state,input$crime_type)
    
    h3(paste("Trend —",
             tools::toTitleCase(input$crime_type),
             "in",
             tools::toTitleCase(input$state)))
  })
  
  # STATE PLOT
  output$state_plot <- renderPlotly({
    
    p <- ggplot(filtered_data(),
                aes(Year,`Cases Reported`))+
      geom_line(color="#764ba2",linewidth=1.5)+
      geom_point(size=2)+
      scale_y_continuous(labels=comma)+
      theme_minimal()
    
    ggplotly(p)
  })
  
  # TABLE
  output$table <- renderDT({
    datatable(
      filtered_data(),
      options=list(pageLength=10,scrollX=TRUE),
      rownames=FALSE)
  })
  
  # YEAR TREND
  output$trend_plot <- renderPlotly({
    
    trend <- data %>%
      group_by(Year) %>%
      summarise(total=sum(`Cases Reported`,na.rm=TRUE),
                .groups="drop")
    
    p <- ggplot(trend,aes(Year,total))+
      geom_line(color="#ff6a00",linewidth=1.5)+
      geom_point(size=3)+
      scale_y_continuous(labels=comma)+
      theme_minimal()
    
    ggplotly(p)
  })
  
  # MAP
  output$india_map <- renderLeaflet({
    
    india_states <- ne_states(country="India",returnclass="sf")
    india_states$name <- tolower(india_states$name)
    
    crime_map <- india_states %>%
      left_join(state_crime(),by=c("name"="Area Name"))
    
    crime_map$total_cases[is.na(crime_map$total_cases)] <- 0
    
    pal <- colorNumeric("YlOrRd",domain=crime_map$total_cases)
    
    centroids <- st_point_on_surface(crime_map)
    
    leaflet(crime_map) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(
        fillColor=~pal(total_cases),
        weight=1,color="white",fillOpacity=0.85,
        label=~paste0(tools::toTitleCase(name),
                      "<br>Total Cases: ",comma(total_cases)) %>% lapply(HTML)
      ) %>%
      addLegend(pal=pal,values=~total_cases,title="Crime Density") %>%
      addLabelOnlyMarkers(
        lng=st_coordinates(centroids)[,1],
        lat=st_coordinates(centroids)[,2],
        label=~tools::toTitleCase(name),
        labelOptions=labelOptions(noHide=TRUE,textOnly=TRUE)
      )
  })
  
}

# ================= RUN =================
shinyApp(ui,server)