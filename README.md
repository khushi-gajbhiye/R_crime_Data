Crime Data Dashboard (R Shiny Project)

About this project

This project is a simple dashboard made using R Shiny to visualize crime data.
The idea behind this project was to make crime statistics easier to understand using graphs, tables and maps instead of raw data files.

Users can select a state and crime type and the dashboard updates automatically to show the analysis.

This project was mainly created for learning purposes and to understand how interactive dashboards work in R.
_____________________________________________________________________________________________________________________________________________
What this project does
Shows crime data in graphical form
Allows state-wise analysis
Allows filtering by crime type
Displays interactive charts and tables
Helps understand trends in data easily

Instead of reading Excel sheets, users can explore the data visually.
_____________________________________________________________________________________________________________________________________________
Who can use this

Anyone can run this project.

Even if you are new to R, just follow the steps below carefully and it should work.

This project is suitable for:

students
beginners learning R
basic data analysis practice
academic demonstration
_____________________________________________________________________________________________________________________________________________
Requirements

You only need two things installed:

1. R

Download from:
https://cran.r-project.org

Install normally.

2. RStudio

Download from:
https://posit.co/download/rstudio-desktop/

Install it after installing R.
_____________________________________________________________________________________________________________________________________________
How to run the project
Step 1 — Download the project

Go to the repository:

https://github.com/khushigajbhiye1485-glitch/R_crime_Data

Click Code → Download ZIP

Extract the folder anywhere on your computer.
_____________________________________________________________________________________________________________________________________________
Step 2 — Open in RStudio

Open RStudio → File → Open Project

Select:

crime dashboard.Rproj
_____________________________________________________________________________________________________________________________________________
Step 3 — Install packages (only first time)

Copy this into the Console and press Enter:

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

Wait until installation finishes.
_____________________________________________________________________________________________________________________________________________
Step 4 — Run the app

Open file:

app.R

Click Run App (top right).

After a few seconds, the dashboard will open in your browser.
_____________________________________________________________________________________________________________________________________________
How to use the dashboard
Select a state from the dropdown.
Choose a crime type (or select All).
Graphs and tables will update automatically.

You can try different combinations to explore the data.
_____________________________________________________________________________________________________________________________________________
Project files
app.R → main dashboard code
Crime Against Women.xlsx → dataset used
crime dashboard.Rproj → project file for RStudio
_____________________________________________________________________________________________________________________________________________
Purpose of the project

The goal of this project was to learn:

R Shiny application development
data visualization
handling real datasets
building interactive dashboards
_____________________________________________________________________________________________________________________________________________
Author

Khushi Gajbhiye

GitHub:
https://github.com/khushigajbhiye1485-glitch
_____________________________________________________________________________________________________________________________________________
Note

This project is created for educational purposes.
_____________________________________________________________________________________________________________________________________________
⭐ If you found this useful, you can star the repository.
