# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("Hmisc")

# Leer librerías

library(tidyverse)
library(Hmisc)

# Leer datos (de internet)

dweb <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/CancerData_P1.csv")

db <- read_csv(dweb)

# Estadística descriptiva

summary(db)
describe(db)
plot(describe(db))
describe(db["wbc"])

# Tratamiento de datos incoherentes

db$age[db$age<18 | db$age>100] <- NA
describe(db["age"])
db$sex[db$sex=="12.2"] <- NA
describe(db["sex"])
db[db==-98] <- NA
db[db==-99] <- NA
db[db=="not assessed"] <- NA
plot(describe(db))
db$wbc <- as.numeric(db$wbc)
