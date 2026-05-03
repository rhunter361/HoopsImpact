#' Visualize Player Performance
#'
#' Creates a bar plot of a single player's core box-score statistics
#' using ggplot2. The plot is intentionally simple so that it can be
#' embedded in scouting reports or course assignments without further
#' styling.
#'
#' @param data A data frame containing a \code{player} column and the
#'   standard box-score columns: \code{points}, \code{rebounds},
#'   \code{assists}, \code{steals}, and \code{blocks}.
#' @param player_name Character. Name of the player to plot.
#'
#' @return A \code{ggplot} object. The plot can be printed directly or
#'   further customized with additional ggplot2 layers.
#'
#' @examples
#' \dontrun{
#' data(sample_players)
#' plot_player(sample_players, "A. Carter")
#' }
#'
#' @importFrom ggplot2 ggplot aes geom_bar labs theme_minimal
#' @importFrom rlang .data
#' @export
plot_player <- function(data, player_name) {

  if (!"player" %in% names(data)) {
    stop("Input data must contain a 'player' column.")
  }

  player_row <- data[data$player == player_name, , drop = FALSE]
  if (nrow(player_row) == 0) {
    stop("Player not found: ", player_name)
  }

  stats <- c("points", "rebounds", "assists", "steals", "blocks")
  plot_df <- data.frame(
    statistic = factor(stats, levels = stats),
    value     = as.numeric(player_row[1, stats]),
    stringsAsFactors = FALSE
  )

  ggplot2::ggplot(plot_df,
                  ggplot2::aes(x = .data$statistic, y = .data$value)) +
    ggplot2::geom_bar(stat = "identity", fill = "#1f77b4") +
    ggplot2::labs(
      title = paste("Performance Profile:", player_name),
      x     = "Statistic",
      y     = "Per-Game Value"
    ) +
    ggplot2::theme_minimal()
}
