#include <RcppArmadillo.h>
#include <ctime>
// [[Rcpp::depends(RcppArmadillo)]]
using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
NumericVector rcpp_matrix(){
  // Creating a vector object
  NumericVector v = {1,2,3,4};
  // Set the number of rows and columns to attribute dim of the vector object.
  v.attr("dim") = Dimension(2, 2);
  // Return the vector to R
  return v;
}
// [[Rcpp::export]]
arma::vec add_two(arma::vec x){
  return x + 2;
}

// [[Rcpp::export]]
arma::mat read_data(arma::mat x){ //arma::mat
  arma::mat y = x;
  arma::mat cpp_data_mat = y;
  return y;
}
/*
arma::mat my_kmeans_cpp(arma::mat data, int clusters){
  // select random points to be starting cluster centers
  int point = rand() % data.n_rows+1;
  arma::mat cluster_centers ;
  srand(time(0));
  for (int i = 0; i < clusters; i++){
    int point = rand() % data.n_rows+1;
    arma::vec cluster_row = data.row(point);
    cluster_centers = join_vert(cluster_centers, cluster_row);
  }
  // assign all points to a cluster
  arma::vec cl_assign_vec;
  for( int i = 0; i < data.n_rows+1; i++){
    arma::vec dist_and_clust_num;
    for(int j = 0; j<cluster_centers.n_rows(); j++){
      // compare the ith row of the data to the ith row of the cluster_centers
      // row number will be cluster_center
      
      
    }
    // find location of min of the dist_and_clust_centers vector
    
    // append the row num+1 to the cl_assign_vec
  }
  // column bind cl_assign_vec to data
  
  // sort out all data based on cluster assignment and find new cluster centers
}
*/

