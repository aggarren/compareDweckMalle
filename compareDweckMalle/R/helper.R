VerifyPathIsSafe <- function(path) {
  
  if (!file.exists(path))
    dir.create(path, recursive=T)
  
}

SafeReadCSV <- function(fileName) {
  if (file.exists(fileName)) {
    return(read.csv(fileName))
  } else {
    stop(paste0(fileName, " does not exist"))
  }
}