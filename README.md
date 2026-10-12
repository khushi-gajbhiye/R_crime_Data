# Crime Data Dashboard

Crime Data Dashboard is an R Shiny-based interactive data visualization system used to explore and analyze crime statistics through charts, tables, and maps. The application allows users to select states and crime categories to understand patterns in crime data easily.



## Problem Statement

The aim of this mini project is to build an interactive dashboard that converts raw crime data into meaningful visual insights. Instead of manually analyzing Excel files, users can explore crime statistics dynamically using filters and visualizations.

The system helps users understand crime trends through graphical representation and interactive analysis.



## Technologies Used

According to the project requirements, this project uses:

- Programming Language: `R`
- Framework: `Shiny`
- Data Source: `Excel Dataset (.xlsx)`



## Tech Stack

- R
- Shiny
- shinydashboard
- ggplot2
- plotly
- dplyr
- leaflet
- DT
- readxl
- sf



## Dataset Information

- Dataset Name: `Crime Against Women.xlsx`
- Format: Excel file
- Used for visualization and analysis inside the dashboard.



## User Interface Pages

The dashboard includes multiple interactive sections:

- Dashboard Overview
- State Analysis
- Crime Type Analysis
- Interactive Tables
- Map Visualization

Each section updates automatically based on user selections.



## Assignment Requirement Mapping

This project satisfies common mini project requirements:

1. Interactive User Interface  
   - Implemented using `Shiny Dashboard`

2. Backend Logic Using Programming Language  
   - Implemented using `R`

3. Data Connectivity  
   - Excel dataset loaded using `readxl`

4. Data Operations
   - Read data: dataset loading
   - Filter data: state and crime type selection
   - Display data: charts, tables, and maps
   - Dynamic updates based on user input

5. Input Handling
   - Dropdown selections for state and crime category

6. Clear Problem Statement and Working Solution
   - Crime data converted into interactive visual dashboard



## How To Run The Project

### 1. Open RStudio and navigate to the project folder

Example:

```powershell
cd "C:\Users\HP\Downloads\R_crime_Data"
```



### 2. Open the project file

Open:

```
crime dashboard.Rproj
```

inside RStudio.



### 3. Install required packages (first time only)

Run in RStudio Console:

```r
install.packages(c(
"shiny",
"shinydashboard",
"readxl",
"dplyr",
"ggplot2",
"plotly",
"DT",
"leaflet",
"htmltools",
"rnaturalearth",
"sf",
"scales"
))
```



### 4. Run the application

Open file:

```
app.R
```

Click **Run App** in RStudio.



### 5. Access the dashboard

The application will automatically open in your browser:

```
http://127.0.0.1:xxxx
```

(port number may vary)



## Project Features

- Interactive crime data visualization
- State-wise crime analysis
- Crime type filtering
- Dynamic charts and graphs
- Interactive tables
- Geographic map visualization
- Easy-to-use dashboard interface



## Data Operations In This Project

- Create  
  - Not applicable (read-only dataset)

- Read  
  - Load crime dataset from Excel file

- Update  
  - Dynamic filtering based on user selection

- Display  
  - Charts, tables, and maps update automatically


## Notes

- Make sure all packages are installed before running the app.
- Keep RStudio open while the dashboard is running.
- Press **Stop** in RStudio to close the application.
- Dataset file must remain in the project folder.



## Author

Khushi Gajbhiye  

GitHub:  
https://github.com/khushi-gajbhiye
