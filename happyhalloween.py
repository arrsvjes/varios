# import the mysql client for python

import pymysql 

# Create a connection object

dbServerName    = "fqdncontainer.northeurope.azurecontainer.io"
dbUser          = "root"
dbPassword      = ""
dbName          = "databasename"
charSet         = "utf8mb4"
cusrorType      = pymysql.cursors.DictCursor

connectionObject   = pymysql.connect(host=dbServerName, user=dbUser, password=dbPassword, db=dbName, charset=charSet,cursorclass=cusrorType)

try:
    # Create a cursor object
    cursorObject        = connectionObject.cursor()                                     
    # SQL query string
    sqlQuery            = "CREATE TABLE BOO (ID INT AUTO_INCREMENT PRIMARY KEY, Spooky_Costumes VARCHAR(30) NOT NULL, Price DECIMAL(5,2), Sales_Rating INT, category VARCHAR(30))"   
    # Execute the sqlQuery
    cursorObject.execute(sqlQuery)
    # SQL query string
    sqlQuery            = "show tables"   
    # Execute the sqlQuery

    cursorObject.execute(sqlQuery)


    # row1
    row1 = 'INSERT INTO BOO VALUES (1, "Bob the Builder", 34.99, 5, "TV Show")'
    cursorObject.execute(row1)
    connectionObject.commit()
    #Fetch all the rows
    rows                = cursorObject.fetchall()
    for row in rows:
        print(row)
except Exception as e:
    print("Exeception occured:{}".format(e))
finally:
    connectionObject.close()
    print("Finish update database")
