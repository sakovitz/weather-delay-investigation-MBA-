## test linear model (not good)

#################################################
################ upload csv file ################
#################################################

# Load arrival log csv file
arrival_df_ <- read.csv("arrival_logs.csv",
                       sep = ",",
                       dec = ".")

#################################################
######## transform columns into dummies #########
#################################################

# selecting using columns
data_columns <- arrival_df_[, c(3, 4, 7, 5, 6, 12, 19, 20, 21, 22)]

#################################################
###### summarizing models to betas choice #######
#################################################

data_clean <- na.omit(data_columns)

# 1- Model with all variables
complete_model <- lm(formula = arrival_delay_time ~ .,
                      data = data_clean)
#checking summary
summary(complete_model)


#################################################
################ StepWise model #################
#################################################

#using four_betas_model becose this model have the best LL score
#first need to find K using qchsq() function
chiq = 0.058


model_step <- step(object = complete_model,
                   k = qchisq(chiq, df= 2, lower.tail = T))

summary(model_step)
summ(model_step, confint = T, digits = 3, ci.width = .95)



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
