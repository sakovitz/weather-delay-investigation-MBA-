# Load departures log csv file
departure <- read.csv("departure_logs.csv",
                      sep = ",",
                      dec = ".")

# Load departures log csv file
arrival <- read.csv("arrival_logs.csv",
                      sep = ",",
                      dec = ".")

# Check types via Glimpse
glimpse(arrival)

# look some statistics
summary(arrival)


# Selecionando apenas as colunas 3 e 21
data_subset <- arrival[, c(2, 7, 5, 6, 12, 19, 20, 21)]


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

sub <- arrival_dummy[, c(9, 7,8,11,12,13,15)]

sub <- arrival_dummy[, c(9, 7,8,11,12,13,15)]

sub <- arrival_dummy[, c(9, 7,8,11,12,13,15)]

sub <- arrival_dummy[, c(9, 7,8,11,12,13,15)]

sub <- arrival_dummy[, c(9, 7,8,11,12,13,15)]

sub <- arrival_dummy[, c(9, 12, 13)]

# Usando chart.Correlation no subset
chart.Correlation(sub, histogram = TRUE)


################################################################
#modelo
arrival_m <- glm(formula = arrival_status_delayed ~ altimeter
                 + dew_point_temperature
                 + altimeter
                 + current_wx1_BR, 
                      data = arrival_dummy, 
                      family = "binomial")
