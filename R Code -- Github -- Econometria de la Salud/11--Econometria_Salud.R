# Instalar librerías si es necesario
# install.packages("tidyverse")

# Leer librerías

library(tidyverse)

# Datos

web <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
              "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
              "/Datos/MEPSData.csv")

meps <- read_csv(web)

# Construcción de dummies

meps %>% mutate(femaled = as.numeric(female =="Female"),
                anylimd = as.numeric(anylim =="Activity limitation"),
                exp_totd = as.numeric(exp_tot >0)) -> meps

# Estimación en dos partes: parte 1

probit.parte1 <- glm(exp_totd ~ age*femaled, 
                     data=meps,
                     family=binomial(link="probit"))
summary(probit.parte1)
probabilidad.probit <- predict(probit.parte1, 
                               newdata=meps,
                               type = "response")

# Estimación en dos partes: parte 2

gamma.parte2 <- glm(exp_tot ~ age*femaled, 
                    data=meps,
                    subset=(exp_tot>0),
                    family=Gamma(link=log))
summary(gamma.parte2)
prediccion.gamma <- predict(gamma.parte2, 
                               newdata=meps,
                               type = "response")
# Predicción dos partes

exp_tot_dospartes <- probabilidad.probit * prediccion.gamma
tabla.resultados <- data.frame(y = meps$exp_tot, yhat = exp_tot_dospartes)
