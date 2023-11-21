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

dl_data$Month <- factor(dl_data$Month, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",  "Oct", "Nov", "Dec"))

# Distinct IPs
ggplot(dl_data, aes(interaction(Month, Year), `Nb of distinct IPs`)) +
  geom_point() +
  labs(
    title = "iSEE"
  ) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 90),
    panel.grid.major.x = element_blank()
  )

# Total downloads
ggplot(dl_data, aes(interaction(Month, Year), `Nb of downloads`)) +
  geom_point() +
  labs(
    title = "iSEE"
  ) +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 90),
    panel.grid.major.x = element_blank()
  )

# Monthly stats since 2020
dl_data %>%
  filter(Year >= 2020) %>%
  summarise(across(`Nb of distinct IPs`:`Nb of downloads`, mean))
