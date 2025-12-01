# Windows Fundamentals

# CMD

**Methodology**
- The Command Prompt, also known as cmd.exe or CMD, is the default command line interpreter for the Windows operating system.

**Useful Keys & Commands for Terminal History**
|Key/Command|Description|
|:----|:----|
|doskey /history|doskey /history will print the session's command history to the terminal or output it to a file when specified.|
|page up|Places the first command in our session history to the prompt.|
|page down|Places the last command in history to the prompt.|
|⇧|Allows us to scroll up through our command history to view previously run commands.|
|⇩|Allows us to scroll down to our most recent commands run.|
|⇨|Types the previous command to prompt one character at a time.|
|F3|Will retype the entire previous entry to our prompt.|
|F5|Pressing F5 multiple times will allow you to cycle through previous commands.|
|F7|Opens an interactive list of previous commands.|
|F9|Enters a command to our prompt based on the number specified. The number corresponds to the commands place in our history.|

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

# PowerShell

- A repository that contains PowerShell scripts, modules, and more created by Microsoft and other users - [here](https://www.powershellgallery.com/)
- The locations for each specific PowerShell profile - [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2)

**Methodology**

- According to Microsoft, A [cmdlet](https://learn.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-13?view=powershell-7.5&viewFallbackFrom=powershell-7.2) is a single-feature command that manipulates objects in PowerShell. Cmdlets can be recognized by their name format, a verb and noun separated by a dash (-), such as Get-Help, Get-Process, and Start-Service. A verb pattern is a verb expressed using wildcards, as in W*. A noun pattern is a noun expressed using wildcards, as in event.<br>
- A PowerShell module is structured PowerShell code that is made easy to use & share.<br>

**Working with Powershell**
```
### Check current working directory
PS %> Get-Location

### List the Directory
PS %> Get-ChildItem

### Changing our location
PS %> Set-Location <Path>

### List of default aliases
PS %> Get-Alias

### Set aliases
PS %> Set-Alias -Name <name> -Value <PS_Command>

### Display Contents of a File
ps %> Get-Content <File_name>

### Powershell history
PS %> Get-History
PS %> get-content C:\Users\Zed\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

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
**Execution Policy**

- Recommend for real-life engagement that is use -Scope Process, because our change will revert once we close the PowerShell session.
- Some creative about how to bypass the Execution Policy on a host. [here](https://www.netspi.com/blog/technical-blog/network-penetration-testing/15-ways-to-bypass-the-powershell-execution-policy/)
```
### List the current execution policy for all scopes:
PS %> Get-ExecutionPolicy -List

### Changing the execution policy:
PS %> Set-ExecutionPolicy Bypass -Scope Process 
PS %> Set-ExecutionPolicy undefined 
```

**Working with Powershell Modules**
```
### Determine what modules are already loaded
PS %> Get-Module
PS %> Get-Module -ListAvailable

### Import module
PS %> Import-Module <Path_to_file>

### Viewing PSModulePath
PS %> $env:PSModulePath

### Check what aliases, cmdlets, and functions an imported module brought to the session
PS %> Get-Command -Module <Module_name>

```
