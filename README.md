# RSQLite-Overcome-Concurrency
How can we overcome concurrency in RSQLite (R's interfact to SQLite)


Here we try to address one problem we have when we use SQLite. SQLite will lock the whole DB file when there is any WRITE operation. This is why SQLite is not a good choice in case of high concurrency.

For example, if there are two write operations, like INSERT, at the same time (or the two time points are close enough), one of these two operations will fail. In R, with package "RSQLite", we will receive error message as below and the whole script will be interrupted.


Error in sqliteSendQuery(con, statement, bind.data) : 
  rsqlite_query_send: could not execute1: database is locked


What I'm going to do here is overcome this issue. Even if under high concurrency, I would still keep the INSERT operation can be finished properly.

