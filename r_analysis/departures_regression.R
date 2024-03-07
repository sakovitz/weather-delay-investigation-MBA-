# Load departures log csv file
departure <- read.csv("departure_logs.csv",
                      sep = ",",
                      dec = ".")

# Check types via Glimpse
glimpse(departure)

# look some statistics
summary(departure)

# Selecionando apenas as colunas 3 e 21
data_subset <- departure[, c(3, 7, 5, 6, 12, 19, 20, 21)]

# Usando chart.Correlation no subset
chart.Correlation(data_subset, histogram = TRUE)
