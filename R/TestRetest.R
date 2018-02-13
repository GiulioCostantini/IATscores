TestRetest <- function(IATdata, ...)
{
  
  sess <- unique(IATdata$session)
  test <- RobustScores(IATdata = filter(IATdata, session == sess[1]), ...)
  retest <- RobustScores(IATdata = filter(IATdata, session == sess[2]), ...)
  
  # compute the test-retest correlations
  testretest <-
    data.frame(matrix(ncol=2, nrow = 0,
                      dimnames = list(c(), c("algorithm", "testretest"))))
  algos <- names(test)[names(test) != "subject"]
  
  for(i in 1:length(algos))
  {
    splitdata <- left_join(test[,c("subject", algos[i])],
                           retest[,c("subject", algos[i])], by = "subject")
    
    # correlation
    splitcor <- cor(select(splitdata, -subject),
                    use = "pairwise.complete.obs")[1,2]
    
    testretest[i, "testretest"] <- splitcor
    testretest[i, "algorithm"] <- algos[i]
  }
 
  testretest
}



# D2 scores
TestRetest.D2 <- function(IATdata, ...) TestRetest(IATdata,
                                                 P1 = "fxtrim",
                                                 P2 = "ignore",
                                                 P3 = "dscore",
                                                 P4 = "dist", ...)

# D5 scores
TestRetest.D5 <- function(IATdata, ...) TestRetest(IATdata,
                                                 P1 = "fxtrim",
                                                 P2 = "recode",
                                                 P3 = "dscore",
                                                 P4 = "dist", ...)

# D6 scores
TestRetest.D6 <- function(IATdata, ...) TestRetest(IATdata,
                                                 P1 = "fxtrim",
                                                 P2 = "recode600",
                                                 P3 = "dscore",
                                                 P4 = "dist", ...)


# D2SWND scores
TestRetest.D2SWND <- function(IATdata, ...) TestRetest(IATdata,
                                                     P1 = "wins10",
                                                     P2 = "ignore",
                                                     P3 = "dscore",
                                                     P4 = "nodist", ...)

# D5SWND scores
TestRetest.D5SWND <- function(IATdata, ...) TestRetest(IATdata,
                                                     P1 = "wins10",
                                                     P2 = "recode",
                                                     P3 = "dscore",
                                                     P4 = "nodist", ...)

# D6SWND scores
TestRetest.D6SWND <- function(IATdata,...) TestRetest(IATdata,
                                                    P1 = "wins10",
                                                    P2 = "recode600",
                                                    P3 = "dscore",
                                                    P4 = "nodist", ...)



