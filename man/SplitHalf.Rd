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
\author{
Giulio Costantini
}