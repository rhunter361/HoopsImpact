#' Calculate Player Impact Score
#'
#' Computes an efficiency-weighted impact score for one or more players.
#' The score combines positive box-score contributions (points, rebounds,
#' assists, steals, blocks) with a penalty for turnovers, and then scales
#' the result by minutes played so that players with smaller roles are
#' not unfairly punished.
#'
#' The formula used is:
#' \deqn{Impact = (PTS + 1.2 \cdot REB + 1.5 \cdot AST + 2 \cdot STL + 2 \cdot BLK - TO) \cdot (MIN / 36)}
#'
#' @param data A data frame containing the columns \code{points},
#'   \code{rebounds}, \code{assists}, \code{steals}, \code{blocks},
#'   \code{turnovers}, and \code{minutes}. The bundled
#'   \code{\link{sample_players}} dataset has the expected structure.
#' @param scale Logical. If \code{TRUE}, the returned scores are
#'   standardized to z-scores so that they can be compared across
#'   datasets. Defaults to \code{FALSE}.
#'
#' @return A numeric vector of impact scores, one per row of \code{data}.
#'
#' @examples
#' data(sample_players)
#' impact_score(sample_players)
#' impact_score(sample_players, scale = TRUE)
#'
#' @export
impact_score <- function(data, scale = FALSE) {

  required <- c("points", "rebounds", "assists", "steals",
                "blocks", "turnovers", "minutes")
  missing_cols <- setdiff(required, names(data))
  if (length(missing_cols) > 0) {
    stop("Input data is missing required columns: ",
         paste(missing_cols, collapse = ", "))
  }

  raw <- with(data,
              (points + 1.2 * rebounds + 1.5 * assists +
                 2 * steals + 2 * blocks - turnovers) * (minutes / 36))

  if (isTRUE(scale)) {
    raw <- (raw - mean(raw, na.rm = TRUE)) / stats::sd(raw, na.rm = TRUE)
  }

  raw
}
