# HoopsImpact

> Tools for evaluating basketball player performance and team impact in R.

## Overview

HoopsImpact is an R package that provides accessible functions for sports
analytics work in basketball. For now it is best used with the sample data provided in the package to work well.
Further updates will hopefully allow it to utilize other packages like HoopR to scrape real data and provide Impact Scores.
The package combines data processing, role
classification, head-to-head comparison, and visualization in a single
toolkit, and ships with a sample dataset so every function can be tried
right away.

## Installation

You can install the development version of HoopsImpact directly from
GitHub:

```r
# install.packages("devtools")
devtools::install_github("[your-username]/HoopsImpact")
```

## Functions

| Function | Purpose |
|---|---|
| `impact_score()` | Calculate an efficiency-weighted impact score for one or more players |
| `classify_role()` | Assign each player a role label (Primary Scorer, Efficient Finisher, Floor General, Defensive Specialist, Role Player) |
| `compare_players()` | Compare two players head-to-head across the core box-score categories |
| `plot_player()` | Visualize a player's performance using ggplot2 |
| `player_summary()` | Build a `player_profile` S3 object summarizing one player |
| `PlayerProfile()` | Build a `TeamImpact` S4 object summarizing a whole team |

## Classes and Methods

HoopsImpact intentionally demonstrates both R class systems so that
students and reviewers can see how each one works in a real package.

- **S3:** `player_profile` class with custom `print()` and `summary()`
  methods.
- **S4:** `TeamImpact` class with formal slots, a validity function, and
  `show()` and `summary()` methods.

## Quick Example

```r
library(HoopsImpact)
data(sample_players)

# Calculate impact scores
sample_players$impact <- impact_score(sample_players)

# Classify each player's role
sample_players$role <- classify_role(sample_players)

# Compare two players
compare_players(sample_players, "A. Carter", "B. Mitchell")

# Build an S3 player profile
prof <- player_summary(sample_players, "A. Carter")
print(prof)

# Build an S4 team object
team <- PlayerProfile(sample_players, team_name = "Sample U",
                      season = "2025-26")
summary(team)
```

## Dependencies

- **Depends:** R (>= 4.0.0)
- **Imports:** dplyr, ggplot2, methods, stats
- **Suggests:** testthat, knitr, rmarkdown

## License

This package is released under the [CC0 1.0 Universal](LICENSE) public
domain dedication.
