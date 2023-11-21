library(tidyverse)

dl_data <- read_delim(file = "data/download_stats.monthly.txt", delim = "\t")
# head(dl_data)

dl_data <- dl_data %>%
  separate(Month, c("Month", "Year"), "/")

# Correct only for total downloads
# Optimistic "Distinct IPs" counts duplicate IPs in separate months
dl_data %>%
  group_by(Year) %>%
  summarise(across(`Nb of distinct IPs`:`Nb of downloads`, sum))
