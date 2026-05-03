# data-raw/sample_players.R
# Script used to create the bundled sample_players dataset.
# Run this once during package development; it writes data/sample_players.rda.

sample_players <- data.frame(
  player    = c("A. Carter", "B. Mitchell", "C. Reyes", "D. Okafor",
                "E. Thompson", "F. Nguyen", "G. Bell", "H. Singh",
                "I. Park",   "J. Russo"),
  position  = c("G", "G", "F", "C", "G", "F", "F", "C", "G", "F"),
  minutes   = c(32.4, 28.1, 30.5, 24.7, 19.8, 27.3, 22.6, 18.4, 26.9, 29.0),
  points    = c(18.2, 14.9, 12.1, 10.8,  7.4, 13.6,  9.2,  8.1, 11.7, 15.4),
  rebounds  = c( 4.1,  3.5,  6.8,  9.2,  2.4,  5.9,  4.7,  7.6,  3.1,  6.0),
  assists   = c( 5.2,  6.7,  2.1,  1.4,  3.1,  2.6,  1.9,  0.8,  6.4,  2.3),
  steals    = c( 1.6,  1.9,  0.9,  0.6,  0.8,  1.1,  1.4,  0.4,  1.7,  0.9),
  blocks    = c( 0.3,  0.2,  0.7,  1.6,  0.1,  0.6,  0.4,  1.2,  0.2,  0.5),
  turnovers = c( 2.1,  2.4,  1.5,  1.2,  1.0,  1.7,  1.1,  0.9,  2.2,  1.6),
  fg_pct    = c(0.462, 0.441, 0.512, 0.587, 0.398, 0.488, 0.423, 0.561, 0.451, 0.479),
  stringsAsFactors = FALSE
)

usethis::use_data(sample_players, overwrite = TRUE)
