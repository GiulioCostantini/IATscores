\name{IATdescriptives}
\alias{IATdescriptives}

\title{
Summary statistics of reaction time and error
}
\description{
Provides several summary statistics for reaction times and errors, by subject and by block. If by block, only two critical blocks, pair1 and pair2, are considered. See function \code{Pretreatment}).
}
\usage{
IATdescriptives(IATdata, byblock = FALSE)
}
\arguments{
  \item{IATdata}{
a dataframe with the following columns:
  \itemize{
    \item \code{subject}: (factor or coercible to factor). Univocally identifies a participant.
    \item \code{correct}: (logical). has value \code{TRUE} or \code{1} if the trial was answered correctly, \code{FALSE} or \code{0} otherwise.
    \item \code{latency}: (numeric). Response latency, in ms. 
    \item \code{blockcode}: (factor or string). Can assume only two values, \code{"pair1"} and \code{"pair2"}. \code{"pair1"} is for one critical block and \code{"pair2"} is the other critical block.
    \item \code{praccrit}. (factor, optional). Can assume only two values, \code{"prac"} is for practice combined categorization block and \code{"crit"} is for critical combined categorization block. In a IAT with 60 trials for each double categorization block, the first 20 are sometimes administered as practice block, the other 40 as critical.
  }

}
  \item{byblock}{
If \code{TRUE}, summary statistics are returned separately for the two critical blocks, pair1 and pair2}
}
\details{
These summary statistics are used sometimes to define exclusion criteria. For example, Greenwald, Nosek, & Banaji's (2003) improved algorithm suggests to eliminate subjects for whom more than 10 percent trials have latency less than 300ms.
}
\value{
\item{Ntrials}{number of trials}
\item{Nmissing_latency}{number of trials in which latency information is missing}
\item{Nmissing_accuracy}{number of trials in which accuracy information is missing}
\item{Prop_error}{proportion of error trials}
\item{M_latency}{mean latency}
\item{SD_latency}{SD of latency}
\item{min_latency}{minimum value of latency}
\item{max_latency}{maximum value of latency}
\item{Prop_latency300}{proportion of latencies faster than 300 ms}
\item{Prop_latency400}{proportion of latencies faster than 400 ms}
\item{Prop_latency10s}{proportion of latencies slower than 10 seconds}
}
\references{
Greenwald, A. G., Nosek, B. A., & Banaji, M. R. (2003). Understanding and using the Implicit Association Test: I. An improved scoring algorithm. Journal of Personality and Social Psychology, 85(2), 197-216. doi:10.1037/0022-3514.85.2.197 \cr \cr
}
\author{
Giulio Costantini}
\seealso{
\code{\link{Pretreatment}}
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
IATdescriptives(IATdata)
}
