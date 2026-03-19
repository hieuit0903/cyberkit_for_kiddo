# MySQL
- MySQL is an open-source SQL relational database management system developed and supported by Oracle. A database is simply a structured collection of data organized for easy use and retrieval. The database system can quickly process large amounts of data with high performance. Within the database, data storage is done in a manner to take up as little space as possible.<br>
- The MySQL server is the actual database management system. It takes care of data storage and distribution. The data is stored in tables with different columns, rows, and data types. These databases are often stored in a single file with the file extension .sql, for example, like wordpress.sql.<br>

**MySQL Enumeration Cheat Sheet**
- There are many reasons why a MySQL server could be accessed from an external network. Nevertheless, it is far from being one of the best practices, and we can always find databases that we can reach.<br>
- Often, these settings were only meant to be temporary but were forgotten by the administrators. This server setup could also be used as a workaround due to a technical problem. Usually, the MySQL server runs on TCP port 3306.

|Key/Command|Description|
|:----|:----|
|sudo nmap <Server_IP> -sV -sC -p3306 --script mysql*|Using Nmap to scan MySQL Server|

**Interaction with the MySQL Server**
- MySQL default system schemas/databases:
  - **mysql** - is the system database that contains tables that store information required by the MySQL server.<br>
  - **information_schema** - provides access to database metadata.<br>
  - **performance_schema** - is a feature for monitoring MySQL Server execution at a low level<br>
  - **sys** - a set of objects that helps DBAs and developers interpret data collected by the Performance Schema.<br>
  
|Key/Command|Description|
|:----|:----|
|mysql -u <user_name> -h <Server_IP>|Log in to the MySQL server|
|mysql -u <user_name> -p<pass_word> -h <Server_IP>|Log in to the MySQL server|
|> show databases; |Show Databases|
|> select version();|Show version of database server|
|> use <database_name>;|Select a Database|
|> show tables;|Show Tables|
|> select * from <table_name>;|Show everything in the desired table.|
|> select * from <table_name> where <column_name> = "<desired_string>";|earch for needed string in the desired table.|

**Dangerous Settings**
- Many things can be misconfigured with MySQL. Look in more detail at the [MySQL reference](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html) to determine which options can be made in the server configuration.<br>

|Setting|Description|
|:----|:----|
|user|Sets which user the MySQL service will run as.|
|password|Sets the password for the MySQL user.|
|admin_address|The IP address on which to listen for TCP/IP connections on the administrative network interface.|
|debug|This variable indicates the current debugging settings|
|sql_warnings|This variable controls whether single-row INSERT statements produce an information string if warnings occur.|
|secure_file_priv|This variable is used to limit the effect of data import and export operations.|
- The settings user, password, and admin_address are security-relevant because the entries are made in plain text. Often, the rights for the configuration file of the MySQL server are not assigned correctly. If we get another way to read files or even a shell, we can see the file and the username and password for the MySQL server. Suppose there are no other security measures to prevent unauthorized access. In that case, the entire database and all the existing customers' information, email addresses, passwords, and personal data can be viewed and even edited.<br>
- The debug and sql_warnings settings provide verbose information output in case of errors, which are essential for the administrator but should not be seen by others. This information often contains sensitive content, which could be detected by trial and error to identify further attack possibilities. These error messages are often displayed directly on web applications. Accordingly, the SQL injections could be manipulated even to have the MySQL server execute system commands. <br>
