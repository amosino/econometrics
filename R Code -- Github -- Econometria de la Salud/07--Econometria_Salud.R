# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("MASS")

# Leer librerías

library(tidyverse)
library(MASS)

# Leer datos (de internet)

dweb <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/MEPSData.csv")
db <- read_csv(dweb)

# Variables dummy 

db %>% mutate(femaled = as.numeric(female =="Female"),
              anylimd = as.numeric(anylim =="Activity limitation")) -> db

# Modelos lineales generalizados: lineal/gaussiano

mod1 <- glm(exp_tot~I(age^2)+age*femaled+anylimd, 
            data=db, 
            subset=(exp_tot>0))
summary(mod1)

# Modelos lineales generalizados: logaritmico/gaussiano

mod2 <- glm(exp_tot~I(age^2)+age*femaled+anylimd, 
            data=db, 
            subset=(exp_tot>0),
            family=gaussian(link="log"))
summary(mod2)
plot(mod2)

# Modelos lineales generalizados: logaritmico/gamma

mod3 <- glm(exp_tot~I(age^2)+age*femaled+anylimd, 
            data=db, 
            subset=(exp_tot>0),
            family=Gamma(link="log"))
summary(mod3)
plot(mod3)

# Transformación Cox-Box

bc <- boxcox(mod1)
