fxtrim <- function(x, lo = 400, up = 10000)
{
  # convert latencies < 400 to NAs
  x[x < 400] <- NA
  x
}
