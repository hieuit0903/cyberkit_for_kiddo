# Domain Name System - DNS
- Domain Name System (DNS) is an integral part of the Internet. For example, through domain names, such as youtube.com or google.com, we can reach the web servers that the hosting provider has assigned one or more specific IP addresses.<br>
- DNS is mainly unencrypted. Devices on the local WLAN and Internet providers can therefore hack in and spy on DNS queries. Since this poses a privacy risk, there are now some solutions for DNS encryption. By default, IT security professionals apply DNS over TLS (DoT) or DNS over HTTPS (DoH) here. In addition, the network protocol DNSCrypt also encrypts the traffic between the computer and the name server.<br>
- The information is distributed over many thousands of name servers. Globally distributed DNS servers translate domain names into IP addresses and thus control which server a user can reach via a particular domain. There are several types of DNS servers that are used worldwide:

|Server Type|Description|
|:----|:----|
|DNS Root Server|The root servers of the DNS are responsible for the top-level domains (TLD). As the last instance, they are only requested if the name server does not respond. Thus, a root server is a central interface between users and content on the Internet, as it links domain and IP address. The Internet Corporation for Assigned Names and Numbers (ICANN) coordinates the work of the root name servers. There are 13 such root servers around the globe.|
|Authoritative Nameserver|Authoritative name servers hold authority for a particular zone. They only answer queries from their area of responsibility, and their information is binding. If an authoritative name server cannot answer a client's query, the root name server takes over at that point. Based on the country, company, etc., authoritative nameservers provide answers to recursive DNS nameservers, assisting in finding the specific web server(s).|
|Non-authoritative Nameserver|Non-authoritative name servers are not responsible for a particular DNS zone. Instead, they collect information on specific DNS zones themselves, which is done using recursive or iterative DNS querying.|
|Caching DNS Server|Caching DNS servers cache information from other name servers for a specified period. The authoritative name server determines the duration of this storage.|
|Forwarding Server|Forwarding servers perform only one function: they forward DNS queries to another DNS server.|
|Resolver|Resolvers are not authoritative DNS servers but perform name resolution locally in the computer or router.|

- The DNS does not only link computer names and IP addresses. It also stores and outputs additional information about the services associated with a domain. A DNS query can therefore also be used, for example, to determine which computer serves as the e-mail server for the domain in question or what the domain's name servers are called.
<img width="1171" height="710" alt="image" src="https://github.com/user-attachments/assets/5cfd2742-4783-4ded-8642-157b4a8d7487" />

- Different DNS records are used for the DNS queries, which all have various tasks. Moreover, separate entries exist for different functions since we can set up mail servers and other servers for a domain.
- The SOA record is located in a domain's zone file and specifies who is responsible for the operation of the domain and how DNS information for the domain is managed.

|DNS Record|Description|
|:----|:----|
|A|Returns an IPv4 address of the requested domain as a result.|
|AAAA|Returns an IPv6 address of the requested domain.|
|MX|Returns the responsible mail servers as a result.|
|NS|Returns the DNS servers (nameservers) of the domain.|
|TXT|This record can contain various information. The all-rounder can be used, e.g., to validate the Google Search Console or validate SSL certificates. In addition, SPF and DMARC entries are set to validate mail traffic and protect it from spam.|
|CNAME|This record serves as an alias for another domain name. If you want the domain www.zed99.net to point to the same IP as zed99.net, you would create an A record for zed99.net and a CNAME record for www.zed99.net|
|PTR|The PTR record works the other way around (reverse lookup). It converts IP addresses into valid domain names.|
|SOA|Provides information about the corresponding DNS zone and email address of the administrative contact.|

**DNS Enumeration Cheat Sheet**
- The footprinting at DNS servers is done as a result of the requests we send. So, first of all, the DNS server can be queried as to which other name servers are known.<br>
- We do this using the NS record and the specification of the DNS server we want to query using the @ character. This is because if there are other DNS servers, we can also use them and query the records. However, other DNS servers may be configured differently and, in addition, may be permanent for other zones.<br>

|Key/Command|Description|
|:----|:----|
|dig ns abc.com @<Server_IP>|DIG - NS Query|
|dig CH TXT version.bind <Server_IP>|DIG - Version Query|
|dig any abc.com @<Server_IP>|DIG - ANY Query (option ANY to view all available records)|
|dig axfr abc.com @<Server_IP>|DIG - AXFR Zone Transfer|
|dig axfr internal.abc.com @<Server_IP>|DIG - AXFR Zone Transfer - Internal|
|dig +trace abc.com|Shows the full path of DNS resolution.|
|dig +short abc.com|Provides a short, concise answer to the query.|
|dig +noall +answer abc.com|Displays only the answer section of the query output.|
|dig abc.com [A\|AAA\|AAAA\|MX\|TXT\NS]|Retrieves record for the domain.|
|dnsenum --dnsserver <Server_IP> --enum -p 0 -s 0 -o subdomains.txt -f /opt/useful/seclists/Discovery/DNS/subdomains-top1million-110000.txt abc.com|Using DNSenum for Subdomain Brute Forcing|
```
# Bash - Subdomain Brute Forcing
for sub in $(cat /opt/useful/seclists/Discovery/DNS/subdomains-top1million-110000.txt);do dig $sub.abc.com @<Server_IP> | grep -v ';\|SOA' | sed -r '/^\s*$/d' | grep $sub | tee -a subdomains.txt;done
```

**More Tools:**
- DNS reconnaissance involves utilizing specialized tools designed to query DNS servers and extract valuable information. Here are some of the most popular and versatile tools in the arsenal of web recon professionals:

|Tool|Key Features|Use Cases|
|:----|:----|:----|
|nslookup|Simpler DNS lookup tool, primarily for A, AAAA, and MX records.|Basic DNS queries, quick checks of domain resolution and mail server records.|
|host|Streamlined DNS lookup tool with concise output.|Quick checks of A, AAAA, and MX records.|
|fierce|DNS reconnaissance and subdomain enumeration tool with recursive search and wildcard detection.|User-friendly interface for DNS reconnaissance, identifying subdomains and potential targets.|
|dnsrecon|Combines multiple DNS reconnaissance techniques and supports various output formats.|Comprehensive DNS enumeration, identifying subdomains, and gathering DNS records for further analysis.|
|theHarvester|OSINT tool that gathers information from various sources, including DNS records (email addresses).|Collecting email addresses, employee information, and other data associated with a domain from multiple sources.|
|Online DNS Lookup Services|User-friendly interfaces for performing DNS lookups.|Quick and easy DNS lookups, convenient when command-line tools are not available, checking for domain availability or basic information|
