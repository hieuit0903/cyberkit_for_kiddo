# Intelligent Platform Management Interface - IPMI
- [Intelligent Platform Management Interface](https://www.thomas-krenn.com/en/wiki/IPMI_Basics) (IPMI) is a set of standardized specifications for hardware-based host management systems used for system management and monitoring. It acts as an autonomous subsystem and works independently of the host's BIOS, CPU, firmware, and underlying operating system.<br>
- IPMI provides sysadmins with the ability to manage and monitor systems even if they are powered off or in an unresponsive state. It operates using a direct network connection to the system's hardware and does not require access to the operating system via a login shell. <br>
- IPMI can also be used for remote upgrades to systems without requiring physical access to the target host. IPMI is typically used in three ways:
  - Before the OS has booted to modify BIOS settings
  - When the host is fully powered down
  - Access to a host after a system failure
- When not being used for these tasks, IPMI can monitor a range of different things such as system temperature, voltage, fan status, and power supplies. It can also be used for querying inventory information, reviewing hardware logs, and alerting using SNMP. The host system can be powered off, but the IPMI module requires a power source and a LAN connection to work correctly.<br>
- IPMI Components:
<img width="700" height="395" alt="image" src="https://github.com/user-attachments/assets/3f92cb57-b7f4-48e1-aadf-5cccbdfe122d" />

**DNS Enumeration Cheat Sheet**
- IPMI communicates over port 623 UDP. Systems that use the IPMI protocol are called Baseboard Management Controllers (BMCs). BMCs are typically implemented as embedded ARM systems running Linux, and connected directly to the host's motherboard.<br>
- BMCs are built into many motherboards but can also be added to a system as a PCI card. Most servers either come with a BMC or support adding a BMC. <br>
- The most common BMCs we often see during internal penetration tests are HP iLO, Dell DRAC, and Supermicro IPMI. If we can access a BMC during an assessment, we would gain full access to the host motherboard and be able to monitor, reboot, power off, or even reinstall the host operating system.<br>
- Gaining access to a BMC is nearly equivalent to physical access to a system. Many BMCs (including HP iLO, Dell DRAC, and Supermicro IPMI) expose a web-based management console, some sort of command-line remote access protocol such as Telnet or SSH, and the port 623 UDP, which, again, is for the IPMI network protocol. <br>

|Key/Command|Description|
|:----|:----|
|sudo nmap -sU --script ipmi-version -p 623 <Server_IP>|Nmap scan using the Nmap ipmi-version NSE script to footprint the service.|
|msf6 > use auxiliary/scanner/ipmi/ipmi_version |Metasploit Version Scan|

- During internal penetration tests, we often find BMCs where the administrators have not changed the default password. Some unique default passwords to keep in our cheatsheets include:

|Product|Username|Password|
|:----|:----|:----|
|Dell iDRAC|root|calvin|
|HP iLO|Administrator|randomized 8-character string consisting of numbers and uppercase letters|
|Supermicro IPMI|ADMIN|ADMIN|


