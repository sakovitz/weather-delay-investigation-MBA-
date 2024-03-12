#################################################
################ upload csv file ################
#################################################

# Load arrival log csv file
arrival_df <- read.csv("arrival_logs.csv",
                    sep = ",",
                    dec = ".")

#################################################
######## transform columns into dummies #########
#################################################

# selecting using columns
data_columns <- arrival_df[, c(2, 4, 7, 5, 6, 8, 12, 19, 20, 21, 22)]

# need to transform Y (arrival_status) column into dummy
arrival_dummy <- dummy_columns(.data = data_columns,
                               select_columns = "arrival_status",
                               remove_selected_columns = TRUE,
                               remove_most_frequent_dummy = TRUE)

# need to transform current_weather column into dummy
arrival_dummy <- dummy_columns(.data = arrival_dummy,
                               select_columns = "current_wx1",
                               remove_selected_columns = TRUE,
                               remove_most_frequent_dummy = TRUE)

#################################################
###### summarizing models to betas choice #######
#################################################

########################################################################
# 1- Model with all variables
complete_model <- glm(formula = arrival_status_delayed ~ .,
                 data = arrival_dummy, 
                 family = "binomial")
#checking summary
summary(complete_model)

#
summ(complete_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(complete_model, nobs = T, type = "text")

# MODEL FIT:
#   χ²(1) = 1.744, p = 0.187
#   AIC = 14.813, BIC = 16.594
#   Log Likelihood = error

########################################################################
# 2- Model with all variables except dummies

arrivals <- arrival_dummy[, c(1,2,3,4,5,6,7,8,9,10)]# selecting columns
arrivals <- na.omit(arrivals) #remove NAs

complete_model_bt_x_dummies <- glm(formula = arrival_status_delayed ~ ts 
                 +altimeter
                 +visibility
                 +wind_speed
                 +wind_gust
                 +wind_direction
                 +low_cloud_level
                 +air_temperature
                 +dew_point_temperature,
                 data = arrivals, 
                 family = "binomial")

#checking summary
summary(complete_model_bt_x_dummies)

summ(complete_model_bt_x_dummies, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(complete_model_bt_x_dummies, nobs = T, type = "text")

# MODEL FIT:
#   χ²(1) = 1.744, p = 0.187
#   AIC = 14.813, BIC = 16.594 
#   Log Likelihood = -5.407

########################################################################
# 3- Model with just ts, altimeter, visibility and wind_speed

arrivals <- arrival_dummy[, c(2,3,8,9,10)]# selecting columns
arrivals <- na.omit(arrivals) #remove NAs

four_betas_model <- glm(formula = arrival_status_delayed ~ ts 
                                   +altimeter
                                   +visibility
                                   +wind_speed,
                                   data = arrivals, 
                                   family = "binomial")

#checking summary
summary(four_betas_model)

summ(four_betas_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(four_betas_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(four_betas_model, type = "response") >= 0.5,
                      arrivals$arrival_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(4) = 101.463, p = 0.000
#   AIC = 10369.381, BIC = 10405.585 -> better
#   Log Likelihood = -5,179.691 -> better than last model
# Confusion Matrix:
#   Accuracy : 0.7958
#   Sensitivity : 0.045885        
#   Specificity : 0.989263 

########################################################################
# 4- Model with just ts, altimeter and visibility

arrivals <- arrival_dummy[, c(2,8,9,10)]# selecting columns
arrivals <- na.omit(arrivals) #remove NAs

alt_ts_vis_model <- glm(formula = arrival_status_delayed ~ ts 
                        +altimeter
                        +visibility,
                        data = arrivals, 
                        family = "binomial")

#checking summary
summary(alt_ts_vis_model)

summ(alt_ts_vis_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(alt_ts_vis_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(alt_ts_vis_model, type = "response") >= 0.5,
                      arrivals$arrival_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(3) = 101.398, p = 0.000
#   AIC = 10367.445, BIC = 10396.409 -> worse?
#   Log Likelihood = -5,179.723 -> WORSE!
# Confusion Matrix:
#   Accuracy : 0.7958
#   Sensitivity : 0.045885        
#   Specificity : 0.989263

########################################################################
# 5- Model with just ts, altimeter and wind_speed

arrivals <- arrival_dummy[, c(3,8,9,10)]# selecting columns
arrivals <- na.omit(arrivals) #remove NAs

alt_ts_wind_model <- glm(formula = arrival_status_delayed ~ ts 
                        +altimeter
                        +wind_speed,
                        data = arrivals, 
                        family = "binomial")

#checking summary
summary(alt_ts_wind_model)

summ(alt_ts_wind_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(alt_ts_wind_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(alt_ts_wind_model, type = "response") >= 0.5,
                      arrivals$arrival_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(3) = 100.836, p = 0.000
#   AIC = 10368.008, BIC = 10396.971 -> WORSE
#   Log Likelihood = -5,180.004 -> WORSE
# Confusion Matrix:
#   Accuracy : 0.7962
#   Sensitivity : 0.046358       
#   Specificity : 0.989629 
########################################################################
# 5- Model with just ts AND altimeter

arrivals <- arrival_dummy[, c(8,9,10)]# selecting columns
arrivals <- na.omit(arrivals) #remove NAs

alt_ts_model <- glm(formula = arrival_status_delayed ~ ts 
                         +altimeter,
                         data = arrivals, 
                         family = "binomial")

#checking summary
summary(alt_ts_model)

summ(alt_ts_model, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(alt_ts_model, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(alt_ts_model, type = "response") >= 0.5,
                      arrivals$arrival_status_delayed == 1)[2:1, 2:1])

# MODEL FIT:
#   χ²(2) = 100.765, p = 0.000
#   AIC = 10366.079, BIC = 10387.802 -> WORSE?
#   Log Likelihood = -5,180.040  -> WORSE
# Confusion Matrix:
#   Accuracy : 0.7965  
#   Sensitivity : 0.040681        
#   Specificity : 0.991459 


#################################################
################ StepWise model #################
#################################################

#using four_betas_model becose this model have the best LL score
#first need to find K using qchsq() function
chiq = 1.744
qchisq(chiq, df= 2, lower.tail = T)

model_step <- step(object = four_betas_model,
                   k = qchisq(p = 0.05, df = 1, lower.tail = FALSE))

summary(model_step)
summ(model_step, confint = T, digits = 3, ci.width = .95)

# log-likelihood check
stargazer(model_step, nobs = T, type = "text")

# Confusion Matrix to cutoff = 0.5
confusionMatrix(table(predict(model_step, type = "response") >= 0.5,
                      arrivals$arrival_status_delayed == 1)[2:1, 2:1])
# this result its equal to the last model statistics. But i will use this model.


#################################################
################ Predict to test ################
#################################################

#Fazendo predições para o modelo step_challenger:
#Exemplo 1: qual a probabilidade média de falha a 70ºF (~21ºC)?
predict(object = model_step,
        data.frame(ts = 1, # <- when SBGR is in thunderstorm and 
                   altimeter = 28,90), # the  atmospheric pressure is below 29.92
        type = "response")
# we have 78% probability to flight delay above 15 minutes
