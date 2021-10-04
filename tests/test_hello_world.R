library(testthat)
library(thirdtry)
context("test_hello_world")
set.seed(5)

test_that("My_hclust finds the correct number of clusters",
          {cluster_numbers = unique(my_hclusters(iris[,1:4],5))
            num_of_clust_found = length(cluster_numbers)
            is_error = num_of_clust_found != 5
            expect_equal(sum(is_error),0)
          }
          )
