# Windows Fundamentals

**Environment Variables**

Check more about [Windows Environment Variables List](https://ss64.com/nt/syntax-variables.html)
```
### View Variables
%> set <env_name>
%> echo <env_name>

### set, and remove environment variables
%> set <env_name>=<value>
%> setx <env_name> <value>
%> setx <env_name> ""
```
**Working with Files/Directories**
```
### Printout of the entire path and subdirectories and file in each dir
%> tree /F <Dest_Path>

### Finding our place
%> chdir
%> cd

### Create files:
%> echo Check out this text > demo.txt
%> fsutil file createNew file-name.txt 222

### Rename files:
%> ren demo.txt superdemo.txt

### Delete files:
%> del <file-name>
%> erase <file-1> <file-2>

### Delete Directories
%> rd <Path>
%> rmdir <Path>
%> rd /S <Path>

### Show history command
%> doskey /history
```
**Finding Files and Directories**
```
### searching for files and applications on the host
%> where <filename>
%> where /R <path> <filename>

### find content of the file
%> find "<keyword>" "<path/to/file>"
%> findstr

### Compare file
%> comp <file1> <file2>
%> fc <file1> <file2> /N
```

**File System**

A full listing of icacls command-line arguments and detailed permission: [icacls](https://ss64.com/nt/icacls.html)
```
###  List out the NTFS permissions on a specific directory:
%> icacls <path_to_folder>

### Grant permission:
%> icacls c:\users /grant joe:f

### Remove the permission:
%> icacls c:\users /remove joe
```
**NTFS vs. Share Permissions**
```
### Smbclient to list available shares:
%> smbclient -L <SERVER_IP> -U <user>

### Connecting to the Data share:
%> smbclient '\\SERVER_IP\Data_Name' -U <User>

### Displaying Shares
%> net share
```
**Service Permissions**
```
### Query All Active Services
%> tasklist /svc
%> net start
%> wmic service list brief
%> sc query type= service

### Examining services:
%> sc qc <service_name>

### Start and stop services:
%> sc start <service_name>
%> sc stop <service_name>

### Examine service permissions:
%> sc sdshow <service_name>

### Config service:
%> sc config <service_name> binPath=<C:\Winbows\Perfectlylegitprogram.exe>
```

**WMI**
```
### List all user SID:
%> wmic useraccount get name,sid

### List all group SID:
%> wmic group get name,sid
```

**Execution Policy**
```
### List the current execution policy for all scopes:
PS %> Get-ExecutionPolicy -List

### Changing the execution policy for the current process (session):
PS %> Set-ExecutionPolicy Bypass -Scope Process
```

**Windows Defender Antivirus**
```
### Check which protection settings are enabled:
PS %> Get-MpComputerStatus
```

**Reg Query**
```
### Use Run or RunOnce registry keys to make a program run when a user logs on:
PS %> reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run
PS %> reg query HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
```

**Working With Scheduled Tasks**
```
### view the tasks that already exist
%> schtasks /Query /V /FO list

### create a task
%> schtasks /create /sc ONSTART /tn "Name of Task" /tr "Command Execution"

### query for the specific task
%> schtasks /query /tn "Name of Task" /V /fo list

### delete the scheduled task
schtasks /delete  /tn "Name of Task" 
```
