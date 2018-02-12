\name{RobustScores}
\alias{RobustScores}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Compute the Robust IAT scores
}
\description{
This is the main function of the package. It allows to compute many variants of the robust IAT scores all with a single command.
}
\usage{
RobustScores(IATdata,
P1 = c("none", "fxtrim", "fxwins", "trim10", "wins10", "inve10"),
P2 = c("ignore", "exclude", "recode", "separate", "recode600"),
P3 = c("dscore", "gscore", "wpr90", "minid", "minid_t10", "minid_w10",
"minid_i10"),
P4 = c("nodist", "dist"), maxMemory = 1000,
verbose = TRUE,
autoremove = TRUE)
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
  \item{P1}{(Vector of strings). Determines how the latencies are treated for computing the scores. Can include one or more of the following strings.
    \enumerate{
      \item \code{"none"}: Do nothing.
      \item \code{"fxtrim"}: Trim values < 400ms
      \item{"fxwins"}: Values < 300ms assume the value 300ms and values > 3000ms assume the value 3000ms
      \item \code{"trim10"}: 10\% trimming
      \item \code{"wins10"}: 10\% winsorizing
      \item \code{"inve10"}: 10\% inverse trimming (i.e., trim central values)
  }
}
  \item{P2}{(Vector of strings). Determines how the error latencies are treated. Can include one or more of the following strings.
  \enumerate{
    \item \code{"ignore"}: Disregard the correct-error distinction, treat all the latencies as if they were correct latencies.
    \item \code{"exclude"}: Remove error latencies and consider only the correct ones.
    \item \code{"recode"}: Recode the error latencies with the M+2SD of correct latencies. In the computation of the M and of the SD, all correct latencies are considered that are < 10s.
    \item \code{"separate"}: Apply parameter P1 separately for correct and error latencies. Notice that for parameter 1 equal to "none", "fxtrim", and "fxwins", if P4 = "ignore" and P4 = "separate", the result is the same.)
    \item \code{"recode600"}: Recode the error latencies with the the mean of correct latencies + 600ms. In the computation of the Mean, all correct latencies are considered that are < 10s.
        }
}
  \item{P3}{The algorithm for computing the Dscores. Can include one or more of the following strings.
  \enumerate{
  \item \code{"dscore"}. Compute the Dscores as M pair2 - Mpair1 / pooled SD.
  \item \code{"gscore"}. Compute the Gscores, as shown in Nosek, Bar-Anan, Sriram, & Greenwald (2013).
  \item \code{"wpr90"}. Compute the scores based on the worst-performance-rule, which are the same as the Dscores, but instead of the mean, the 90th percentile is used in the numerator.
  \item \code{minid}. Compute the minidifferences, i.e., the differences between any latency in pair2 and any latency in pair1. Then compute the IAT scores as the Mean of the minidifferences, divided by their SD.
  \item \code{minid_t10}. Compute the 10\% trimmed minidifferences, which are identical to the mididiffernces, but instead of the mean, the 10\% trimmed mean is used.
  \item \code{"minid_w10"} Compute the 10\% winsorized minidifferences, which are as the minidifferences, but instead of the mean, the 10\% winsorized mean is used.
  \item \code{"minid_i10"} Compute the 10\% inverse_trimmed minidifferences, which are as the minidifferences, but instead of the mean, the 10\% inverse trimmed mean is used.
  }
}
  \item{P4}{Distinguish the practice and the critical blocks, as specified by column \code{praccrit} in the \code{IATdata}, or do not.
  \enumerate{
  \item \code{"nodist"} no distinction between practice and critical blocks. no distinction is made between practice and critical blocks and the IAT scores are computed using all trials together.
  \item \code{"dist"} compute the IAT scores as the average IAT score computed. the scores are computed on practice and critical blocks separately: the total score is then computedc as the average of the two IAT scores.
  }
}
  \item{maxMemory}{
In computing the minidifferences, a very large dataframe is required. \code{maxMemory} specifies the maximum size of this dataframe, in MB. This limit is respected by "slicing" the dataset and computing the scores separately for many subsets of participants. This can slow the computation a bit, but prevents RAM overflows.
}
  \item{verbose}{if \code{TRUE}, Print the time at which several operations are performed.
}
\item{autoremove}{if \code{TRUE} (the default), participants with less than 3 correct responses with latency between 400ms and 10s in each block are excluded from the analyses. Disabling this option can result in computing some variants of IAT scores on too few trials and it can lead to errors and missing values. Change this parameter to \code{FALSE} only if you know what you are doing.
}

}
\details{
The procedure for computing the scores is the following.
\enumerate{
\item First parameter P4 is applied: for \code{"nodist"} the whole dataset is given as input, for \code{"dist"} the dataset is first split in two parts according to column \code{praccrit} and then given in input.
\item Second, the parameter P1 and P2 are applied: correct and error latencies are treated for each combinations of P1 and P2 and a new column is internally created.
\item Third, parameter P3 is applied. On each and every vector of latencies defined by a combination of P1 and P2, the IAT scores are computed using all the methods specified in P3.
\item Finally, for P4 = \code{"dist"}, the scores computed i the practice and critical blocks are averaged.
}
}
\value{A dataframe with as many columns as subjects, and as many rows as the possible combinations of the parameters P1, P2, P3 and P4.
\item{subject}{The identifier of the participant}.
\item{p1342}{The IAT scores. Each number after the p indicates the value of the parameter corresponding to the position. For instance \code{p1342} indicates that parameter P1 has value 1 (i.e. \code{"none"}), parameter P2 has value 3, i.e., \code{recode}, parameter P3 has value 4 (i.e., \code{"minid"}) and parameter P4 has value 2 (i.e. \code{"dist"}). This naming convention was adopted to allow to immediately and precisely know what has been done by reading the name of the score.}
\item{...}{other columns in the form \code{pxxxx}.}
}

\references{
Greenwald, A. G., Nosek, B. A., & Banaji, M. R. (2003). Understanding and using the Implicit Association Test: I. An improved scoring algorithm. Journal of Personality and Social Psychology, 85(2), 197-216. doi:10.1037/0022-3514.85.2.197 \cr \cr
Nosek, B. A., Bar-Anan, Y., Sriram, N., & Greenwald, A. G. (2013). Understanding and Using the Brief Implicit Association Test: I. Recommended Scoring Procedures. SSRN Electronic Journal. doi:10.2139/ssrn.2196002 \cr \cr
Richetin, J., Costantini, G., Perugini, M., Schonbrodt, F. (in press). Should we stop looking for a better scoring algorithm for handling Implicit Association Test data? Test of the role of errors, extreme latencies treatment, scoring formula, and practice trials on reliability and validity. PLOS ONE.
}
\author{
Giulio Costantini
}

\seealso{
\code{\link{SplitHalf}}, \code{\link{alg2param}}
}
