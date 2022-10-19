# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("Hmisc")

# Leer librerías

library(tidyverse)
library(Hmisc)

# Leer datos (de internet)

dweb1 <- paste0("https://raw.githubusercontent.com/amosino/",
               "/courses--econometria/master/",
               "econometria_salud/econometria_salud--datos/CancerData_P1.csv")

dweb2 <- paste0("https://raw.githubusercontent.com/amosino/",
                "/courses--econometria/master/",
                "econometria_salud/econometria_salud--datos/CancerData_P2.csv")

dweb3 <- paste0("https://raw.githubusercontent.com/amosino/",
                "/courses--econometria/master/",
                "econometria_salud/econometria_salud--datos/CancerData_D1.csv")

db_p1 <- read_csv(dweb1)
db_p2 <- read_csv(dweb2)
db_d1 <- read_csv(dweb3)

# Combinar por filas

db_p3 <- bind_rows(db_p1, db_p2, .id = "Idetificador")

# Combinar columnas

db_final <- full_join(db_p3, db_d1)
plot(describe(db_final))
