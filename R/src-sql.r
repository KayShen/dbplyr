#' Create a "sql src" object
#'
#' Deprecated: please use [src_dbi] instead.
#'
#' @keywords internal
#' @export
#' @param subclass name of subclass. "src_sql" is an abstract base class, so you
#'   must supply this value. `src_` is automatically prepended to the
#'   class name
#' @param con the connection object
#' @param ... fields used by object
src_sql <- function(subclass, con, ...) {
  subclass <- paste0("src_", subclass)
  structure(list(con = con, ...), class = c(subclass, "src_sql", "src"))
}

#' @export
same_src.src_sql <- function(x, y) {
  if (!inherits(y, "src_sql")) return(FALSE)
  identical(x$obj, y$obj)
}

#' @export
src_tbls.src_sql <- function(x, ...) {
  db_list_tables(x$con)
}

#' @export
format.src_sql <- function(x, ...) {
  paste0(
    "src:  ", db_desc(x$con), "\n",
    wrap("tbls: ", paste0(sort(src_tbls(x)), collapse = ", "))
  )
}
