#' TeamImpact S4 Class
#'
#' A formal S4 class that represents the aggregated impact of a team's
#' players across one season. Where \code{\link{player_summary}} uses
#' the lightweight S3 system to describe a single player, the
#' \code{TeamImpact} class uses S4 to enforce stricter structure on a
#' team-level object: each slot has a declared type, and a validity
#' function ensures the player vector and impact vector are the same
#' length.
#'
#' @slot team_name Character. Team identifier.
#' @slot season Character. Season label, e.g. "2025-26".
#' @slot players Character vector. Names of players on the team.
#' @slot impacts Numeric vector. Impact scores aligned to
#'   \code{players}.
#' @slot total_impact Numeric. Sum of impact scores; computed
#'   automatically by the \code{\link{PlayerProfile}} constructor.
#'
#' @name TeamImpact-class
#' @rdname TeamImpact-class
#' @exportClass TeamImpact
setClass(
  "TeamImpact",
  representation(
    team_name    = "character",
    season       = "character",
    players      = "character",
    impacts      = "numeric",
    total_impact = "numeric"
  ),
  validity = function(object) {
    if (length(object@players) != length(object@impacts)) {
      return("'players' and 'impacts' must have the same length.")
    }
    if (length(object@team_name) != 1) {
      return("'team_name' must be a single string.")
    }
    if (length(object@season) != 1) {
      return("'season' must be a single string.")
    }
    TRUE
  }
)

#' Construct a TeamImpact Object
#'
#' Convenience constructor for \code{\link{TeamImpact-class}}. It
#' computes impact scores for every row in \code{data} and packages
#' them into a validated S4 object along with the team name and season.
#'
#' @param data A data frame of player statistics with the columns
#'   required by \code{\link{impact_score}} plus a \code{player}
#'   column.
#' @param team_name Character. Team identifier.
#' @param season Character. Season label (default \code{"2025-26"}).
#'
#' @return An object of class \code{TeamImpact}.
#'
#' @examples
#' data(sample_players)
#' team <- PlayerProfile(sample_players,
#'                       team_name = "Sample U",
#'                       season = "2025-26")
#' team
#' summary(team)
#'
#' @export
PlayerProfile <- function(data, team_name, season = "2025-26") {

  if (!"player" %in% names(data)) {
    stop("Input data must contain a 'player' column.")
  }

  imp <- impact_score(data)

  obj <- methods::new(
    "TeamImpact",
    team_name    = team_name,
    season       = season,
    players      = as.character(data$player),
    impacts      = as.numeric(imp),
    total_impact = sum(imp, na.rm = TRUE)
  )

  methods::validObject(obj)
  obj
}

#' @param object A \code{TeamImpact} object.
#' @param ... Unused; included for method consistency.
#' @rdname TeamImpact-class
setMethod("show", "TeamImpact", function(object) {
  cat("TeamImpact object\n")
  cat("-----------------\n")
  cat("Team:         ", object@team_name, "\n", sep = "")
  cat("Season:       ", object@season,    "\n", sep = "")
  cat("Players:      ", length(object@players), "\n", sep = "")
  cat("Total impact: ", round(object@total_impact, 2), "\n", sep = "")
})

#' @param object A \code{TeamImpact} object.
#' @param ... Unused; included for method consistency.
#' @rdname TeamImpact-class
setMethod("summary", "TeamImpact", function(object, ...) {
  ord <- order(object@impacts, decreasing = TRUE)
  out <- data.frame(
    rank   = seq_along(ord),
    player = object@players[ord],
    impact = round(object@impacts[ord], 2),
    stringsAsFactors = FALSE
  )
  cat("Summary of TeamImpact: ", object@team_name,
      " (", object@season, ")\n", sep = "")
  print(out, row.names = FALSE)
  invisible(out)
})
