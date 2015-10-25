# Q5

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

# personal network
rand_node <- sample(core_nodes,1)
personal_network <- induced.subgraph(g,as.numeric(unlist(neighborhood(g,1,rand_node))))

# embeddedness of all nodes in the personal network
coreless_personal_network <- delete.vertices(personal_network, which.max(degree(personal_network)))
neigh <- c()
for (i in 1:length(V(coreless_personal_network)))
{
  neigh[i] <- neighborhood(coreless_personal_network,1,i)
}
neigh_count <- c()
for (i in 1:length(V(coreless_personal_network)))
{
  # embeddedness of node i
  neigh_count[i] <- length(as.numeric(unlist(neigh[i])))-1 
}

# dispersion of all nodes in the personal network

# 1. the neighborhood lists for each of the nodes --> neigh
# 2. pair vertices in every list in neigh
# 3. find length of shortest path between each pair
# 4. add all length to get dispersion value

dispersion_list <- c()
n = length(V(coreless_personal_network))
for (l in 1:n)
{
  temp_core_less_personal_network <- delete.vertices(coreless_personal_network, l) 
  temp_pairs_list <- neigh[[l]]
  temp_pairs_list <- temp_pairs_list[2:length(temp_pairs_list)]
  
  dispersion <- 0
  for(i in 1:length(temp_pairs_list))
  { 
    for(j in 1:length(temp_pairs_list)) # since temp_core_less_network id directed
    {
      if(temp_pairs_list[i] != n && temp_pairs_list[j] != n)
      {
        dispersion <- dispersion + length(as.numeric(unlist(get.shortest.paths(temp_core_less_personal_network, temp_pairs_list[i], temp_pairs_list[j]))))
      }
    }
    
  }
  dispersion_list <- c(dispersion_list, dispersion)
}

