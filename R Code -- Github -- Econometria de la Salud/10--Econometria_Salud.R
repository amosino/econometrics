# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("sampleSelection")

library(sampleSelection)
library(tidyverse)


# Modelo Heckman para Mroz

data(Mroz87)

Mroz87$kids <- ( Mroz87$kids5 + Mroz87$kids618 > 0 )
heckman1 <- heckit( lfp ~ age + I( age^2 ) + kids + huswage + educ,
                  log(wage) ~ educ + exper + I( exper^2 ) + city, 
                  data=Mroz87 )
summary(heckman1)

mselection1 <- selection(lfp ~ age + I( age^2 ) + kids + huswage + educ, 
                        log(wage) ~ educ + exper + I( exper^2 ) + city,
                        data=Mroz87)
summary(mselection1)

# Modelo Heckman para MEPS

web <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/MEPSData.csv")
meps <- read_csv(web)

meps %>% mutate(femaled = as.numeric(female =="Female"),
                anylimd = as.numeric(anylim =="Activity limitation"),
                exp_totd = as.numeric(exp_tot >0)) -> meps

heckman2 <- heckit(exp_totd ~ age + femaled,
                    exp_tot ~ age + female, 
                    data=meps)
summary(heckman2)

mselection2 <- selection(exp_totd ~ age + femaled,
                         exp_tot ~ age + female, 
                         data=meps)
summary(mselection2)
