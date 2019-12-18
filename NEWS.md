# IAT scores 0.2.4

* Changed Tgraph to comply with the new "class" definition (see https://developer.r-project.org/Blog/public/2019/11/09/when-you-think-class.-think-again/index.html)

# IAT scores 0.2.3

* New function IATdescriptives, to compute descriptive statistics for each subject

* Fixed bugs connected to Tgraph

* specified function-package associations for dplyr


# IAT scores 0.2.1

* Added several new functions, to easily implement the most common D scores

* Improved help files with examples

# IATscores 0.2.0

* Excluding participants with too few responses is now optional, implemented in option autoremove

* replaced calls to rbind_all() with bind_rows()

* Removed dependency on nem to prevent issues during installation

* bug fix when P4 = "dist". thanks to Geraldine Escriva

