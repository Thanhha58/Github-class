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


# Simple R file
# R example data.frame "cars"
str(cars)     # show the structure
summary(cars) # summary of the variables
plot(cars)    # plot speed against distance



library(gtsummary)

# summarize the data with our package
table1 <- 
  trial %>%
  tbl_summary(include = c(age, grade, response))