# Q2

library(igraph)

# read the Facebook graph edgelist file
g <- read.graph('facebook_combined.txt', format = "edgelist")

# 1-neighborhood of node 1
personal_network <- as.numeric(unlist(neighborhood(g, 1 ,1)))

# create a sub graph 
personal_network <- induced.subgraph(g, personal_network)

# number of nodes
length(V(personal_network))

# number of edges
length(E(personal_network))

# draw this sub graph
