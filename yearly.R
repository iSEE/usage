library(tidyverse)

dl_data <- read_delim(file = "data/download_stats.yearly.txt", delim = "\t")
# head(dl_data)

ggplot(dl_data, aes(Year, `Nb of distinct IPs`)) +
  geom_line() +
  geom_point() +
  coord_cartesian(ylim = c(0, NA)) +
  theme_bw() +
  labs(
    title = "iSEE"
  )

# Correct only for total downloads
# Optimistic "Distinct IPs" counts duplicate IPs in separate months
dl_data %>%
  group_by(Year) %>%
  summarise(across(`Nb of distinct IPs`:`Nb of downloads`, sum))
