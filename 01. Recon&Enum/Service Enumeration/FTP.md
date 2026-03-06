# File Transfer Protocol - FTP
- The File Transfer Protocol (FTP) is one of the oldest protocols on the Internet. The FTP runs within the application layer of the TCP/IP protocol stack. Thus, it is on the same layer as HTTP or POP. These protocols also work with the support of browsers or email clients to perform their services. There are also special FTP programs for the File Transfer Protocol.<br>
- In an FTP connection, two channels are opened. First, the client and server establish a control channel through TCP port 21. The client sends commands to the server, and the server returns status codes. Then both communication participants can establish the data channel via TCP port 20. This channel is used exclusively for data transmission, and the protocol watches for errors during this process. If a connection is broken off during transmission, the transport can be resumed after re-established contact.<br>
- The FTP knows different commands and status codes. Not all of these commands are consistently implemented on the server. For example, the client-side instructs the server-side to upload or download files, organize directories or delete files. The server responds in each case with a status code that indicates whether the command was successfully implemented. A list of possible status codes can be found [here](https://en.wikipedia.org/wiki/List_of_FTP_server_return_codes).
- There are many different security-related settings we can make on each FTP server. These can have various purposes, such as testing connections through the firewalls, testing routes, and authentication mechanisms. One of these authentication mechanisms is the anonymous user. This is often used to allow everyone on the internal network to share files and data without accessing each other's computers.<br>

**FTP Enumeration Cheat Sheet**
|Key/Command|Description|
|:----|:----|
|nc -nv <Server_IP> 21|Service Interaction|
|telnet <Server_IP> 21|Service Interaction|
|openssl s_client -connect <Server_IP>:21 -starttls ftp|Service Interaction|
|sudo nmap --script-updatedb|Nmap FTP Scripts Update|
|sudo nmap -sV -p21 -sC -A <Server_IP>|Nmap|
|sudo nmap -sV -p21 -sC -A <Server_IP> --script-trace|Nmap Script Trace|

**Interact to FTP Server**
- One of the most used FTP servers on Linux-based distributions is vsFTPd. The default configuration of vsFTPd can be found in /etc/vsftpd.conf, and some settings are already predefined by default.<br>

|Key/Command|Description|
|:----|:----|
|sudo apt install vsftpd|Install vsFTPd|
|cat /etc/vsftpd.conf \| grep -v "#"|vsFTPd Config File|
|cat /etc/ftpusers|FTPUSERS file|
|ftp> status|Overview of the server's settings|
|ftp> debug|vsFTPd Detailed Output|
|ftp> trace|vsFTPd Detailed Output|
|ftp> get <file_name>|Download a File|
|wget -m --no-passive ftp://username:password@<Server_IP>|Download All Available Files|
|ftp> put <file_name>|Upload a File|

**Dangerous Settings**
- With the standard FTP client (ftp), we can access the FTP server accordingly and log in with the anonymous user if the settings shown below have been used. The use of the anonymous account can occur in internal environments and infrastructures where the participants are all known. Access to this type of service can be set temporarily or with the setting to accelerate the exchange of files.<br>

|Setting|Description|
|:----|:----|
|anonymous_enable=YES|Allowing anonymous login?|
|anon_upload_enable=YES|Allowing anonymous to upload files?|
|anon_mkdir_write_enable=YES|Allowing anonymous to create new directories?|
|no_anon_password=YES|Do not ask anonymous for password?|
|anon_root=/home/username/ftp|Directory for anonymous.|
|write_enable=YES|Allow the usage of FTP commands: STOR, DELE, RNFR, RNTO, MKD, RMD, APPE, and SITE?|
