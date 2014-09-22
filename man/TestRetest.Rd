\name{TestRetest}
\alias{TestRetest}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Test-retest reliability}
\description{
Compute test-retest reliability for IAT with 2 observations for each subject
}
\usage{
TestRetest(IATdata, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{IATdata}{
same as \code{\link{RobustScores}}, but with the additional column
\code{"session"}. \code{session} distinguishes the trials of the first session
and those of the second session. It is tipically numerical, having value \code{1}
for the first session and \code{2} for the second.
}
\item{\dots}{other parameters to be passed to RobustScores}
}
\details{
It computes the scores for the test and for the retest using RobustScores, 
the output is just the correlaiton among the scores in the two sessions.
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
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

}