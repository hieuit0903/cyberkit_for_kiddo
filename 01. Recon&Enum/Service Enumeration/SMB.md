# Server Message Block - SMB
- Server Message Block (SMB) is a client-server protocol that regulates access to files and entire directories and other network resources such as printers, routers, or interfaces released for the network. Information exchange between different system processes can also be handled based on the SMB protocol.<br>
- The SMB protocol enables the client to communicate with other participants in the same network to access files or services shared with it on the network. The other system must also have implemented the network protocol and received and processed the client request using an SMB server application.<br>
- In IP networks, SMB uses TCP protocol for this purpose, which provides for a three-way handshake between client and server before a connection is finally established.<br>
- Access rights are defined by Access Control Lists (ACL). They can be controlled in a fine-grained manner based on attributes such as execute, read, and full access for individual users or user groups. The ACLs are defined based on the shares and therefore do not correspond to the rights assigned locally on the server.<br>

**SMB Enumeration Cheat Sheet**
|Key/Command|Description|
|:----|:----|
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
