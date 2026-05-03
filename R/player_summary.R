#' Build a Player Profile (S3 Class)
#'
#' Constructs a \code{player_profile} S3 object summarizing a single
#' player. The object stores the player's identifying information, their
#' core box-score line, their classified role, and their impact score in
#' a tidy list. It has dedicated \code{print} and \code{summary} methods
#' so that it displays nicely at the console.
#'
#' This function is the main demonstration of S3 in HoopsImpact. The
#' companion S4 class is \code{\link{TeamImpact-class}}.
#'
#' @param data A data frame of player statistics. Must contain a
#'   \code{player} column.
#' @param player_name Character. Name of the player to summarize.
#'
#' @return An object of class \code{player_profile}, which is a list
#'   with the following elements:
#' \describe{
#'   \item{name}{Player name.}
#'   \item{position}{Listed position, if available.}
#'   \item{minutes}{Minutes per game.}
#'   \item{box_score}{Named numeric vector of core box-score stats.}
#'   \item{role}{Role label from \code{\link{classify_role}}.}
#'   \item{impact}{Impact score from \code{\link{impact_score}}.}
#' }
#'
#' @examples
#' data(sample_players)
#' prof <- player_summary(sample_players, "A. Carter")
#' print(prof)
#' summary(prof)
#'
#' @export
player_summary <- function(data, player_name) {

  if (!"player" %in% names(data)) {
    stop("Input data must contain a 'player' column.")
  }
  row_idx <- which(data$player == player_name)
  if (length(row_idx) == 0) {
    stop("Player not found: ", player_name)
  }

  player_row <- data[row_idx[1], , drop = FALSE]

  box <- c(
    PTS = player_row$points,
    REB = player_row$rebounds,
    AST = player_row$assists,
    STL = player_row$steals,
    BLK = player_row$blocks,
    TOV = player_row$turnovers,
    FG  = player_row$fg_pct
  )

  obj <- list(
    name      = player_name,
    position  = if (!is.null(player_row$position)) player_row$position else NA,
    minutes   = player_row$minutes,
    box_score = box,
    role      = classify_role(player_row),
    impact    = impact_score(player_row)
  )

  class(obj) <- "player_profile"
  obj
}

#' Constructor for player_profile S3 Objects
#'
#' Lower-level constructor that builds a \code{player_profile} object
#' directly from its component pieces. Most users should call
#' \code{\link{player_summary}} instead, but this is provided for users
#' who already have the parts assembled.
#'
#' @param name Character. Player name.
#' @param position Character. Listed position.
#' @param minutes Numeric. Minutes per game.
#' @param box_score Named numeric vector.
#' @param role Character. Role label.
#' @param impact Numeric. Impact score.
#'
#' @return An object of class \code{player_profile}.
#'
#' @examples
#' new_player_profile(
#'   name = "Test Player",
#'   position = "G",
#'   minutes = 30,
#'   box_score = c(PTS = 15, REB = 4, AST = 5, STL = 1, BLK = 0,
#'                 TOV = 2, FG = 0.45),
#'   role = "Floor General",
#'   impact = 18.2
#' )
#'
#' @export
new_player_profile <- function(name, position, minutes, box_score,
                               role, impact) {
  obj <- list(
    name      = name,
    position  = position,
    minutes   = minutes,
    box_score = box_score,
    role      = role,
    impact    = impact
  )
  class(obj) <- "player_profile"
  obj
}

#' Print Method for player_profile Objects
#'
#' @param x A \code{player_profile} object.
#' @param ... Unused; included for S3 method consistency.
#' @return Invisibly returns the object. Called for the printed side effect.
#' @method print player_profile
#' @export
print.player_profile <- function(x, ...) {
  cat("Player Profile\n")
  cat("--------------\n")
  cat("Name:     ", x$name,     "\n", sep = "")
  cat("Position: ", x$position, "\n", sep = "")
  cat("Minutes:  ", x$minutes,  "\n", sep = "")
  cat("Role:     ", x$role,     "\n", sep = "")
  cat("Impact:   ", round(x$impact, 2), "\n", sep = "")
  cat("\nBox score:\n")
  print(x$box_score)
  invisible(x)
}

#' Summary Method for player_profile Objects
#'
#' @param object A \code{player_profile} object.
#' @param ... Unused; included for S3 method consistency.
#' @return Invisibly returns the object. Called for the printed side effect.
#' @method summary player_profile
#' @export
summary.player_profile <- function(object, ...) {
  cat("Summary of player_profile object\n")
  cat("--------------------------------\n")
  cat(object$name, "(", object$position, ") -- role: ", object$role, "\n",
      sep = "")
  cat("Per-36 impact score: ", round(object$impact, 2), "\n", sep = "")
  cat("Scoring efficiency (FG%): ",
      round(object$box_score["FG"] * 100, 1), "%\n", sep = "")
  cat("Assist-to-turnover: ",
      round(object$box_score["AST"] / max(object$box_score["TOV"], 0.1), 2),
      "\n", sep = "")
  invisible(object)
}
