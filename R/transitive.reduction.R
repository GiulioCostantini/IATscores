# function borrowed from package 'nem', since the installation of 
# nem from bioconductor proved problematic
transitive.reduction <- function (g) 
{
  if (!(class(g) %in% c("matrix", "graphNEL"))) 
    stop("Input must be an adjacency matrix or graphNEL object")
  if (class(g) == "graphNEL") {
    g = as(g, "matrix")
  }
  g = nem::transitive.closure(g, mat = TRUE)
  g = g - diag(diag(g))
  type = (g > 1) * 1 - (g < 0) * 1
  for (y in 1:nrow(g)) {
    for (x in 1:nrow(g)) {
      if (g[x, y] != 0) {
        for (j in 1:nrow(g)) {
          if ((g[y, j] != 0) & sign(type[x, j]) * sign(type[x, 
                                                            y]) * sign(type[y, j]) != -1) {
            g[x, j] = 0
          }
        }
      }
    }
  }
  g
}
