---
  output:
  pdf_document: default
html_document: default
---
  
  
#Cyclistic Bike-Share Case Study
  
  ```{r}
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)

trips_cleaned <- readr::read_csv("trips_cleaned.csv")
```


#Preparing Dataset
```{r}
df <- trips_cleaned %>%
  mutate(
    started_at   = ymd_hms(started_at, quiet = TRUE),
    started_ct   = with_tz(started_at, "America/Chicago"),
    dow          = wday(started_ct, label = TRUE, abbr = TRUE),
    hour_of_day  = hour(started_ct),
    ride_min     = ride_length_seconds / 60
  )
```


# 1) Total Trips by Rider Type per Year

```{r}
df %>%
  count(year, member_casual) %>%
  ggplot(aes(x = factor(year), y = n, fill = member_casual)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = scales::comma(n)),
            position = position_dodge(width = 0.9),
            vjust = -0.3, size = 3.5) + 
  scale_y_continuous(labels = comma) +
  scale_fill_manual(values = c(casual = "tomato", member = "steelblue"),
                    name = "Rider type") +
  labs(x = "Year (Q1)", y = "Trips",
       title = "Total Trips by Rider Type per Year") +
  theme_minimal()
```


# 2) Ride Length Distribution Table

```{r}
df %>%
  group_by(year, member_casual) %>%
  summarise(
    trips          = n(),
    avg_minutes    = round(mean(ride_min, na.rm = TRUE), 2),
    p25_minutes    = round(quantile(ride_min, 0.25, na.rm = TRUE), 2),
    median_minutes = round(quantile(ride_min, 0.50, na.rm = TRUE), 2),
    p75_minutes    = round(quantile(ride_min, 0.75, na.rm = TRUE), 2),
    .groups = "drop"
  ) %>%
  arrange(year, member_casual)
```


#Visualizations

#Preparing Dataframe
```{r}
df <- df %>%
  mutate(ride_min = as.numeric(ride_length_seconds) / 60)

plot_ride_length <- function(data, yr, rider) {
  gdat <- data %>%
    filter(year == yr, member_casual == rider)
  
  total_trips <- nrow(gdat)
  
  ggplot(gdat, aes(x = ride_min)) +
    geom_histogram(binwidth = 1, color = "white", fill = "steelblue") +
    coord_cartesian(xlim = c(0, 60)) +
    labs(
      title    = "Ride Length Distribution",
      subtitle = paste("Q1", yr, "|", rider, "| Total Trips:", comma(total_trips)),
      x = "Ride Length (Minutes)",
      y = "Number of Trips"
    ) +
    theme_minimal()
}
```


#Calling the Four Graphs
```{r}
# 2019 - members
plot_ride_length(df, 2019, "member")

# 2019 - casual
plot_ride_length(df, 2019, "casual")

# 2020 - members
plot_ride_length(df, 2020, "member")

# 2020 - casual
plot_ride_length(df, 2020, "casual")

```


#Code Chunks to generate each Graph Individually

# 2a) Histogram 2019 – Members
```{r}
total_trips <- df %>% filter(year == 2019, member_casual == "member") %>% nrow()

df %>%
  filter(year == 2019, member_casual == "member") %>%
  mutate(ride_min = as.numeric(ride_length_seconds) / 60) %>%
  ggplot(aes(x = ride_min)) +
  geom_histogram(binwidth = 1, color = "white", fill = "steelblue") +
  coord_cartesian(xlim = c(0, 60)) +
  labs(
    title = "Ride Length Distribution",
    subtitle = paste("Q1 2019 | Members | Total trips:", comma(total_trips)),
    x = "Ride Length (Minutes)",
    y = "Number of Trips"
  ) +
  theme_minimal()
```


# 2b) Histogram  2019 – Casual
```{r}
total_trips <- df %>% filter(year == 2019, member_casual == "casual") %>% nrow()

df %>%
  filter(year == 2019, member_casual == "casual") %>%
  mutate(ride_min = as.numeric(ride_length_seconds) / 60) %>%
  ggplot(aes(x = ride_min)) +
  geom_histogram(binwidth = 1, color = "white", fill = "tomato") +
  coord_cartesian(xlim = c(0, 60)) +
  labs(
    title = "Ride Length Distribution",
    subtitle = paste("Q1 2019 | Casual Riders | Total trips:", comma(total_trips)),
    x = "Ride Length (Minutes)",
    y = "Number of Trips"
  ) +
  theme_minimal()
```


# 2c) Histogram  2020 – Members
```{r}
total_trips <- df %>% filter(year == 2020, member_casual == "member") %>% nrow()

df %>%
  filter(year == 2020, member_casual == "member") %>%
  mutate(ride_min = as.numeric(ride_length_seconds) / 60) %>%
  ggplot(aes(x = ride_min)) +
  geom_histogram(binwidth = 1, color = "white", fill = "steelblue") +
  coord_cartesian(xlim = c(0, 60)) +
  labs(
    title = "Ride Length Distribution",
    subtitle = paste("Q1 2020 | Members | Total Trips:", comma(total_trips)),
    x = "Ride Length (Minutes)",
    y = "Number of Trips"
  ) +
  theme_minimal()
```


# 2d) Histogram  2020 – Casual
```{r}
total_trips <- df %>% filter(year == 2020, member_casual == "casual") %>% nrow()

df %>%
  filter(year == 2020, member_casual == "casual") %>%
  mutate(ride_min = as.numeric(ride_length_seconds) / 60) %>%
  ggplot(aes(x = ride_min)) +
  geom_histogram(binwidth = 1, color = "white", fill = "tomato") +
  coord_cartesian(xlim = c(0, 60)) +
  labs(
    title = "Ride Length Distribution",
    subtitle = paste("Q1 2020 | Casual Riders | Total Trips:", comma(total_trips)),
    x = "Ride Length (Minutes)",
    y = "Number of Trips"
  ) +
  theme_minimal()
```


# 3) Trips by Weekday (Sun→Sat) per Rider Type

#Table
```{r}
df %>%
  mutate(
    year             = year(started_at),
    day_of_week_num  = wday(started_at, week_start = 7),   # 1=Sun … 7=Sat
    day_of_week_name = wday(started_at, week_start = 7, label = TRUE, abbr = FALSE)
  ) %>%
  group_by(year, member_casual, day_of_week_num, day_of_week_name) %>%
  summarise(trips = n(), .groups = "drop") %>%
  arrange(year, member_casual, day_of_week_num)
```

#Visualizations

#Trips by Weekday Q1 - 2019
#Bar Chart
```{r}
df %>%
  filter(year == 2019) %>%
  count(member_casual, dow) %>%                              # dow = Sun, Mon, ...
  mutate(dow = factor(dow, levels = c("Sun","Mon","Tue","Wed","Thu","Fri","Sat"))) %>%
  ggplot(aes(x = dow, y = n, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(casual = "tomato", member = "steelblue"), name = "Rider Type") +
  scale_y_continuous(labels = comma) +
  labs(x = "Day of Week", y = "Trips",
       title = "Trips by Weekday — Q1 2019") +
  theme_minimal()

```

#Trips by Weekday Q1 - 2020
#Bar Chart 
```{r}
df %>%
  filter(year == 2020) %>%
  count(member_casual, dow) %>%
  mutate(dow = factor(dow, levels = c("Sun","Mon","Tue","Wed","Thu","Fri","Sat"))) %>%
  ggplot(aes(x = dow, y = n, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(casual = "tomato", member = "steelblue"), name = "Rider Type") +
  scale_y_continuous(labels = comma) +
  labs(x = "Day of Week", y = "Trips",
       title = "Trips by Weekday — Q1 2020") +
  theme_minimal()
```

# 4) Trips by Hour of Day × Rider Type per Year

#Table
```{r}
hourly_table <- df %>%
  mutate(
    start_local = force_tz(started_at, "America/Chicago"),
    hour_local  = hour(start_local)
  ) %>%
  group_by(year, member_casual, hour_local) %>%
  summarise(total_trips = n(), .groups = "drop") %>%
  arrange(year, member_casual, hour_local)

hourly_table
```

#Visualizations

#Hourly Usage Patterns - Q1 2019
```{r}
df %>%
  mutate(
    start_local = force_tz(started_at, "America/Chicago"),
    hour_local  = hour(start_local)
  ) %>%
  filter(year == 2019) %>%
  count(member_casual, hour_local) %>%
  ggplot(aes(x = hour_local, y = n, color = member_casual)) +
  geom_line() +
  geom_point(size = 1.5) +
  scale_x_continuous(breaks = seq(0, 23, 2), minor_breaks = NULL, expand = expansion(mult = c(0.01, 0.01))) +
  scale_y_continuous(breaks = seq(0, 50000, 5000), labels = comma) +
  scale_color_manual(values = c(casual = "tomato", member = "steelblue"),
                     name = "Rider Type") +
  labs(x = "Hour of Day", y = "Trips",
       title = "Hourly Usage Patterns — Q1 2019 (Local Time)") +
  theme_minimal()

```


#Hourly Usage Patterns - Q1 2020
```{r}
df %>%
  mutate(
    start_local = force_tz(started_at, "America/Chicago"),
    hour_local  = hour(start_local)
  ) %>%
  filter(year == 2020) %>%
  count(member_casual, hour_local) %>%
  ggplot(aes(x = hour_local, y = n, color = member_casual)) +
  geom_line() +
  geom_point(size = 1.5) +
  scale_x_continuous(breaks = seq(0, 23, 2), minor_breaks = NULL, expand = expansion(mult = c(0.01, 0.01))) +
  scale_y_continuous(breaks = seq(0, 50000, 5000), labels = comma) +
  scale_color_manual(values = c(casual = "tomato", member = "steelblue"),
                     name = "Rider Type") +
  labs(x = "Hour of Day", y = "Trips",
       title = "Hourly Usage Patterns — Q1 2020 (Local Time)") +
  theme_minimal()
```


# 5) Commute-Window Share (7–9 & 16–18) — simple bar

#Build commute KPI table (local time)
```{r}
commute_hours <- c(7, 8, 9, 16, 17, 18)

commute <- df %>%
  mutate(
    start_local = force_tz(started_at, "America/Chicago"),
    hour_local  = hour(start_local),
    is_commute  = hour_local %in% commute_hours
  ) %>%
  count(year, member_casual, is_commute) %>%
  group_by(year, member_casual) %>%
  summarise(
    pct_commute = sum(n[is_commute]) / sum(n),
    .groups = "drop"
  )
```

#Visualization
#Commute-Window Share during Peak Times
```{r}
ggplot(commute, aes(x = factor(year), y = pct_commute, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_y_continuous(
    labels = scales::percent,
    breaks = seq(0, 1, 0.05)
  ) +
  scale_fill_manual(values = c(casual = "tomato", member = "steelblue"),
                    name = "Rider Type") +
  labs(
    x = "Year (Q1)",
    y = "% of Trips in Commute Windows",
    title = "Commute-Window Share (Peak Times 7–9 & 16–18)"
  ) +
  theme_minimal()
```


# 6) Top 10 Start Stations per Rider Type × Year

```{r}
top_stations <- df %>%
  filter(!is.na(start_station_name), start_station_name != "") %>%
  count(year, member_casual, start_station_name) %>%
  group_by(year, member_casual) %>%
  slice_max(n, n = 10, with_ties = FALSE) %>%
  ungroup()

ggplot(top_stations,
       aes(x = reorder(start_station_name, n), y = n, fill = member_casual)) +
  geom_col() +
  coord_flip() +
  facet_wrap(year ~ member_casual, scales = "free_y") +
  labs(x = "Start station", y = "Trips", fill = "Rider type",
       title = "Top 10 start stations")
```

