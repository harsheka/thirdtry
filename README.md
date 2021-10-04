# thirdtry
Installation:
remotes::install_github(“username/repo”)

Usage: 
shows a few lines of R code about how to use your package (can be same as examples).

thirdtry::my_hclusters(iris[ ,1:4],4)
  [1]   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
 [23]   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
 [45]   1   1   1   1   1   1  51  51  51  51  51  51  51  58  51  51  58  51  51  51  51  51
 [67]  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51
 [89]  51  51  51  51  51  58  51  51  51  51  58  51  51  51  51  51  51 106  51  51  51  51
[111]  51  51  51  51  51  51  51 106 106  51  51  51 106  51  51  51  51  51  51  51  51 106
[133]  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51  51

thirdtry::my_kmeans_cpp(iris[ ,1:4],4)
