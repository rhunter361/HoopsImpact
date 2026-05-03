#' Compare Two Players Head-to-Head
#'
#' Builds a side-by-side comparison of two players across the core box
#' score categories: points, rebounds, assists, steals, blocks,
#' turnovers, and field-goal percentage. The function also flags which
#' player has the edge in each category, which is useful for quick
#' scouting summaries.
#'
#' @param data A data frame of player statistics. Must contain a
#'   \code{player} column.
#' @param player_1 Character. Name of the first player.
#' @param player_2 Character. Name of the second player.
#'
#' @return A data frame with one row per statistic and three columns:
#'   the value for player one, the value for player two, and an
#'   \code{advantage} column showing whose value is larger. For the
#'   turnovers row the advantage goes to the player with the smaller
#'   value.
#'
#' @examples
#' data(sample_players)
#' compare_players(sample_players, "A. Carter", "B. Mitchell")
#'
#' @export
compare_players <- function(data, player_1, player_2) {

  if (!"player" %in% names(data)) {
    stop("Input data must contain a 'player' column.")
  }

  p1 <- data[data$player == player_1, , drop = FALSE]
  p2 <- data[data$player == player_2, , drop = FALSE]

  if (nrow(p1) == 0) stop("Player not found: ", player_1)
  if (nrow(p2) == 0) stop("Player not found: ", player_2)

  stats <- c("points", "rebounds", "assists", "steals",
             "blocks", "turnovers", "fg_pct")

  out <- data.frame(
    statistic = stats,
    p1_value  = as.numeric(p1[1, stats]),
    p2_value  = as.numeric(p2[1, stats]),
    stringsAsFactors = FALSE
  )

  # Turnovers: lower is better. All other stats: higher is better.
  out$advantage <- ifelse(
    out$statistic == "turnovers",
    ifelse(out$p1_value < out$p2_value, player_1,
           ifelse(out$p2_value < out$p1_value, player_2, "Tie")),
    ifelse(out$p1_value > out$p2_value, player_1,
           ifelse(out$p2_value > out$p1_value, player_2, "Tie"))
  )

  names(out)[2] <- player_1
  names(out)[3] <- player_2
  out
}
