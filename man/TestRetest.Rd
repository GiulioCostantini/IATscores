\name{TestRetest}
\alias{TestRetest}
\alias{TestRetest.D2}
\alias{TestRetest.D5}
\alias{TestRetest.D6}
\alias{TestRetest.D2SWND}
\alias{TestRetest.D5SWND}
\alias{TestRetest.D6SWND}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Test-retest reliability}
\description{
Compute test-retest reliability for IAT with 2 observations for each subject
}
\usage{
TestRetest(IATdata, ...)
TestRetest.D2(IATdata, ...)
TestRetest.D5(IATdata, ...)
TestRetest.D6(IATdata, ...)
TestRetest.D2SWND(IATdata, ...)
TestRetest.D5SWND(IATdata, ...)
TestRetest.D6SWND(IATdata, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{IATdata}{
same as \code{\link{RobustScores}}, but with the additional column
\code{"session"}. \code{session} distinguishes the trials of the first session
and those of the second session. It is typically numerical, having value \code{1}
for the first session and \code{2} for the second.
Functions TestRetest.D2 etc. are wrappers that allow computing reliability for some common types of scores. See \code{\link{RobustScores}}.
}
\item{\dots}{other parameters to be passed to RobustScores}
}
\details{
It computes the scores for the test and for the retest using RobustScores, 
the output is just the correlation among the scores in the two sessions.
}
\value{
\item{algorithm}{The name of the algorithm, see \code{\link{RobustScores}} for
the convention adopted for naming the algorithms}

\item{testretest}{The test-retest reliability for each algorithm}
}
\author{
Giulio Costantini}

\seealso{
\code{\link{RobustScores}}
}
\examples{
#### generate random IAT data ####
set.seed(1234)
rawIATdata <- data.frame(
  # ID of each participant (N = 10)
  ID = rep(1:10, each = 180), 
  # seven-block structure, as in Greenwald, Nosek & Banaji (2003)
  # block 1 = target discrimination (e.g., Bush vs. Gore items)
  # block 2 = attribute discrimination (e.g., Pleasant words vs. unpleasant)
  # block 3 = combined practice (e.g., Bush + pleasant vs. Gore + unpleasant)
  # block 4 = combined critical  (e.g., Bush + pleasant vs. Gore + unpleasant)
  # block 5 = reversed target discrimination (e.g., Gore vs. Bush)
  # block 6 = reversed combined practice (e.g., Gore + pleasant vs. Bush + unpleasant)
  # block 7 = reversed combined critical (e.g., Gore + pleasant vs. Bush + unpleasant)
  block = rep(c(rep(1:3, each = 20),
                rep(4, 40),
                rep(5:6, each = 20),
                rep(7, 40)), 10),
 # expected proportion of errors = 10 percent
  correct = sample(c(0, 1), size = 1800, replace = TRUE, prob = c(.2, .8)),
  # reaction times are generated from a mix of two chi2 distributions,
  # one centered on 550ms and one on 100ms to simulate fast latencies
  latency = round(sample(c(rchisq(1500, df = 1, ncp = 550),
                           rchisq(300, df = 1, ncp = 100)), 1800)))

# add some IAT effect by making trials longer in block 6 and 7
rawIATdata[rawIATdata$block >= 6, "latency"] <- 
  rawIATdata[rawIATdata$block >= 6, "latency"] + 100
  
# add some more effect for subjects 1 to 5
rawIATdata[rawIATdata$block >= 6 &
             rawIATdata$ID <= 5, "latency"] <- 
  rawIATdata[rawIATdata$block >= 6 &
             rawIATdata$ID <= 5, "latency"] + 100
  
#### pretreat IAT data using function Pretreatment ####
IATdata <- Pretreatment(rawIATdata,
                             label_subject = "ID",
                          label_latency = "latency",
                          label_accuracy = "correct",
                          label_block = "block",
                          block_pair1 = c(3, 4),
                          block_pair2 = c(6, 7),
                          label_praccrit = "block",
                          block_prac = c(3, 6),
                          block_crit = c(4, 7))
                          
# Add a column representing the session in IATdata                    
IATdata$session <- rep(c(1,2), nrow(IATdata)/2)
                          

#### Compute reliability for Greenwald et al.'s (2003) D2, D5, and D6 ####
# All scores are computed both with the TestRetest and with
# the wrappers TestRetest.D2, TestRetest.D5, and TestRetest.D6.


# D2 scores
TestRetest.D2(IATdata, verbose = FALSE)
TestRetest(IATdata = IATdata,
             P1 = "fxtrim",
             P2 = "ignore",
             P3 = "dscore",
             P4 = "dist",
             verbose = FALSE)

# D5 scores
TestRetest.D5(IATdata,
             verbose = FALSE)
TestRetest(IATdata = IATdata,
             P1 = "fxtrim",
             P2 = "recode",
             P3 = "dscore",
             P4 = "dist",
             verbose = FALSE)

# D6 scores
TestRetest.D6(IATdata, verbose = FALSE)
TestRetest(IATdata = IATdata,
             P1 = "fxtrim",
             P2 = "recode600",
             P3 = "dscore",
             P4 = "dist",
             verbose = FALSE)

#### Compute reliability for improved scores by Richetin et al. (2015, p. 20) ####
# All scores are computed both with the TestRetest and with
# the wrappers TestRetest.D2SWND, TestRetest.D5SWND, and TestRetest.D6SWND.
# Results are identical

# D2SWND scores
TestRetest.D2SWND(IATdata, verbose = FALSE)
TestRetest(IATdata = IATdata,
             P1 = "wins10",
             P2 = "ignore",
             P3 = "dscore",
             P4 = "nodist",
             verbose = FALSE)

# D5_SWND scores
TestRetest.D5SWND(IATdata, verbose = FALSE)
TestRetest(IATdata = IATdata,
             P1 = "wins10",
             P2 = "recode",
             P3 = "dscore",
             P4 = "nodist",
             verbose = FALSE)

# D6_SWND scores
TestRetest.D6SWND(IATdata, verbose = FALSE)
TestRetest(IATdata = IATdata,
             P1 = "wins10",
             P2 = "recode600",
             P3 = "dscore",
             P4 = "nodist",
             verbose = FALSE)

}