\name{Tgraph}
\alias{Tgraph}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Layout \code{\link{qgraph}} for multiple comparisons by package \code{nparcomp}
}
\description{
Implements the T-graph layout proposed by Vasilescu et al. (2014), using the robust nonparametric contrasts proposed by Konietschke et al. (2012).
}
\usage{
Tgraph(mcmp, alpha = 0.05, horizorder = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mcmp}{
The output of a robust post-hoc, as obtained with function \code{mcmp} from package  \code{nparcomp}}
  \item{alpha}{The alpha level, by convention = .05. Effects with p.values lower than \code{alpha} are represented as arrows in the network layout.}
  \item{horizorder}{Optional, vector of strings. While the vertical order of the variables in the Tgraph is determined by the multiple comparisons, the horizontal ordering is not. If specified, parameter horizorder allows to determine the horizontal order. It must be a vector with the names of the variables in the preferred horizontal order.}

}
\details{
A T-graph is a simple graphical representation of a series of pairwise comparison proposed by Vasilescu et al. (2014). The nodes of the graph represent the levels of the factor, the arrows represent their pairwise comparisons. An arrow points from one option to another if the dependent variable is significantly higher for the first level compared to the second level of the factor. The robust contrasts defined by Konietschke et al. (2012) have the transitive property, therefore if an option X outperforms another option Y and Y outperforms Z, this implies that X outperforms Z. For sake of a clear graphical representation we followed Vasilescu et al. and omitted the direct edges when two nodes could be connected using an indirect path travelling through other nodes.}
\value{
\item{wmat}{The weights matrix, for each pair of options the weights represent the value of the estimated relative effect, see \code{mcmp}. A value is present in \code{wmat} only if the associated p.value is less than \code{alpha} and it is zero otherwise.}
\item{amat}{The adjacency matrix, for each pari of options, it has value 1 if an edge is present in \code{wmat} and 0 otherwise. This should be given as the main \code{input} to \code{link{qgraph}}}
\item{layout}{The layout to give in input to qgraph's parameter \code{layout}}

}
\references{
Epskamp, S., Cramer, A. O. J., Waldorp, L. J., Schmittmann, V. D., & Borsboom, D. (2012). qgraph: network visualizations of relationships in psychometric data. Journal of Statistical Software, 48(4).

Konietschke, F., Hothorn, L. a., & Brunner, E. (2012). Rank-based multiple test procedures and simultaneous confidence intervals. Electronic Journal of Statistics, 6, 738-759. doi:10.1214/12-EJS691

Vasilescu, B., Serebrenik, A., Goeminne, M., & Mens, T. (2014). On the variation and specialisation of workload-A case study of the Gnome ecosystem community. Empirical Software Engineering, 19, 955-1008. doi:10.1007/s10664-013-9244-1

Richetin, J., Costantini, G., Perugini, M., Schonbrodt, F. (in press). Should we stop looking for a better scoring algorithm for handling Implicit Association Test data? Test of the role of errors, extreme latencies treatment, scoring formula, and practice trials on reliability and validity. PLOS ONE.
}
\author{
Giulio Costantini}

\examples{
library(nparcomp)
library(qgraph)

dat <- data.frame(matrix(nrow = 300, ncol = 0))

dat$DV <- c(rnorm(100, 1, 1),
       rnorm(100, 0, 1),
       rnorm(100, 0, 1))

dat$IV <- c(rep("A", 100),
        rep("B", 100),
        rep("D", 100))

mcmp <- mctp(formula = DV~IV, data = dat, type = "Tukey")
tg <- Tgraph(mcmp)
qgraph(tg$amat, layout = tg$layout)

tg2 <- Tgraph(mcmp,  horizorder = c("A", "D", "B"))
qgraph(tg2$amat, layout = tg2$layout)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{multiple comparisons}
\keyword{Tgraph}% __ONLY ONE__ keyword per line
