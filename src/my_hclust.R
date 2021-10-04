#' my_hclusters
#' @param data_used
#' @param clusters
#' @param KMAX
#' @return a matrix of 
#' @export

my_hclusters = function(data_used, clusters, KMAX){
  max_data_value = max(data_used)
  min_data_value = min(data_used)
 
  # 	Generate 20 random matrices
  rand_matrices = list()
  matrices_needed = 20
  for (i in 1:matrices_needed) {
    matrix_holder = as.matrix(
      runif(nrow(data_used)*ncol(data_used), 
            min=  min(data_used), 
            max =  max(data_used))
    )
    rand_matrices[[i]] = matrix(
      unlist(t(matrix_holder)),
      byrow=T, 
      nrow(data_used), 
      ncol(data_used)
    )
  }
  #	Compute kmeans for 1 to KMAX clusters, for each of the 21 data sets.
  simulated_kmean_list = list()
  for (matrix_ran in 1:matrices_needed) {
    for (clusters in 1:KMAX) {
      km_matrix = kmeans(rand_matrices[[matrix_ran]], clusters)
      km_matrix_row = data.table(
        martix_num = matrix_ran, 
        tot_ss = km_matrix$tot.withinss, 
        set = "random", 
        clusters= clusters
      )
      simulated_kmean_list = rbind(simulated_kmean_list,km_matrix_row)
    }
  }
  # make a row with the number of clusters, average tot_ss, set
  av_ran_ss_list = list()
  for (clu in 1:KMAX) {
    all_clusters_of_num =as.data.frame(simulated_kmean_list[clusters == clu])
    point_mean = mean(all_clusters_of_num[,"tot_ss"])
    ran_ss = data.table(cluster_num = clu, tot_ss= point_mean, set = "random" )
    av_ran_ss_list = rbind(av_ran_ss_list, ran_ss)
  }
  real_ss = list()
  for (clus in 1:KMAX) {
    real_kmean = kmeans(data_used,clus)
    real_k_row = data.table(cluster_num = clus, tot_ss= real_kmean$tot.withinss, set = "real" )
    real_ss = rbind(real_ss, real_k_row)
  }
  
  kmeans_validation = rbind(real_ss, av_ran_ss_list)
  ggplot(kmeans_validation, aes(x= cluster_num, y = tot_ss, color = set))+
    geom_line()+
    scale_y_continuous(trans = 'log')+
    labs(title = " Sum of Squares for zip data vs random data")
  
  gap_list = list()
  for (clusto in 1:KMAX) {
    dif = av_ran_ss_list[clusto, "tot_ss"] - real_ss[clusto,"tot_ss"]
    dif_row = data.table(clusters = clusto, tot_ss = dif$tot_ss)
    gap_list = rbind(gap_list, dif_row)
  }
  ggplot(gap_list, aes(x= clusters, y= tot_ss ))+
    geom_line(color = "blue", size = 1)+ labs(title = 
                                                "gap statistic with error for Iris data")+
    geom_ribbon(aes(ymax= tot_ss*1.5, ymin = tot_ss*.5), 
                alpha = .5)
  return(kmeans_validation)
}
