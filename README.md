# CyclisticBikeShareCaseStudy

Cyclistic Bike-Share Case Study

Comparing member vs. casual rider behavior with SQL + R

## Project Summary
This project explores Q1 2019-2020 Cyclistic bike-share data to uncover how annual members and casual riders differ in usage.
The analysis combines BigQuery (SQL) for data cleaning and aggregation with R (tidyverse) for visualization and reporting.

### The ultimate goal:
Identify behavioral insights that support marketing strategies to convert casual riders into members.
<br />
<br />

## Key Insights

- Members take the majority of trips (frequent, short, consistent rides aligned with commuting.
<img width="562" height="348" alt="1totalTripsByRiderTypePerYear" src="https://github.com/user-attachments/assets/fa94b9e4-5ab7-4bd0-8f3c-698e8533dd12" />



- Casual riders ride less often (longer, variable trips, concentrated on weekends and leisure areas.
<img width="561" height="347" alt="3rideLengthDistributionCasual2019" src="https://github.com/user-attachments/assets/48057577-0fd3-450a-8318-9114fd60b22f" />



- Commute KPI: Over 50% of member trips happen durng 7-9 Am and 4-6 PM, vs. ~30% for casual riders.
<img width="563" height="347" alt="10commuteWindowShare" src="https://github.com/user-attachments/assets/66ac30cc-a136-4f77-95a0-c63456ce3c84" />



- Top stations differ by group (members near transit hubs, casuals near parks/tourists attractions.
<img width="563" height="349" alt="11topStartStations" src="https://github.com/user-attachments/assets/b4bb785b-9558-43ce-8e18-6c3d0a021769" />



### Implication: 
Marketing should highlight the value of weekday commuting to casual riders. 


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

