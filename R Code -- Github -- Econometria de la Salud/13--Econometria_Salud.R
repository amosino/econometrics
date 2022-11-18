# Instalar librerías si es necesario

# install.packages("tidyverse")
# install.packages("margins")
# install.packages("AER")
# install.packages("countreg", repos="http://R-Forge.R-project.org")
# install.packages("MASS")

# Leer librerías

library(tidyverse)
library(margins)
library(AER)
library(countreg)
library(MASS)

# Datos

web <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
              "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
              "/Datos/MEPSData.csv")

meps <- read_csv(web)

# Construcción de dummies

meps %>% mutate(femaled = as.numeric(female =="Female"),
                anylimd = as.numeric(anylim =="Activity limitation")) -> meps


# Estimación binomial negativa

nbm <- glm.nb(use_off ~ age + femaled,
              data = meps)
summary(nbm)
summary(margins(nbm))

# Rootogram

rootogram(nbm)
