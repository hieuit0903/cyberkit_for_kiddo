# Simple Mail Transfer Protocol - SMTP
- The Simple Mail Transfer Protocol (SMTP) is a protocol for sending emails in an IP network. It can be used between an email client and an outgoing mail server or between two SMTP servers. SMTP is often combined with the IMAP or POP3 protocols, which can fetch emails and send emails.<br>
- SMTP works unencrypted without further measures and transmits all commands, data, or authentication information in plain text. To prevent unauthorized reading of data, the SMTP is used in conjunction with SSL/TLS encryption. Under certain circumstances, a server uses a port other than the standard TCP port 25 for the encrypted connection, for example, TCP port 465.<br>

**DNS Enumeration Cheat Sheet**
|Key/Command|Description|
|:----|:----|
|sudo nmap <Server_IP> -sC -sV -p25|Using Nmap|
|sudo nmap <Server_IP> -p25 --script smtp-open-relay -v|Using Nmap - Open Relay|
|smtp-user-enum -M RCPT -U userlist.txt -D <Domain_Name> -t <Server_IP>|Using smtp-user-enum to enumerate the username|

**Interact with the SMTP server**
- To interact with the SMTP server, we can use the telnet tool to initialize a TCP connection with the SMTP server. The actual initialization of the session is done with the command mentioned below, HELO or EHLO.

|Key/Command|Description|
|:----|:----|
|AUTH PLAIN|AUTH is a service extension used to authenticate the client.|
|HELO|The client logs in with its computer name and thus starts the session.|
|MAIL FROM|The client names the email sender.|
|RCPT TO|The client names the email recipient.|
|DATA|The client initiates the transmission of the email.|
|RSET|The client aborts the initiated transmission but keeps the connection between client and server.|
|VRFY|The client checks if a mailbox is available for message transfer. Depending on how the SMTP server is configured, the SMTP server may issue [code](https://serversmtp.com/smtp-error/?doing_wp_cron=1773128098.0850949287414550781250) 252 and confirm the existence of a user that does not exist on the system.|
|EXPN|The client also checks if a mailbox is available for messaging with this command.|
|NOOP|The client requests a response from the server to prevent disconnection due to time-out.|
|QUIT|The client terminates the session.|

**Preventing spam**
- An essential function of an SMTP server is preventing spam using authentication mechanisms that allow only authorized users to send e-mails. For this purpose, most modern SMTP servers support the protocol extension ESMTP with SMTP-Auth. <br>
- After sending his e-mail, the SMTP client, also known as Mail User Agent (MUA), converts it into a header and a body and uploads both to the SMTP server. This has a so-called Mail Transfer Agent (MTA), the software basis for sending and receiving e-mails. The MTA checks the e-mail for size and spam and then stores it. To relieve the MTA, it is occasionally preceded by a Mail Submission Agent (MSA), which checks the validity, i.e., the origin of the e-mail. <br>
- This MSA is also called Relay server. These are very important later on, as the so-called Open Relay Attack can be carried out on many SMTP servers due to incorrect configuration. We will discuss this attack and how to identify the weak point for it a little later. The MTA then searches the DNS for the IP address of the recipient mail server.<br>
<img width="674" height="109" alt="image" src="https://github.com/user-attachments/assets/3d4970ae-56df-4981-ab31-504713fdbd0b" /> <br>

**Disadvantages of SMTP:**
- The first is that sending an email using SMTP does not return a usable delivery confirmation. Although the specifications of the protocol provide for this type of notification, its formatting is not specified by default, so that usually only an English-language error message, including the header of the undelivered message, is returned.<br>
- Users are not authenticated when a connection is established, and the sender of an email is therefore unreliable. As a result, open SMTP relays are often misused to send spam en masse. The originators use arbitrary fake sender addresses for this purpose to not be traced (mail spoofing). Today, many different security techniques are used to prevent the misuse of SMTP servers. For example, suspicious emails are rejected or moved to quarantine (spam folder). For example, responsible for this are the identification protocol [DomainKeys](https://dkim.org/) (DKIM), the [Sender Policy Framework](https://dmarcian.com/what-is-spf/) (SPF).<br>
--> For this purpose, an extension for SMTP has been developed called Extended SMTP (ESMTP). When people talk about SMTP in general, they usually mean ESMTP. ESMTP uses TLS, which is done after the EHLO command by sending STARTTLS. This initializes the SSL-protected SMTP connection, and from this moment on, the entire connection is encrypted, and therefore more or less secure. Now [AUTH PLAIN](https://www.samlogic.net/articles/smtp-commands-reference-auth.htm) extension for authentication can also be used safely.<br>

**Dangerous Settings**
- To prevent the sent emails from being filtered by spam filters and not reaching the recipient, the sender can use a relay server that the recipient trusts. It is an SMTP server that is known and verified by all others. As a rule, the sender must authenticate himself to the relay server before using it.<br>
- Often, administrators have no overview of which IP ranges they have to allow. This results in a misconfiguration of the SMTP server that we will still often find in external and internal penetration tests. Therefore, they allow all IP addresses not to cause errors in the email traffic and thus not to disturb or unintentionally interrupt the communication with potential and current customers.<br>
- With this setting, this SMTP server can send fake emails and thus initialize communication between multiple parties. Another attack possibility would be to spoof the email and read it.<br>
```
# Open Relay Configuration
mynetworks = 0.0.0.0/0
```



