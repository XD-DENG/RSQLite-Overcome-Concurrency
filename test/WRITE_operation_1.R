library(RSQLite)

db_con <- dbConnect(SQLite(), "test.db")

dbListTables(db_con)


for(i in 1:5000){
  print(i)


  dbInsertConcurrent(db_con, statement = paste("insert into users values('", i,"', 'fdsadf', '",
                                     Sys.time(), "','",
                                     Sys.time(), 
                                     "')", sep=""))

}




dbGetQuery(db_con, "select * from users")
#dbGetQuery(db_con, "delete from users")

dbDisconnect(db_con)