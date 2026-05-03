#' Classify Player Role
#'
#' Assigns each player a role label based on their statistical profile.
#' The classification is rule-based and intentionally simple so that the
#' output is easy to interpret. The categories are:
#' \itemize{
#'   \item \code{"Primary Scorer"}: high points per game.
#'   \item \code{"Efficient Finisher"}: high field-goal percentage with
#'     moderate scoring.
#'   \item \code{"Floor General"}: high assist rate.
#'   \item \code{"Defensive Specialist"}: high combined steals and
#'     blocks.
#'   \item \code{"Role Player"}: anyone who does not meet a threshold
#'     above.
#' }
#'
#' @param data A data frame containing at least \code{points},
#'   \code{assists}, \code{steals}, \code{blocks}, and \code{fg_pct}.
#' @param scorer_pts Numeric. Points threshold for Primary Scorer.
#'   Defaults to 15.
#' @param finisher_fg Numeric. Field-goal-percentage threshold for
#'   Efficient Finisher. Defaults to 0.55.
#' @param general_ast Numeric. Assist threshold for Floor General.
#'   Defaults to 5.
#' @param defender_stocks Numeric. Threshold for combined steals plus
#'   blocks for Defensive Specialist. Defaults to 2.
#'
#' @return A character vector of role labels, one per row of \code{data}.
#'
#' @examples
#' data(sample_players)
#' classify_role(sample_players)
#'
#' # Use stricter thresholds:
#' classify_role(sample_players, scorer_pts = 18, general_ast = 6)
#'
#' @export
classify_role <- function(data,
                          scorer_pts      = 15,
                          finisher_fg     = 0.55,
                          general_ast     = 5,
                          defender_stocks = 2) {

  required <- c("points", "assists", "steals", "blocks", "fg_pct")
  missing_cols <- setdiff(required, names(data))
  if (length(missing_cols) > 0) {
    stop("Input data is missing required columns: ",
         paste(missing_cols, collapse = ", "))
  }

  roles <- character(nrow(data))

  for (i in seq_len(nrow(data))) {
    row <- data[i, ]
    if (row$points >= scorer_pts) {
      roles[i] <- "Primary Scorer"
    } else if (row$fg_pct >= finisher_fg) {
      roles[i] <- "Efficient Finisher"
    } else if (row$assists >= general_ast) {
      roles[i] <- "Floor General"
    } else if ((row$steals + row$blocks) >= defender_stocks) {
      roles[i] <- "Defensive Specialist"
    } else {
      roles[i] <- "Role Player"
    }
  }

  roles
}
