test_that("impact_score returns a numeric vector of correct length", {
  data(sample_players)
  out <- impact_score(sample_players)
  expect_type(out, "double")
  expect_length(out, nrow(sample_players))
})

test_that("impact_score scaling produces a z-score-like vector", {
  data(sample_players)
  out <- impact_score(sample_players, scale = TRUE)
  expect_equal(round(mean(out), 6), 0)
  expect_equal(round(stats::sd(out), 6), 1)
})

test_that("impact_score errors when columns are missing", {
  bad <- data.frame(points = 1, rebounds = 1)
  expect_error(impact_score(bad), "missing required columns")
})

test_that("classify_role returns one label per row", {
  data(sample_players)
  roles <- classify_role(sample_players)
  expect_length(roles, nrow(sample_players))
  expect_true(all(roles %in% c("Primary Scorer", "Efficient Finisher",
                               "Floor General", "Defensive Specialist",
                               "Role Player")))
})

test_that("compare_players flags correct advantages", {
  data(sample_players)
  out <- compare_players(sample_players, "A. Carter", "B. Mitchell")
  expect_s3_class(out, "data.frame")
  expect_equal(nrow(out), 7)
  expect_true("advantage" %in% names(out))
})

test_that("compare_players errors on unknown player", {
  data(sample_players)
  expect_error(compare_players(sample_players, "Nobody", "B. Mitchell"),
               "Player not found")
})

test_that("player_summary returns a player_profile S3 object", {
  data(sample_players)
  prof <- player_summary(sample_players, "A. Carter")
  expect_s3_class(prof, "player_profile")
  expect_named(prof, c("name", "position", "minutes",
                       "box_score", "role", "impact"))
})

test_that("PlayerProfile builds a valid TeamImpact S4 object", {
  data(sample_players)
  team <- PlayerProfile(sample_players, team_name = "Sample U")
  expect_s4_class(team, "TeamImpact")
  expect_equal(length(team@players), nrow(sample_players))
  expect_equal(length(team@impacts), nrow(sample_players))
})
