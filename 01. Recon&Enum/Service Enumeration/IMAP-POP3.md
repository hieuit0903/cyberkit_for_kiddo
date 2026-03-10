# Internet Message Access Protocol (IMAP) - Post Office Protocol (POP3)
- With the help of the Internet Message Access Protocol (IMAP), access to emails from a mail server is possible. Unlike the Post Office Protocol (POP3), IMAP allows online management of emails directly on the server and supports folder structures. <br>
- hus, it is a network protocol for the online management of emails on a remote server. The protocol is client-server-based and allows synchronization of a local email client with the mailbox on the server, providing a kind of network file system for emails, allowing problem-free synchronization across several independent clients.<br>
- POP3, on the other hand, does not have the same functionality as IMAP, and it only provides listing, retrieving, and deleting emails as functions at the email server. Therefore, protocols such as IMAP must be used for additional functionalities such as hierarchical mailboxes directly at the mail server, access to multiple mailboxes during a session, and preselection of emails.<br>
- SMTP is usually used to send emails. By copying sent emails into an IMAP folder, all clients have access to all sent mails, regardless of the computer from which they were sent. Another advantage of the Internet Message Access Protocol is creating personal folders and folder structures in the mailbox. This feature makes the mailbox clearer and easier to manage. However, the storage space requirement on the email server increases.<br>

**IMAP/POP3 Enumeration Cheat Sheet**
|Key/Command|Description|
|:----|:----|
|sudo nmap <Server_IP> -sV -p110,143,993,995 -sC|Using Nmap|
|curl -k 'imaps://<Server_IP>' --user <user>:<pass>|Using cURL|
|openssl s_client -connect <Server_IP>:pop3s|OpenSSL - TLS Encrypted Interaction POP3|
|openssl s_client -connect <Server_IP>:imaps|OpenSSL - TLS Encrypted Interaction IMAP|

Interact with the IMAP

|Key/Command|Description|
|:----|:----|
|1 LOGIN username password|User's login.|
|1 LIST "" *|Lists all directories.|
|1 CREATE "INBOX"|Creates a mailbox with a specified name.|
|1 DELETE "INBOX"|Deletes a mailbox.|
|1 RENAME "ToRead" "Important"|Renames a mailbox.|
|1 LSUB "" *|Returns a subset of names from the set of names that the User has declared as being active or subscribed.|
|1 SELECT INBOX|Selects a mailbox so that messages in the mailbox can be accessed.|
|1 UNSELECT INBOX|Exits the selected mailbox.|
|1 FETCH [ID] all|Retrieves data associated with a message in the mailbox.|
|1 CLOSE|Removes all messages with the Deleted flag set.|
|1 LOGOUT|Closes the connection with the IMAP server.|

Interact with the POP3

|Key/Command|Description|
|:----|:----|
|USER username|Identifies the user.|
|PASS password|Authentication of the user using its password.|
|STAT|Requests the number of saved emails from the server.|
|LIST|Requests from the server the number and size of all emails.|
|RETR id|Requests the server to deliver the requested email by ID.|
|DELE id|Requests the server to delete the requested email by ID.|
|CAPA|Requests the server to display the server capabilities.|
|RSET|Requests the server to reset the transmitted information.|
|QUIT|Closes the connection with the POP3 server.|

