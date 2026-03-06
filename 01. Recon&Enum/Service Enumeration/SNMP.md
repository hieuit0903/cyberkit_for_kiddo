# Simple Network Management Protocol - SNMP
- Simple Network Management Protocol (SNMP) was created to monitor network devices. In addition, this protocol can also be used to handle configuration tasks and change settings remotely. The current version is SNMPv3, which increases the security of SNMP in particular, but also the complexity of using this protocol. 
- SNMP-enabled hardware includes routers, switches, servers, IoT devices, and many other devices that can also be queried and controlled using this standard protocol. Thus, it is a protocol for monitoring and managing network devices. In addition, configuration tasks can be handled, and settings can be made remotely using this standard.
- In addition to the pure exchange of information, SNMP also transmits control commands using agents over UDP port 161. The client can set specific values in the device and change options and settings with these commands. While in classical communication, it is always the client who actively requests information from the server, SNMP also enables the use of so-called traps over UDP port 162
- For the SNMP client and server to exchange the respective values, the available SNMP objects must have unique addresses known on both sides. This addressing mechanism is an absolute prerequisite for successfully transmitting data and network monitoring using SNMP.


**SNMP Enumeration Cheat Sheet**
- For footprinting SNMP, we can use tools like snmpwalk, onesixtyone, and braa. Snmpwalk is used to query the OIDs with their information. Onesixtyone can be used to brute-force the names of the community strings since they can be named arbitrarily by the administrator. Since these community strings can be bound to any source, identifying the existing community strings can take quite some time.
  
|Key/Command|Description|
|:----|:----|
|snmpwalk -v2c -c <community_string> <Server_IP>|Using SNMPwalk|
|onesixtyone -c /opt/useful/seclists/Discovery/SNMP/snmp.txt <Server_IP>|Using OneSixtyOne|
|braa <community_string>@<IP>:.1.3.6.*|Using braa (Once we know a community string, we can use it with braa to brute-force the individual OIDs and enumerate the information behind them.)|

```
# Installation
$ sudo apt install onesixtyone
$ sudo apt install braa
```

**Management Information Base (MIB)**
- To ensure that SNMP access works across manufacturers and with different client-server combinations, the Management Information Base (MIB) was created. MIB is an independent format for storing device information.
- A MIB is a text file in which all queryable SNMP objects of a device are listed in a standardized tree hierarchy. It contains at least one Object Identifier (OID), which, in addition to the necessary unique address and a name, also provides information about the type, access rights, and a description of the respective object.
- MIB files are written in the Abstract Syntax Notation One (ASN.1) based ASCII text format. The MIBs do not contain data, but they explain where to find which information and what it looks like, which returns values for the specific OID, or which data type is used.

**OID**
- An OID represents a node in a hierarchical namespace. A sequence of numbers uniquely identifies each node, allowing the node's position in the tree to be determined.
- The longer the chain, the more specific the information. Many nodes in the OID tree contain nothing except references to those below them. The OIDs consist of integers and are usually concatenated by dot notation. We can look up many MIBs for the associated OIDs in the Object Identifier Registry.

**SNMPv3**
- The security has been increased enormously for SNMPv3 by security features such as authentication using username and password and transmission encryption (via pre-shared key) of the data. However, the complexity also increases to the same extent, with significantly more configuration options than v2c.

**Community Strings**
- Community strings can be seen as passwords that are used to determine whether the requested information can be viewed or not. It is important to note that many organizations are still using SNMPv2, as the transition to SNMPv3 can be very complex, but the services still need to remain active.<br>
- This causes many administrators a great deal of concern and creates some problems they are keen to avoid. The lack of knowledge about how the information can be obtained and how we as attackers use it makes the administrators' approach seem inexplicable.
- At the same time, the lack of encryption of the data sent is also a problem. Because every time the community strings are sent over the network, they can be intercepted and read.
