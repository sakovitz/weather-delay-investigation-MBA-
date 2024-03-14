## estimando modelo linear multiplo

# Load arrival log csv file
arrival_df <- read.csv("arrival_logs.csv",
                       sep = ",",
                       dec = ".")

#################################################
######## transform columns into dummies #########
#################################################

# selecting using columns
data_columns <- arrival_df[, c(3, 4, 7, 5, 6, 12, 19, 20, 21, 22)]

# Substituir NA por 0 na coluna low_cloud_level
data_columns$low_cloud_level[is.na(data_columns$low_cloud_level)] <- 0

# Substituir NA por 0 na coluna low_cloud_level
data_columns$wind_gust[is.na(data_columns$wind_gust)] <- 0

data_clean <- na.omit(data_columns)

complete_model <- lm(formula = arrival_delay_time ~ .,
                      data = data_clean)

summary(complete_model)

###########  stepwise ###########################
stepwised_model <- step(object = complete_model,
                   k = qchisq(p = 0.05, df = 1, lower.tail = FALSE))

summary(stepwised_model)
