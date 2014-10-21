D6 <- function(dfr)
{
  # dfr is a dataframe including at least the following columns
  # "subject" --> numeric, subject number
  # "latency" --> numeric, the latency
  # "block"   --> string ("pair1" vs. "pair2")
  # "correct" --> numeric binary (0 = wrong, 1 = correct)
  
  # 1. exclude latencies >10000 and latencies < 400ms
  dfr <- dfr[dfr$latency <= 10000 & dfr$latency >= 400 &! is.na(dfr$latency),]
  
  dfr$latencyD6 <- dfr$latency
  dfr$latencyD6correct <- dfr$latency
  
  # 2. recode errors with the mean of correct + 600 ms
  dfr[dfr$correct == 0, "latencyD6correct"] <- NA
  Mcorrect <- tapply(dfr$latencyD6correct, list(dfr$subject, dfr$block),
                     mean, na.rm = TRUE)
  colnames(Mcorrect) <- c("Mpair1_correct", "Mpair2_correct")
  dfr <- merge(dfr, Mcorrect, by.x = "subject", by.y = 0)
  
  dfr[dfr$correct == 0 & dfr$block == "pair1", "latencyD6"] <-
    dfr[dfr$correct == 0 & dfr$block == "pair1", "Mpair1_correct"] + 600
  dfr[dfr$correct == 0 & dfr$block == "pair2", "latencyD6"] <-
    dfr[dfr$correct == 0 & dfr$block == "pair2", "Mpair2_correct"] + 600
  
  # compute the mean of the corrected latencies for each block
  Means <- tapply(dfr$latencyD6, list(dfr$subject, dfr$block), mean)
  
  # compute the pooled SD of correct latencies of both blocks
  pooledSD <- tapply(dfr$latencyD6, list(dfr$subject), sd, na.rm = TRUE)
  
  #compute Dscores
  IATdata <- data.frame(cbind(Means, pooledSD))
  IATdata$D6 <- (IATdata$pair2 - IATdata$pair1)/IATdata$pooledSD
  
  # return
  IATdata$subject <- as.numeric(rownames(IATdata))
  
  IATdata
}


# a function to compute the split-half reliability of the D6 scores,
# together with the scores on the two halves
reliabD6 <- function(dfr)
{
  # dfr is a dataframe including at least the following columns
  # "subject" --> numeric, subject number
  # "latency" --> numeric, the latency
  # "block"   --> string ("pair1" vs. "pair2")
  # "correct" --> numeric binary (0 = wrong, 1 = correct)
  
  # split the data in two halves
  select <- rep_len(c(TRUE, FALSE), nrow(dfr))
  split1 <- dfr[select,]
  split2 <- dfr[!select,]
  
  # compute IAT scores for each half
  s1 <- D6(split1)
  s2 <- D6(split2)
  names(s1) <- paste0("s1_", names(s1))
  names(s2) <- paste0("s2_", names(s2))
  
  # split half reliability with spearman brown correction
  splith <- merge(s1, s2, by.x = "s1_subject", by.y = "s2_subject")
  names(splith)[1] <- "subject"
  correlation <- cor(splith$s1_D6, splith$s2_D6)
  reliability_splith<-2*correlation/(1+correlation)
  halves <- splith[,c("subject", "s1_D6", "s2_D6")]
  
  # return
  list("reliability" = reliability_splith, "halves" = halves)
}
