\name{SplitHalf}
\alias{SplitHalf}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Split half reliability}
\description{
Compute split half reliability for the algorithms defined by all the
combinations of parameters P1, P2, P3, and P4.
}
\usage{
SplitHalf(IATdata, ...)
}
\arguments{
  \item{IATdata}{
same as \code{\link{RobustScores}}}
\item{\dots}{other parameters to be passed to RobustScores}

}
\details{
The split-half reliability is computed by splitting the dataframe IATdata in
two halves and then calling function \code{\link{RobustScores}}
}
\value{
A vector of split-half reliabilities.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Giulio Costantini
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
