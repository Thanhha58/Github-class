library(ggplot2)

ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()


# create data
xValue <- 1:10
yValue <- cumsum(rnorm(10))
data <- data.frame(xValue,yValue)

# Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line()