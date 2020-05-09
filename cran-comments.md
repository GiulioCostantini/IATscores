## Test environments
* local windows 10, R 4.0.0
* Win builder (with devtools::check_win_devel)
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit (R-hub builder)
* Fedora Linux, R-devel, clang, gfortran (R-hub builder)
* Ubuntu Linux 16.04 LTS, R-release, GCC (R-hub builder)
* Debian Linux, R-devel, GCC (R-hub builder)

## R CMD check results

In the local system, Win builder and Fedora I got no errors, warnings or notes

* In Ubuntu and Debian I got PREPERROR. The problem seems to be that the r-hub linux servers still have R 3.6.1 whereas my package requires R >= 4.0.0. 
"ERROR: this R is version 3.6.1, package 'IATscores' requires R >= 4.0.0"
This seems a problem of the r-hub server, so I proceeded with CRAN submission.
(output here: https://builder.r-hub.io/status/IATscores_0.2.7.tar.gz-486e0427154c41499ee4c424ea599fbf)

* In Windows Server 2008 R2 SP1, R-devel, 32/64 bit (R-hub builder)
I got an error: 

"checking whether package 'IATscores' can be installed ... ERROR
Installation failed.
See 'C:/Users/USERIceTxnFwMg/IATscores.Rcheck/00install.out' for details."

The HTML report 
https://builder.r-hub.io/status/IATscores_0.2.7.tar.gz-620c6b5776bc4cc9979225a66c3d86c4
shows that the error seems to be in the lack of package data.table, which
is however seems to be working elsewhere
https://cran.r-project.org/web/packages/data.table/index.html


 847#> Error in loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]]) :
 848#> there is no package called 'data.table'
 849#> Calls: ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
 850#> Execution halted
 851#> ERROR: lazy loading failed for package 'IATscores'
 852#> * removing 'C:/Users/USERIceTxnFwMg/R/IATscores'



## Downstream dependencies
There are no downstream dependencies for package IATscores