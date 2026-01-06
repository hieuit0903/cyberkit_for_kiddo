# Host Enumeration
**Methodology**
System enumeration is a critical process where we gather detailed information about the compromised system. This information helps identify potential privilege escalation vectors, sensitive data, and system weaknesses. It allows us to understand the target environment thoroughly, which is essential for further steps. The goal here is to understand the system’s setup-how it is structured, what purpose it serves, what it does specifically, and what the implications are. Moreover, host enumeration is to provide an overall picture of the target host, its environment, and how it interacts with other systems across the network<br>

# Windows Host

Check more basic command for [Windows Fundamentals](https://github.com/hieuit0903/cyberkit_for_kiddo/tree/main/Windows%20Fundamentals)

**More tools**
- [WinPeas](https://github.com/peass-ng/PEASS-ng/tree/master/winPEAS) - These automated enumeration tools are designed to uncover misconfigurations and vulnerabilities that could lead to higher privilege access.

**Methodology**

The types of information that we would be looking for can be broken down into the following categories:
|Type|Description|
|:---|:----|
|General System Information|Contains information about the overall target system. Target system information includes but is not limited to the hostname of the machine, OS-specific details (name, version, configuration, etc.), and installed hotfixes/patches for the system.|
|Networking Information|Contains networking and connection information for the target system and system(s) to which the target is connected over the network. Examples of networking information include but are not limited to the following: host IP address, available network interfaces, accessible subnets, DNS server(s), known hosts, and network resources.|
|Basic Domain Information|Contains Active Directory information regarding the domain to which the target system is connected.|
|User Information|Contains information regarding local users and groups on the target system. This can typically be expanded to contain anything accessible to these accounts, such as environment variables, currently running tasks, scheduled tasks, and known services.|

**Common Systeminfo Output**
```
C:\zed> systeminfo
C:\zed> hostname
C:\zed> ver
```
**Scoping the Network**
```
C:\zed> ipconfig
C:\zed> arp /a
```
**Enum Current User/Group**
```
C:\zed> whoami
C:\zed> whoami /priv
C:\zed> whoami /groups
C:\zed> net user
C:\zed> net group #Only work on Domain Controller
C:\zed>net localgroup
```
**Resources on the Network**
```
C:\zed> net share
C:\zed> net view 
```
**The scheduled tasks**
```
PS C:\zed> schtasks /query /fo LIST /v
```
**Using Crackmapexec for further windows information gathering**
- Server Message Block (SMB) is a network file sharing protocol, similar to FTP on Linux systems, that allows applications on a computer to read and write to files and request services from server programs. From a cybersecurity standpoint, SMB is critical because it is widely used in Windows networks for file and printer sharing, and it has frequently been targeted by attacks—such as those exploiting vulnerabilities like EternalBlue. Proper security configuration of SMB is essential, as misconfigured shares can lead to unauthorized access, data breaches, and lateral movement within a network, making it a common attack vector for gaining initial access or escalating privileges in corporate environments <br>
```
### Check if a NULL session (anonymous login) is possible
$ crackmapexec smb <Server_IP> -u '' -p '' --users

### Enumerate available shares
$ crackmapexec smb <Server_IP> -u '<username>' -p '<password>' --shares

### Try the guest user without password
$ crackmapexec smb <Server_IP> -u 'guest' -p '' --shares

### Try to spider the shares that we have found
$ crackmapexec smb <Server_IP> -u '<username>' -p '<password>' --spider <Share_Name> --pattern .

### Download the file that we found
$ crackmapexec smb <Server_IP> -u '<username>' -p '<password>' --share <Share_Name> --get-file <file_needto_download> <new_name_file>
```

# Linux Host
Check more basic command for [Linux Fundamentals](https://github.com/hieuit0903/cyberkit_for_kiddo/tree/main/Linux%20Fundamentals) <br>

**More tools**
- [LinPEAS](https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh) - a powerful enumeration tool designed to automatically detect possible privilege escalation vectors on Linux systems.<br>
- [GTFObins](https://gtfobins.github.io/#) - GTFOBins is a curated list of Unix binaries that can be used to bypass local security restrictions in misconfigured systems.<br>

**Methodology**

We need to collect at least the following pieces of information:
|Type|Description|
|:---|:----|
|System Information|OS version, kernel version, architecture, and installed patches|
|User Information|Current user privileges, all users on the system, sudo rights|
|Network Information|Network interfaces, routing tables, active connections|
|Running Services|Active processes, listening ports, scheduled tasks|
|File System|Interesting files, permissions issues, mounted drives|
|Installed Software|Applications, versions, potential vulnerabilities|
|Security Mechanisms|Firewall rules, SELinux status, AppArmor profiles|

**Critical files need to check and read**
```
$ cat .bash_history
$ cat id_rsa #SSH private key in .ssh directory
```
**Using linpeas**
```
$ bash linpeas.sh -a -N > linpeas_results.txt
```
