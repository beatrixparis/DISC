#' Assemble data of a given kind from several deployments
#'
#' @param pattern pattern to look for in the file name; passed to \code{\link[base]{list.files}}
#' @param ids deployment ids to limit the search to; if NULL (the default) get data from all deployments
#' @inheritParams disc_dd
#'
#' @export
#' @importFrom plyr adply laply
#' @importFrom stringr str_c str_split
disc_assemble <- function(pattern, ids=NULL, deploy.dir=NULL) {

  # get/set deployments directory
  wd <- disc_dd(deploy.dir)

  # get/set disc options
  disc_conf()

  # check ids
  existingDeployments <- list.dirs(wd, full.names=FALSE, recursive=FALSE)
  if ( is.null(ids) ) {
    ids <- existingDeployments
  }
  ok <- ids %in% existingDeployments
  if ( any(!ok) ) {
    warning("Deployments ", str_c(ids[!ok], collapse=", "), " were not found and will be skipped", immediate.=TRUE)
    ids <- ids[ok]
  }

  # list matching files in the appropriate deployment directories
  files <- list.files(str_c(wd, ids, sep="/"), pattern=pattern, full.names=TRUE)

  # TODO check all are CSV

  # get data from these files
  d <- adply(files, 1, read.csv, stringsAsFactors=FALSE, .inform=TRUE)

  # identify each deployment
  # by ID (extract it from the file name, as the "before-the-last" element)
  bits <- str_split(files, "/")
  n <- length(bits[[1]])
  # TODO check this n is the same for all, it should
  deployId <- laply(bits, `[`, n-1)
  d$deployId <- deployId[d$X1]

  # from the file name
  d$fileName <- files[d$X1]

  # remove the index
  d <- d[,-1]

  return(d)
}

#' @rdname disc_assemble
#' @export
dassemble <- disc_assemble