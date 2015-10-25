# Q1

library(igraph)

# read the Facebook graph edgelist file
g <- read.graph('facebook_combined.txt', format = "edgelist")

# connected or not
is.connected(g)

# diameter
g_diameter = diameter(g)

# degree disrtibution
deg_dist <- degree.distribution(g)

# degree distribution plot
plot(deg_dist, xlab="Degree", ylab="Number of nodes", main="Degree distribution plot with fitted power law curve")

# fit a curve
power_law_fit = function(deg_dist) exp(cozf[[1]] + cozf[[2]] * log(deg_dist))
degrees = 1:max(degree(g))
nonzero_positions = which(deg_dist != 0)
deg_dist = deg_dist[nonzero_positions]
degrees = degrees[nonzero_positions]
reg = lm(log(deg_dist) ~ log(degrees))
cozf = coef(reg)
curve(power_law_fit, col = "red", add = T, n = length(degree(g)))

# total mean squared error
mean(reg$residuals^2)

# average degree
sum(degree(g))/length(V(g))