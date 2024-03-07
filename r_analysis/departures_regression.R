# Load departures log csv file
departure <- read.csv("departure_logs.csv",
                      sep = ",",
                      dec = ".")

# Load departures log csv file
arrival <- read.csv("arrival_logs.csv",
                      sep = ",",
                      dec = ".")

# Check types via Glimpse
glimpse(departure)

# look some statistics
summary(departure)


# Selecionando apenas as colunas 3 e 21
data_subset <- departure[, c(2, 7, 5, 6, 12, 19, 20, 21)]


# Usando chart.Correlation no subset
chart.Correlation(data_subset, histogram = TRUE)


# Selecionando apenas as colunas 3 e 21
data_subset_ <- arrival[, c(2, 4, 7, 5, 6, 8, 12, 19, 20, 21)]

# need to transform Y column into dummy
arrival_dummy <- dummy_columns(.data = data_subset_,
                               select_columns = "arrival_status",
                               remove_selected_columns = TRUE,
                               remove_most_frequent_dummy = TRUE)

# need to transform current_weather column into dummy
arrival_dummy <- dummy_columns(.data = arrival_dummy,
                               select_columns = "current_wx1",
                               remove_selected_columns = TRUE,
                               remove_most_frequent_dummy = TRUE)

# Usando chart.Correlation no subset
chart.Correlation(arrival_dummy, histogram = TRUE)
