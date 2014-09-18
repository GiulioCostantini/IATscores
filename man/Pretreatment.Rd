\name{Pretreatment}
\alias{Pretreatment}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Pretreat the IAT data in input.
}
\description{
  Convert the initial dataframe of the IAT in a simpler dataframe, which is the input
  of subsequent functions in this package.}
\usage{
Pretreatment(IATdata,
  label_subject = "subject",
  label_latency = "latency",
  label_accuracy = "correct",
  label_block = "blockcode",
  block_pair1 = c("pair1_left", "pair1_right"),
  block_pair2 = c("pair2_left", "pair2_right"),
  label_trial = NA,
  trial_left = NA,
  trial_right = NA,
  label_praccrit=NA,
  block_prac=NA,
  block_crit=NA,
  label_stimulus=NA)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{IATdata}{The input dataframe. I consider the the output of the IAT implemented in Inquisit (a row by trial). Only 7 columns are important for computation.\cr
  - a column with subject numbers\cr
  - a column with latencies\cr
  - a column with accuracy (1 = correct, 0 = incorrect)\cr
  - a column including the block codes, i.e. one or more strings that describe the kind of block (e.g., "compatible" vs. "incompatible")\cr
  - a column including the trial codes, i.e. one or more strings that describe the kind of trial (e.g., "response_left" vs. "response_right")\cr
  - a column including information about which are the practice and which the critical combined categorization blocks.\cr
  - a column with the original stimuli (optional)
  }
  \item{label_subject}{String. Name of the column in \code{IATdata} with the subject numbers}
  \item{label_latency}{String. Name of the column in \code{IATdata} with the latecies}
  \item{label_accuracy}{String. Name of the column in \code{IATdata} with the accuracy}
  \item{label_block}{String. Name of the column in \code{IATdata} with the block names}
  \item{block_pair1}{Vector of strings. Elements of the column indicated in \code{label_block} that correspond to the compatible block of the IAT}
  \item{block_pair2}{Vector of strings. Elements of the column indicated in \code{label_block} that correspond to the incompatible block of the IAT}
  \item{label_trial}{String (optional). Name of the column in \code{IATdata} with the trial names}
  \item{trial_left}{Vector of strings(optional). Elements of the column indicated in \code{label_trial} that correspond to trials that required to to press the left button to give the correct response.}
  \item{trial_right}{Vector of strings(optional). Elements of the column indicated in \code{label_trial} that correspond to trials that required to to press the right button to give the correct response.}
  \item{label_praccrit}{String (optional). The column in which the information about practice and critical trials is stored.}
  \item{block_prac}{Vector of strings (optional). The elements of the column indicated in \code{label_praccrit} that correspond to the practice combined blocks}
  \item{block_crit}{Vector of strings (optional). The elements of the column indicated in \code{label_praccrit} that correspond to the critical combined blocks}
  \item{label_stimulus}{(optional) The variable name in \code{IATdata} that keeps information about the stimulus presented in each trial}
}

\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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

## The function is currently defined as
function (x) 
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
