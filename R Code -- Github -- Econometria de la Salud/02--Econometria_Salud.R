# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("Hmisc")

# Leer librerías

library(tidyverse)
library(Hmisc)

# Leer datos (de internet)

dweb1 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
                "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
                "/Datos/CancerData_P1.csv")

dweb2 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
                "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
                "/Datos/CancerData_P2.csv")

dweb3 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
                "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
                "/Datos/CancerData_D1.csv")

db_p1 <- read_csv(dweb1)
db_p2 <- read_csv(dweb2)
db_d1 <- read_csv(dweb3)

# Combinar por filas

db_p3 <- bind_rows(db_p1, db_p2, .id = "Idetificador")

# Combinar columnas

db_final <- full_join(db_p3, db_d1)
plot(describe(db_final))
