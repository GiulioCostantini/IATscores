# rawIATdata <- data.frame(
#   # ID of each participant (N = 10)
#   ID = rep(1:10, each = 180),
#   # seven-block structure, as in Greenwald, Nosek & Banaji (2003)
#   # block 1 = target discrimination (e.g., Bush vs. Gore items)
#   # block 2 = attribute discrimination (e.g., Pleasant words vs. unpleasant)
#   # block 3 = combined practice (e.g., Bush + pleasant vs. Gore + unpleasant)
#   # block 4 = combined critical  (e.g., Bush + pleasant vs. Gore + unpleasant)
#   # block 5 = reversed target discrimination (e.g., Gore vs. Bush)
#   # block 6 = reversed combined practice (e.g., Gore + pleasant vs. Bush + unpleasant)
#   # block 7 = reversed combined critical (e.g., Gore + pleasant vs. Bush + unpleasant)
#   block = rep(c(rep(1:3, each = 20),
#                 rep(4, 40),
#                 rep(5:6, each = 20),
#                 rep(7, 40)), 10),
#   # expected proportion of errors = 10 percent
#   correct = sample(c(0, 1), size = 1800, replace = TRUE, prob = c(.2, .8)),
#   # reaction times are generated from a mix of two chi2 distributions,
#   # one centered on 550ms and one on 100ms to simulate fast latencies
#   latency = round(sample(c(rchisq(1500, df = 1, ncp = 550),
#                            rchisq(300, df = 1, ncp = 100)), 1800)))
# 
# # add some IAT effect by making trials longer in block 6 and 7
# rawIATdata[rawIATdata$block >= 6, "latency"] <-
#   rawIATdata[rawIATdata$block >= 6, "latency"] + 100
# 
# # add some more effect for subjects 1 to 5
# rawIATdata[rawIATdata$block >= 6 &
#              rawIATdata$ID <= 5, "latency"] <-
#   rawIATdata[rawIATdata$block >= 6 &
#                rawIATdata$ID <= 5, "latency"] + 100
# 
# #### pretreat IAT data using function Pretreatment ####
# IATdata <- Pretreatment(rawIATdata,
#                         label_subject = "ID",
#                         label_latency = "latency",
#                         label_accuracy = "correct",
#                         label_block = "block",
#                         block_pair1 = c(3, 4),
#                         block_pair2 = c(6, 7),
#                         label_praccrit = "block",
#                         block_prac = c(3, 6),
#                         block_crit = c(4, 7))


IATdescriptives <- function(IATdata, byblock = FALSE)
{
  if(!byblock)
  {
  group_by(IATdata, subject) %>%
    summarize(
      N_trials = n(),
      Nmissing_latency = sum(is.na(latency)),
      Nmissing_accuracy = sum(is.na(correct)),
      Prop_error = mean(!correct, na.rm = TRUE),
      M_latency = mean(latency, na.rm = TRUE),
      SD_latency = sd(latency, na.rm = TRUE),
      min_latency = min(latency, na.rm = TRUE),
      max_latency = max(latency, na.rm = TRUE),
      Prop_latency300 = mean(latency < 400, na.rm = TRUE),
      Prop_latency400 = mean(latency < 300, na.rm = TRUE),
      Prop_latency10s = mean(latency > 10000, na.rm = TRUE)
    )
  } else 
  {
    group_by(IATdata, subject, blockcode) %>%
      summarize(
        N_trials = n(),
        Nmissing_latency = sum(is.na(latency)),
        Nmissing_accuracy = sum(is.na(correct)),
        Prop_error = mean(!correct, na.rm = TRUE),
        M_latency = mean(latency, na.rm = TRUE),
        SD_latency = sd(latency, na.rm = TRUE),
        min_latency = min(latency, na.rm = TRUE),
        max_latency = max(latency, na.rm = TRUE),
        Prop_latency300 = mean(latency < 400, na.rm = TRUE),
        Prop_latency400 = mean(latency < 300, na.rm = TRUE),
        Prop_latency10s = mean(latency > 10000, na.rm = TRUE)
      )
  }
}

