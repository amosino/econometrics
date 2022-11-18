library(tidyverse)
library(quantreg)

# Datos : MLB

web1 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/BaseballData.csv")

baseball <- read_csv(web1)

# Histograma de la variable dependiente: Salary

hist(log(baseball$Salary), prob=TRUE)
summary(log(baseball$Salary))
lines(density(log(baseball$Salary)))

# Estimación por MCO

mco <- lm(log(Salary) ~ AtBat + Hits + HmRun + Walks+ Years + PutOuts,
          data = baseball)
summary(mco)

# Estimaciones por regresión cuantílica

q1 <- rq(log(Salary) ~ AtBat + Hits + HmRun + Walks+ Years + PutOuts,
          data = baseball,
         tau = 0.25)
summary(q1, se = "boot")

q2 <- rq(log(Salary) ~ AtBat + Hits + HmRun + Walks+ Years + PutOuts,
         data = baseball,
         tau = 0.5)
summary(q2, se = "boot")

q3 <- rq(log(Salary) ~ AtBat + Hits + HmRun + Walks+ Years + PutOuts,
         data = baseball,
         tau = 0.75)
summary(q3, se = "boot")

q4 <- rq(log(Salary) ~ AtBat + Hits + HmRun + Walks+ Years + PutOuts,
         data = baseball,
         tau = seq(0.1, 0.9, by=0.1))
summary(q4, se = "boot")
plot(summary(q4))

# Datos: MEPS

web2 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
              "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
              "/Datos/MEPSData.csv")

meps <- read_csv(web)

# Construcción de dummies

meps %>% mutate(femaled = as.numeric(female =="Female"),
                anylimd = as.numeric(anylim =="Activity limitation")) -> meps


# Estimación por regresión cuantílica

mepsqr  <- rq(exp_tot ~ age + female,
              data = meps,
              subset=(exp_tot>0),
              tau=seq(0.1,0.9, by=0.1))
plot(summary(mepsqr))
