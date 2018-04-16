dbInsertConcurrent <- function(db_connection, statement, try_limit = 200){
  
  not_finished <- TRUE
  
  try_count <- 0
  
  while(not_finished){
    try_result = try(dbGetQuery(db_connection, 
                                statement = statement
                                ),
                     silent = TRUE)
    
    try_count <- try_count + 1
    
    # if the write operation succeeded, then we stop the WHILE loop
    if(class(try_result) != "try-error"){
      not_finished <- FALSE
    } else {
      print("concurrency encountered")
    }
    
    # if the write operation failed, but the reason is NOT "database is locked", then we stop WHILE loop too, and give the original error message
    # since the write operation failed due to some other reasons and users may need to debug
    if(class(try_result) == "try-error" && !grepl("database is locked", try_result[1])){
      not_finished <- FALSE
      warning(as.character(try_result[1]))
    }
    
    # if the we tries too many times, no matter what reason it is, we stop.
    if(try_count>try_limit){
      not_finished <- FALSE
      warning("Tried more than limit specified")
    }
    
  }
  
  
}
