# Q3

library('igraph')

g <- read.graph('facebook_combined.txt')

# core nodes : neighbourhood count > 200
core_nodes = c()
for (i in 1:length(V(g)))
{
  if(neighborhood.size(g,1,i) > 200)
  {
    core_nodes <- c(core_nodes,i)
  }
}

# number of core nodes
length(core_nodes)

# average degree of core nodes
sum = 0
for (i in 1:length(core_nodes))
{
  sum = sum + degree(g,core_nodes[i])
}
sum/length(core_nodes)

# community structure of the personal network of this randomly selected core node
rand_node <- sample(core_nodes,1)
personal_network <- induced.subgraph(g,as.numeric(unlist(neighborhood(g,1,rand_node))))
plot(personal_network)

# using edge.betweenness.community
comm_EB <- edge.betweenness.community(personal_network)
V(personal_network)$color <- comm_EB$membership+1
plot(personal_network)

# using fastgreedy.community
comm_FG <- fastgreedy.community(as.undirected(personal_network))
V(personal_network)$color <- comm_FG$membership+1
plot(personal_network)

# using infomap.community
comm_IM <- infomap.community(personal_network)
V(personal_network)$color <- comm_IM$membership+1
plot(personal_network)

# Q4

# remove the core node
coreless_personal_network <- delete.vertices(personal_network, which.max(degree(personal_network)))
plot(coreless_personal_network)

# community structure using edge.betweenness.community
comm_EB <- edge.betweenness.community(coreless_personal_network)
V(coreless_personal_network)$color <- comm_EB$membership+1
plot(coreless_personal_network)

# community structure using fastgreedy.community
comm_FG <- fastgreedy.community(as.undirected(coreless_personal_network))
V(coreless_personal_network)$color <- comm_FG$membership+1
plot(coreless_personal_network)

# community structure using infomap.community
comm_IM <- infomap.community(coreless_personal_network)
V(coreless_personal_network)$color <- comm_IM$membership+1
plot(coreless_personal_network)
