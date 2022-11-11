# Instalar librerías si es necesario

# install.packages("tidyverse")
# install.packages("margins")
# install.packages("sandwich")

# Leer librerías

library(tidyverse)
library(margins)
library(sandwich)

# Datos

web <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
              "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
              "/Datos/MEPSData.csv")

meps <- read_csv(web)

# Construcción de dummies

meps %>% mutate(femaled = as.numeric(female =="Female"),
                anylimd = as.numeric(anylim =="Activity limitation")) -> meps


# Histograma de use_off

hist(meps$use_off)

# Estimación MCO

mco <- lm(use_off ~ age + femaled, data = meps)
summary(mco)

# Estimación Poisson

poisson <- glm(use_off ~ age + femaled,
               data = meps,
               family=poisson(link="log"))
summary(poisson)
summary(margins(poisson))

# Errores estándar robustos

cov.poisson <- vcovHC(poisson, type="HC0")
std.err <- sqrt(diag(cov.poisson))
r.est <- cbind(Estimate= coef(poisson), "Robust SE" = std.err,
               "Pr(>|z|)" = 2 * pnorm(abs(coef(poisson)/std.err), lower.tail=FALSE),
               LL = coef(poisson) - 1.96 * std.err,
               UL = coef(poisson) + 1.96 * std.err)
r.est
