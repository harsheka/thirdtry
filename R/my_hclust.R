#' my_hclusters
#' @param data_input
#' @param clusters_desired
#' @return identity_vec a vector of clusters that each point belongs to
#' @export

my_hclusters= function (data_input, cluster_desired){
  
  # assign each point to its own cluster
  identity_vec = 1:nrow(data_input)
  working_data = cbind(data_input,identity_vec)
  # identify clusters available for merging ?
  cluster_count = nrow(data_input)
  
  # identify two most similar clusters to merge
  ##dist_measure = dist(data, method = "euclidean")
  dist_measure_mat = as.matrix(dist(data_input, method = "euclidean"))
  dist_measure = as.data.frame(dist_measure_mat)
  dist_measure[upper.tri(dist_measure)]=NA
  dist_meas_diag = dist_measure
  #str(dist_meas_diag)
  diag(dist_meas_diag) = NA
  dist_meas_diag = as.matrix(dist_meas_diag)
  # Loop
  while (cluster_count > cluster_desired) {
    min_loc =arrayInd(which.min(dist_meas_diag),dim(dist_meas_diag)) # location of min dist
    # max_min_loc= max(min_loc[1],min_loc[2])
    
    # create new cluster
    clust_row = dist_meas_diag[min_loc[2],]
    clust_col = dist_meas_diag[,min_loc[2]]
    
    for (i in 1:min_loc[1]) {
      #identify longer element
      clust_row[i] = min(dist_meas_diag[min_loc[1], i], 
                         dist_meas_diag[min_loc[2],i])
      # identify shorter element
    }
    for (i in ncol(dist_meas_diag):min_loc[1]) {
      clust_col[i] = min(dist_meas_diag[i, min_loc[1]], 
                         dist_meas_diag[i, min_loc[2]])
    }
    
    for (i in 1:ncol(dist_meas_diag)) {
      if (identity_vec[i] == min_loc[1]){
        identity_vec[i] = min_loc[2]
      }
    }
    # remove points from working data
    dist_meas_diag[min_loc[1],]= NA
    dist_meas_diag[, min_loc[1]]= NA
    dist_meas_diag[min_loc[2],]= clust_row 
    dist_meas_diag[, min_loc[2]]= clust_col
    # create cluster location for method = means
    # update all points in the cluster to have the same id
    # remove old cluster data
    # remove merged point/cluster
    # update distance matrix
    # if cluster number == clust_num -> fin
    cluster_count= cluster_count-1
  }
  return(identity_vec)   
}
