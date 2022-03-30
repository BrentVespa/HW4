library(ggplot2)

load("C:/Users/brent/Documents/Classes/Data_Visualization/Tables/preprint_growth.rda") #please change the path if needed
head(preprint_growth)
preprint_growth %>% filter(archive == "bioRxiv") %>%
  filter(count > 0) -> biorxiv_growth
preprints <- preprint_growth %>% filter(archive %in%
                                        c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")) %>%filter(count > 0) %>%
  mutate(archive = factor(archive, levels = c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")))
preprints_final <- filter(preprints, date == ymd("2017-01-01"))

ggplot(preprints) +
  aes(date, count, color = archive, fill = archive) +
  geom_line(size = 1) +
  scale_y_continuous(
    limits = c(0, 600), expand = c(0, 0),
    name = "preprints / month",
    sec.axis = dup_axis( #this part is for the second y axis
      breaks = preprints_final$count, #and we use the counts to position our labels
      labels = c("arXivq-bio", "PeerJPreprints", "bioRxiv"),
      name = NULL)
  ) +
  scale_x_date(name = "year",
               limits = c(min(biorxiv_growth$date), ymd("2017-01-01"))) +
  scale_color_manual(values = c("#0072b2", "#D55E00", "#009e73"),
                     name = NULL) +
  theme(legend.position = "none")

#idk why my program is saying drop_na does not exist.
preprint_full = drop_na(preprint_growth) + filter(preprints_growth, 'count' > 0, 'year' > 2004)

preprint_full2 = filter(preprint_full, row = "bioRXiv", "F1000Research")

ggplot(preprint_full2, aes(x="bioRxiv"), color = "#7c6bea")  + legend.title(Name="Preprint Counts", align = 1)
ggplot(preprint_full2, aes(x="F1000Research"), color ="#fe8d6d") + legend.title(Name="Preprint Counts", align = 1)

