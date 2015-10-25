# Q7

library(igraph)

#setwd("gplus/")
file_list = list.files()

# total number of files = 792
# number of files/user = 6
# total number of users = 792/6 = 132
# files for: 1)circles 2)edges 3)egofeat 4)feat 5)featnames 6)followers
f = 1
while (f <= length(file_list))
{
  ego_node_index = as.character(unlist(strsplit(file_list[f], "[.]"))[1])
  
  # read circles
  Circles = read.csv(file_list[f], header=FALSE, sep="\t")
  
  # check whether this user has more than 2 circles
  if (nrow(Circles) > 2)
  {
    f = f + 1
    
    # read edges and get the personal network
    personal_network <- read.graph(file_list[f], format="ncol", directed=TRUE, names=TRUE)
    ego_edges_list <- c()
    for (v in 1:length(V(personal_network)))
    {
      ego_edges_list <- c(ego_edges_list, V(personal_network)[v]$name, ego_node_index)
    }
    
    personal_network <- add.vertices(personal_network, 1, name = ego_node_index)
    personal_network <- add.edges(personal_network, ego_edges_list)
    
    # community structure using Walktrap
    comm_WT <- walktrap.community(personal_network)
    
    # community structure using Infomap 
    comm_IM <- infomap.community(personal_network)
    
    # show how communities from comm_WT overlap with the user's circles
    for (r in 1:nrow(Circles))
    {
      nodes_list_from_circles <- c(Circles[r,])
      #cat(sprintf("%s \t", nodes_list_from_circles[1]))
      nodes_list_from_circles <- nodes_list_from_circles[-1]
      for (c in 1:max(comm_WT$membership))
      {
        member_nodes <- as.character(list(V(personal_network)[which(comm_WT$membership == c)]$name))
        cat(length(intersect(nodes_list_from_circles, member_nodes)), "\t")
      }
      cat("\n")
    }
    cat("\n\n\n")

    
    f = f + 5
  }
  else
  {
    f = f + 6
  }
}

