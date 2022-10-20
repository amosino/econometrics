# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("lmtest")

# Leer librerías

library(tidyverse)
library(lmtest)

# Leer datos (de internet)

dweb <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/MEPSData.csv")
db <- read_csv(dweb)


# Variables dummy 

db %>% mutate(femaled = as.numeric(female =="Female")) -> db
db %>% mutate(anylimd = as.numeric(anylim =="Activity limitation")) -> db

db %>% mutate(femaled = as.numeric(female =="Female"),
              anylimd = as.numeric(anylim =="Activity limitation")) -> db

# Modelos MCO

mod1 <- lm(exp_tot~age+female, data=db)
summary(mod1)

mod2 <- lm(exp_tot~age+femaled, data=db)
summary(mod2)

mod3 <- lm(exp_tot~age+femaled+anylimd, data=db)
summary(mod3)

mod4 <- lm(exp_tot~age+I(age^2)+femaled+anylimd, data=db)
summary(mod4)

mod5 <- lm(exp_tot~age+I(age^2)+femaled+I(age*femaled)+anylimd, data=db)
summary(mod5)


# Gráficas de diagnóstico y prueba RESET

mod6 <- lm(exp_tot~I(age^2)+age*femaled+anylimd, data=db)
summary(mod6)
plot(mod6)
resettest(mod6, power=2:3, type="fitted")
hist(db$exp_tot)

mod7 <- lm(exp_tot~I(age^2)+age*femaled+anylimd, data=db, subset=(exp_tot>0))
summary(mod7)
plot(mod7)
resettest(mod7, power=2:3, type="fitted")

hist(log(db$exp_tot))
mod8 <- lm(log(exp_tot)~I(age^2)+age*femaled+anylimd, data=db, subset=(exp_tot>0))
summary(mod8)
plot(mod8)
resettest(mod8, power=2:3, type="fitted")

# Regresión lineal: Modelos lineales generalizados

mod9 <- glm(exp_tot~I(age^2)+age*femaled+anylimd, data=db, subset=(exp_tot>0))
summary(mod9)
