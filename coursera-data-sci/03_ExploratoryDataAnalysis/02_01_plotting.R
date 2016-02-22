hist(airquality$Ozone)
with(airquality, plot(Wind, Ozone))
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
with(airquality, plot(Wind, Ozone))
par(bg="cyan")
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
with(airquality, plot(Wind, Ozone))
par(bg="teal")

par(bg="yellow")
with(airquality, plot(Wind, Ozone))
par(bg="transparent")
with(airquality, plot(Wind, Ozone))
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC"))
with(subset(airquality, Month=5), points(Wind, Ozone, col="blue"))
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="blue"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC"))
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC"), type="n")
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC"), type="n")
with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC", type="n"))
with(subset(airquality, Month!=5), points(Wind, Ozone, col="red"))
with(subset(airquality, Month==5), points(Wind, Ozone, col="blue"))
legend("topright", pch =1, col = c("blue", "red"), legend = c("May", "Other Months"))


with(airquality, plot(Wind, Ozone, main="Ozone and Wind in NYC", pch=20))
model <- lm(Ozone ~ Wind, airquality)

model
abline(model,lwd=2)

# multiple plots
par(mfrow = c(1, 3))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
})

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and weather in NYC", outer = TRUE)
})