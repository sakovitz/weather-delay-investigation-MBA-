#################################################
################ upload csv file ################
#################################################

# Load arrival log csv file
departure_df <- read.csv("departure_logs.csv",
                       sep = ",",
                       dec = ".")

#################################################
######## transform columns into dummies #########
#################################################

# selecting using columns
data_columns <- departure_df[, c(2, 4, 7, 5, 6, 12, 19, 20, 21, 22)]

# Substituir NA por 0 na coluna low_cloud_level
data_columns$low_cloud_level[is.na(data_columns$low_cloud_level)] <- 0

# Substituir NA por 0 na coluna low_cloud_level
data_columns$wind_gust[is.na(data_columns$wind_gust)] <- 0

# need to transform Y (arrival_status) column into dummy
departure_dummy <- dummy_columns(.data = data_columns,
                               select_columns = "departure_status",
                               remove_selected_columns = TRUE,
                               remove_most_frequent_dummy = TRUE)

data_clean <- na.omit(departure_dummy)


#################################################
###### summarizing models to betas choice #######
#################################################

########################################################################
# 1- Model with all variables
complete_model <- glm(formula = departure_status_delayed ~ .,
                      data = data_clean, 
                      family = "binomial")
#checking summary
summary(complete_model)

#
summ(complete_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(complete_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(complete_model, type = "response") >= 0.5,
                      data_clean$departure_status_delayed == 1)[2:1, 2:1])

# log-likelihood check
# stargazer(complete_model, nobs = T, type = "text") # error number of columns

# MODEL FIT:
#   χ²(1) = 0.159, p = 0.690
#   AIC = 46.996, BIC = 50.424 

########################################################################
# 2- Model with all variables except dummies

departures <- departure_dummy[, c(1,2,3,4,5,6,7,8,9,10)]# selecting columns
departures <- na.omit(departures) #remove NAs

complete_model_bt_x_dummies <- glm(formula = departure_status_delayed ~ ts 
                                   +altimeter
                                   +visibility
                                   +wind_speed
                                   +wind_gust
                                   +wind_direction
                                   +low_cloud_level
                                   +air_temperature
                                   +dew_point_temperature,
                                   data = departures, 
                                   family = "binomial")

#checking summary
summary(complete_model_bt_x_dummies)

summ(complete_model_bt_x_dummies, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(complete_model_bt_x_dummies, nobs = T, type = "text")

# MODEL FIT:
#   χ²(1) = 0.159, p = 0.690
#   AIC = 46.996, BIC = 50.424 
#   Log Likelihood = -21.498 

########################################################################
# 3- Model with just ts, altimeter, visibility and wind_speed

departures_ <- departure_dummy[, c(2,3,8,9,10)]# selecting columns
departures_ <- na.omit(departures_) #remove NAs

four_betas_model <- glm(formula = departure_status_delayed ~ ts 
                        +altimeter
                        +visibility
                        +wind_speed,
                        data = departures_, 
                        family = "binomial")

#checking summary
summary(four_betas_model)

summ(four_betas_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(four_betas_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(four_betas_model, type = "response") >= 0.5,
                      departures_$departure_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(4) = 136.950, p = 0.000
#   AIC = 11129.634, BIC = 11165.894 
#   Log Likelihood = -5,559.817  -> better than last model
# Confusion Matrix:
#   Accuracy : 0.7719
#   Sensitivity : 0.04453         
#   Specificity : 0.98978 

########################################################################
# 4- Model with just ts, altimeter and visibility

departures_2 <- departure_dummy[, c(2,8,9,10)]# selecting columns
departures_2 <- na.omit(departures_2) #remove NAs

alt_ts_vis_model <- glm(formula = departure_status_delayed ~ ts 
                        +altimeter
                        +visibility,
                        data = departures_2, 
                        family = "binomial")

#checking summary
summary(alt_ts_vis_model)

summ(alt_ts_vis_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(alt_ts_vis_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(alt_ts_vis_model, type = "response") >= 0.5,
                      departures_2$departure_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(3) = 110.521, p = 0.000
#   AIC = 11154.064, BIC = 11183.071
#   Log Likelihood = -5,573.032  
# Confusion Matrix:
#   Accuracy : 0.7716
#   Sensitivity : 0.04494         
#   Specificity : 0.98928  

########################################################################
# 5- Model with just ts, altimeter and wind_speed

departures_3 <- departure_dummy[, c(3,8,9,10)]# selecting columns
departures_3 <- na.omit(departures_3) #remove NAs

alt_ts_wind_model <- glm(formula = departure_status_delayed ~ ts 
                         +altimeter
                         +wind_speed,
                         data = departures_3, 
                         family = "binomial")

#checking summary
summary(alt_ts_wind_model)

summ(alt_ts_wind_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(alt_ts_wind_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(alt_ts_wind_model, type = "response") >= 0.5,
                      departures_3$departure_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(3) = 129.996, p = 0.000
#   AIC = 11134.588, BIC = 11163.596 -> worse
#   Log Likelihood = -5,563.294  -> better
# Confusion Matrix:
#   Accuracy : 0.7716
#   Sensitivity : 0.04494         
#   Specificity : 0.98928  

########################################################################
# 5- Model with just ts AND altimeter

departures_4 <- departure_dummy[, c(8,9,10)]# selecting columns
departures_4 <- na.omit(departures_4) #remove NAs

alt_ts_model <- glm(formula = departure_status_delayed ~ ts 
                    +altimeter,
                    data = departures_4, 
                    family = "binomial")

#checking summary
summary(alt_ts_model)

summ(alt_ts_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(alt_ts_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(alt_ts_model, type = "response") >= 0.5,
                      departures_4$departure_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(2) = 103.141, p = 0.000
#   AIC = 11159.443, BIC = 11181.199 -> better
#   Log Likelihood = -5,576.722   -> WORSE
# Confusion Matrix:
#   Accuracy : 0.7716  
#   Sensitivity : 0.04494         
#   Specificity : 0.98928  


#################################################
################ StepWise model #################
#################################################

#using four_betas_model becose this model have the best LL score
#first need to find K using qchsq() function
chiq = 136.950
qchisq(chiq, df= 2, lower.tail = T)

model_step <- step(object = complete_model,
                   k = qchisq(p = 0.05, df = 1, lower.tail = FALSE))

summary(model_step)
summ(model_step, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(model_step, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(model_step, type = "response") >= 0.5,
                      data_clean$departure_status_delayed == 1)[2:1, 2:1])
# this result its equal to the last model statistics. But i will use this model.


#################################################
################ Predict to test ################
#################################################

#Fazendo predições para o modelo step_challenger:
#Exemplo 1: qual a probabilidade média de falha a 70ºF (~21ºC)?
predict(object = model_step,
        data.frame(ts = 1, # <- when SBGR is in thunderstorm and 
                   altimeter = 28.90,# the  atmospheric pressure is below 29.92
                   visibility = 8000, # visibility below 9999 (perfect visibility)
                   wind_speed = 5), # low wind speed
        type = "response")
# we have 70% probability to flight delay above 15 minutes
