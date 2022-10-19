# Instalar librerías de ser necesario

# install.packages("tidyverse")

# Leer librerías

library(tidyverse)


# Leer datos (de internet)

dweb <- paste0("https://raw.githubusercontent.com/amosino/",
               "/courses--econometria/master/",
               "econometria_salud/econometria_salud--datos/MEPSData.csv")
db <- read_csv(dweb)

# Variables dummy

db %>% mutate(femaled = as.numeric(female =="Female"),
              anylimd = as.numeric(anylim =="Activity limitation")) -> db


db %>% mutate(exp_tot_d = as.numeric(exp_tot > 0)) -> db


# Modelo de regresión (probabilidad) lineal

mod.lin  <- glm(exp_tot_d ~ femaled*age, data=db)
summary(mod.lin)

# Modelo probit

mod.prob  <- glm(exp_tot_d ~ femaled*age, 
                 data=db,
                 family = binomial(link="probit"))
summary(mod.prob)

# Predicción con modelo probit

data.predict <- data.frame(age=c(42), femaled=c(0,1))
predict(mod.prob, newdata = data.predict, type = "response")
predict(mod.prob, newdata = db, type = "response")

# Modelo logit

mod.logt  <- glm(exp_tot_d ~ femaled*age, 
                 data=db,
                 family = binomial(link="logit"))
summary(mod.logt)

# Predicción con modelo logit

predict(mod.logt, newdata = data.predict, type = "response")
predict(mod.logt, newdata = db, type = "response")
