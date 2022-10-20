# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("gapminder")

# Leer librerías

library(tidyverse)
library(gapminder)

# gather

dps <- read_csv(paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
                       "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
                       "/Datos/DeptsData.csv"))
dps_gather <- gather(dps, key="Year", value="Grad", -id)

# spread

wrm <- read_csv(paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
                       "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
                       "/Datos/WormsData.csv"))
wrm_spread <- spread(wrm, key="feature", value="measure")


# Filter

filter(gapminder, year==2007,  continent == "Asia")
gapminder %>% filter(year==2007)

# arrange

arrange(gapminder, desc(gdpPercap))
gapminder %>% arrange(desc(gdpPercap))

# filter + arrange

gapminder %>%
  filter(year==2007) %>% 
  arrange(desc(gdpPercap))

arrange(filter(gapminder, year==2007), desc(gdpPercap))

# mutate

mutate(gapminder, gdp = pop * gdpPercap)
gapminder %>% mutate(gdp = pop * gdpPercap)

#  mutate + arrange + filter

gapminder %>% 
  filter(year==2007) %>% 
  mutate(gdp = pop * gdpPercap) %>% 
  arrange(desc(pop))
