# Load departures log csv file
arrival <- read.csv("arrival_logs.csv",
                      sep = ",",
                      dec = ".")

# Selecionando apenas as colunas 3 e 21
data_subset_ <- arrival[, c(2, 4, 7, 5, 6, 8, 12, 19, 20, 21, 22)]

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

# selecting columns
sub <- arrival_dummy[, c(10, 9)]

# Usando chart.Correlation no subset
chart.Correlation(sub, histogram = TRUE)


################################################################
# model
################################################################

arrival_m <- glm(formula = arrival_status_delayed ~ ts
                 + altimeter,
                      data = arrival_dummy, 
                      family = "binomial")

#model without altimeter variable to compare AIC, BIC and LL values
arrival_m_vis <- glm(formula = arrival_status_delayed ~ ts,
                 data = arrival_dummy, 
                 family = "binomial")

summary(arrival_m)
summ(arrival_m, confint = T, digits = 3, ci.width = .95)

# chi squared test
pchisq(100.765, df = 3, lower.tail = F)
# this result leads to rejection of the null hypothesis


#compare models with or without altimeter
export_summs(arrival_m, scale = F, digits = 6)
export_summs(arrival_m_vis, scale = F, digits = 6)

stargazer(arrival_m, nobs = T, type = "text") # shows Log-Likelihood value
stargazer(arrival_m_vis, nobs = T, type = "text") # shows Log-Likelihood value

#analysing the AIC, BIC and LL results, the arrival_m model stays!


# Extração dos intervalos de confiança ao nível de siginificância de 5%
confint(arrival_m, level = 0.90)

#Extração do valor de Log-Likelihood (LL)
logLik(arrival_m)
