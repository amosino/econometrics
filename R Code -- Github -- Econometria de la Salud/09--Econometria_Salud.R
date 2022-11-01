# Instalar librerías de ser necesario

# install.packages("tidyverse")
# install.packages("VGAM")
# install.packages("censReg")

# Leer Librerías

library(tidyverse)
library(VGAM)
library(censReg)

# Descargar datos: Prueba de aptitud y MEPS

web1 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/TobitData.csv")

web2 <- paste0("https://raw.githubusercontent.com/amosino/econometrics/main",
               "/R%20Code%20--%20Github%20--%20Econometria%20de%20la%20Salud",
               "/Datos/MEPSData.csv")

aptt <- read_csv(web1)
meps <- read_csv(web2)

# Generación de datos: simulación

set.seed(123)
x <- 11:60
u <- rnorm(n=length(x), mean=0, sd=10)
ys <- -40 + 1.2*x + u

# Gráficos

plot(x,ys, pch=16, cex=1.3, col="red")
abline(lm(ys~x), col="black")
abline(h=0, col="gray")
abline(lm(ys~x, subset = (ys>0)), col="blue")

# Datos censurados

y <- ifelse(ys>0,ys,0)
plot(x,y, pch=16, cex=1.3, col="red")
abline(lm(ys~x), col="black")
abline(lm(y~x), col="blue")

# Estimación Tobit

mtobit <- vglm(y~x, tobit(Lower=0))
summary(mtobit)
abline(a=-44.37, b=1.3013, col="green")

# Ejemplo: Prueba aptitud

m1 <- glm(apt ~ read + math+prog, data=aptt)
summary(m1)
hist(aptt$apt)
m1_tobit <- vglm(apt ~ read + math+prog, data=aptt, 
                 tobit(Lower=200, Upper=800))
summary(m1_tobit)

# Ejemplo: MEPS 

meps %>% mutate(femaled = as.numeric(female =="Female"),
              anylimd = as.numeric(anylim =="Activity limitation")) -> meps
m2_tobit <- vglm(exp_tot ~ age*femaled, data=meps, 
                 tobit(Lower=0))
summary(m2_tobit)

m3_tobit <- censReg(exp_tot ~ age*femaled, data=meps, 
                 left=0)
summary(m3_tobit)
margEff(m3_tobit)
