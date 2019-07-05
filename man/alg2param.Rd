\name{alg2param}
\alias{alg2param}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert the algorithm names to the generating parameters
}
\description{
Starting from the algorithm names, gives the parameters that generated each algorithm as output.
}
\usage{
alg2param(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{The name of an algorithm (string) or the name of many algorithms (vector of strings).
}
}
\details{
The algorithm names in this package follow a precise convention and are in the form \code{"pxxxx"}, (where each \code{x} stands for a numbers). The first number corresponds to the value of the parameter \code{P1} in RobustScores, the second number corresponds to the value of \code{P2} and so on. This function allows to know the values of the parameters that generated an algorithm from the algorithm's name. Also a vector of algorithm's names can be given as input.
}
\value{
A dataframe with four columns.
\item{algorithm}{(string). The algorithm's name given as input}
\item{P1}{(string). Parameter P1, see \code{\link{RobustScores}}}
\item{P2}{(string). Parameter P2, see \code{\link{RobustScores}}}
\item{P3}{(string). Parameter P3, see \code{\link{RobustScores}}}
\item{P4}{(string). Parameter P4, see \code{\link{RobustScores}}}
}
\author{
Giulio Costantini}

\examples{
alg2param("p1231")
}

