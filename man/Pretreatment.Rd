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

\value{a dataframe with the following columns:

\item{subject}{Univocally identifies a participant.}
\item{correct}{(logical). has value TRUE or 1 if the trial was answered correctly, FALSE or 0 otherwise.}
\item{latency}{(numeric). Response latency.}
\item{blockcode}{(factor or string). Can assume only two values, \code{"pair1"} and \code{"pair2"}. \code{"pair1"} is for compatible block and \code{"pair2"} is for incompatible (or vice versa).}
\item{praccrit}{(factor, optional). Can assume only two values, \code{"prac"} is for practice combined categorization block and \code{"crit"} is for critical combined categorization block. In a IAT with 60 trials for each double categorization block, the first 20 are sometimes administered as practice block, the other 40 as critical.}
\item{trialcode}{(factor, optional). Code for the trial, has value \code{"left"} if the correct response required to press the left button, \code{"right"} if it required to press the right button.}
\item{stimulus}{(character, optional). The stimulus item.}
}
\author{
Giulio Costantini
}