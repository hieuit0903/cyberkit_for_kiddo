# Windows Host

Check more basic command for [Windows Fundamentals](https://github.com/hieuit0903/cyberkit_for_kiddo/tree/main/Windows%20Fundamentals)

**More tools**
- [WinPeas](https://github.com/peass-ng/PEASS-ng/tree/master/winPEAS) - These automated enumeration tools are designed to uncover misconfigurations and vulnerabilities that could lead to higher privilege access.

**Methodology**

The goal of host enumeration is to provide an overall picture of the target host, its environment, and how it interacts with other systems across the network.<br>
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
