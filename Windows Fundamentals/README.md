# Windows Fundamentals
**File System:**

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
