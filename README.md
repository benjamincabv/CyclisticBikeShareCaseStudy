# CyclisticBikeShareCaseStudy

Cyclistic Bike-Share Case Study

Comparing member vs. casual rider behavior with SQL + R

## Project Summary
This project explores Q1 2019-2020 Cyclistic bike-share data to uncover how annual members and casual riders differ in usage.
The analysis combines BigQuery (SQL) for data cleaning and aggregation with R (tidyverse) for visualization and reporting.

The ultimate goal: identify behavioral insights that support marketing strategies to convert casual riders into members.


## Key Insights
- Members take the majority of trips (frequent, short, consistent rides aligned with commuting.
- Casual riders ride less often (longer, variable trips, concentrated on weekends and leisure areas.
- Commute KPI: Over 50% of member trips happen durng 7-9 Am and 4-6 PM, vs. ~30% for casual riders.
- Top stations differ by group (members near transit hubs, casuals near parks/tourists attractions.

Implication: Marketing should highlight the value of weekday commuting to casual riders. 


## Analysis Workflow
1. Data Cleaning
   - Removed nulls, standardized time formats, added derived fields (weekday, hour of day, ride length).
   - Exported a clean dataset (trips_cleaned.csv)

2. SQL Exploration
   - Queries for total trips, ride length quartiles, weekday patterns, commute windows, and top stations.

3. R Visualization
   - Histograms for ride length distribution.
   - Line Charts for Hourly Patterns.
   - Bar Charts for Weekday Usage and Commute KPIs.
   - Faceted Bar Charts for Top Start Stations.
  
4. Reporting
   - Results consolidated in a reproducible RMarkdown Notebook exported as PDF and HTML.
  


## Repository Contents
─ caseStudy_bikeShare_notebook.Rmd
─ caseStudy_bikeShare.pdf
─ trips_cleaned.csv
─ caseStudy_bikeShare_rScript.R
─ README.md


## Author
Benjamin Cabrera Villegas
https://www.linkedin.com/in/benjamincabreravillegas/

