# Network File System - NFS
- etwork File System (NFS) is a network file system developed by Sun Microsystems and has the same purpose as SMB. Its purpose is to access file systems over a network as if they were local. However, it uses an entirely different protocol.<br>
- NFS is used between Linux and Unix systems. This means that NFS clients cannot communicate directly with SMB servers.<br>
- NFS is based on the Open Network Computing Remote Procedure Call (ONC-RPC/SUN-RPC) protocol exposed on TCP and UDP ports 111, which uses External Data Representation (XDR) for the system-independent exchange of data.<br>
- We can also use NFS for further escalation. For example, if we have access to the system via SSH and want to read files from another folder that a specific user can read, we would need to upload a shell to the NFS share that has the SUID of that user and then run the shell via the SSH user.<br>

**NFS Enumeration Cheat Sheet**
- When footprinting NFS, the TCP ports 111 and 2049 are essential. We can also get information about the NFS service and the host via RPC.<br>

|Key/Command|Description|
|:----|:----|
|sudo nmap <Server_IP> -p111,2049 -sV -sC|Nmap|
|sudo nmap --script nfs* <Server_IP> -sV -p111,2049|Nmap|
|showmount -e <Server_IP>|Show Available NFS Shares|
|sudo mount -t nfs <Server_IP>:/path /mountpoint -o nolock|Mounting NFS Share|
|sudo umount /mountpoint|Unmounting|


