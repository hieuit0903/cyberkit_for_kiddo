# Server Message Block - SMB
- Server Message Block (SMB) is a client-server protocol that regulates access to files and entire directories and other network resources such as printers, routers, or interfaces released for the network. Information exchange between different system processes can also be handled based on the SMB protocol.<br>
- The SMB protocol enables the client to communicate with other participants in the same network to access files or services shared with it on the network. The other system must also have implemented the network protocol and received and processed the client request using an SMB server application.<br>
- In IP networks, SMB uses TCP protocol for this purpose, which provides for a three-way handshake between client and server before a connection is finally established.<br>
- Access rights are defined by Access Control Lists (ACL). They can be controlled in a fine-grained manner based on attributes such as execute, read, and full access for individual users or user groups. The ACLs are defined based on the shares and therefore do not correspond to the rights assigned locally on the server.<br>

**SMB Enumeration Cheat Sheet**
|Key/Command|Description|
|:----|:----|
|smbclient -N -L //<Server_IP>|SMBclient - Connecting to the Share|
|smbclient //<Server_IP>/path|SMBclient - Connecting to the Specific Share|
|sudo nmap <Server_IP> -sV -sC -p139,445|Nmap|
|rpcclient -U "" <Server_IP>|Using RPCclient - Anonymous login|
|rpcclient $> srvinfo|RPCclient Enumeration - Server information.|
|rpcclient $> enumdomains|RPCclient Enumeration - Enumerate all domains that are deployed in the network.|
|rpcclient $> querydominfo|RPCclient Enumeration - Provides domain, server, and user information of deployed domains.|
|rpcclient $> netshareenumall|RPCclient Enumeration - Enumerates all available shares.|
|rpcclient $> netsharegetinfo <share>|RPCclient Enumeration - Provides information about a specific share.|
|rpcclient $> enumdomusers|RPCclient Enumeration - Enumerates all domain users.|
|rpcclient $> queryuser <RID>|RPCclient Enumeration - Provides information about a specific user.|
|rpcclient $> querygroup <Group_RID>|RPCclient Enumeration - Group Information.|
|samrdump.py <Server_IP>|Using Impacket - Samrdump.py|
|smbmap -H <Server_IP>|Using SMBmap|
|crackmapexec smb <Server_IP> --shares -u '' -p ''|Using CrackMapExec|
|./enum4linux-ng.py <Server_IP> -A|Using Enum4Linux-ng|

```
# Bash - Brute Forcing User RIDs
for i in $(seq 500 1100);do rpcclient -N -U "" <Server_IP> -c "queryuser 0x$(printf '%x\n' $i)" | grep "User Name\|user_rid\|group_rid" && echo "";done
```
```
# Enum4Linux-ng - Installation
$ git clone https://github.com/cddmp/enum4linux-ng.git
$ cd enum4linux-ng
$ pip3 install -r requirements.txt
```

**Dangerous Settings**

|Setting|Description|
|:----|:----|
|browseable = yes|Allow listing available shares in the current share?|
|read only = no|Forbid the creation and modification of files?|
|writable = yes|Allow users to create and modify files?|
|guest ok = yes|Allow connecting to the service without using a password?|
|enable privileges = yes|Honor privileges assigned to specific SID?|
|create mask = 0777|What permissions must be assigned to the newly created files?|
|directory mask = 0777|What permissions must be assigned to the newly created directories?|
|logon script = script.sh|What script needs to be executed on the user's login?|
|magic script = script.sh|Which script should be executed when the script gets closed?|
|magic output = script.out|Where the output of the magic script needs to be stored?|

