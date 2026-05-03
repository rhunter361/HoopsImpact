#' HoopsImpact: Tools for Evaluating Basketball Player Performance and Team Impact
#'
#' The HoopsImpact package provides a small but practical toolkit for
#' analyzing basketball player performance. It is built for students,
#' analysts, and coaches who want to evaluate player contributions without
#' having to build models from scratch.
#'
#' @section Main functions:
#' \itemize{
#'   \item \code{\link{impact_score}}: Calculate an efficiency-weighted
#'     impact score for one or more players.
#'   \item \code{\link{classify_role}}: Assign each player a role label
#'     such as Primary Scorer, Efficient Finisher, Floor General, or
#'     Defensive Specialist.
#'   \item \code{\link{compare_players}}: Compare two players head-to-head
#'     across the core box-score categories.
#'   \item \code{\link{plot_player}}: Visualize a player's performance
#'     profile using ggplot2.
#'   \item \code{\link{player_summary}}: Build a player_profile S3 object
#'     summarizing a single player.
#' }
#'
#' @section Classes:
#' The package demonstrates both S3 and S4 systems. The
#' \code{player_profile} class is implemented as S3 with custom
#' \code{print} and \code{summary} methods. The \code{TeamImpact} class
#' is implemented as S4 with formal slots and a validity check, and ships
#' with \code{show} and \code{summary} methods.
#'
#' @section Sample data:
#' The package ships with the \code{\link{sample_players}} dataset, a
#' small set of fictional player season statistics that can be used to
#' demonstrate every function in the package.
#'
#' @docType package
#' @name HoopsImpact-package
#' @aliases HoopsImpact
"_PACKAGE"
