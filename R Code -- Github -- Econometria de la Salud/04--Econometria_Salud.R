# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("effects")

# Instalar librerías

library(tidyverse)
library(effects)

# Leer datos (de internet)

dweb <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/MEPSData.csv")
db <- read_csv(dweb)

# Modelos de regresión lineal

mod1 <- lm(exp_tot ~ age + lninc, data = db )
summary(mod1)

mod2 <- lm(exp_tot ~ age + lninc, data = db, subset = (exp_tot>0) )
mod2s <- summary(mod2)
plot(effect("age",  mod2))
plot(effect("lninc",  mod2))

db %>% mutate(age2 = age^2) -> db
mod3 <- lm(exp_tot ~ age + age2 + lninc, data = db, subset = (exp_tot>0) )
mod3s <- summary(mod3)
plot(effect("age",  mod3))
plot(effect("age2",  mod3))

mod4 <- lm(exp_tot ~ age + I(age^2) + lninc, data = db, subset = (exp_tot>0) )
mod4s <- summary(mod4)
plot(effect("age",  mod4))
