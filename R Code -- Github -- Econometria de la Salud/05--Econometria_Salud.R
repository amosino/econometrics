# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("Hmisc")

# Leer librerías

library(tidyverse)
library(Hmisc)

# Leer datos (de internet)

dweb <- paste0("https://raw.githubusercontent.com/amosino/",
               "/courses--econometria/master/",
               "econometria_salud/econometria_salud--datos/STARData.csv")
db <- read_csv(dweb)


# Grupo de tratamiento y grupo de control

db %>% select(small, totalscore) %>%
  filter(small == 0) -> db_regular

db %>% select(small, totalscore) %>%
  filter(small == 1) -> db_small

# Efectos de tratamiento

tau <- mean(db_small$totalscore) - mean(db_regular$totalscore)

db %>% select(small, totalscore) %>%
  group_by(small) %>%
  summarise(mean(totalscore)) -> medias

# Efectos de tratamiento + Regresión lineal

summary(lm(totalscore~small, data=db))
summary(lm(totalscore~small+tchexper, data=db))
