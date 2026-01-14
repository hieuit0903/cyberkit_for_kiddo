# Web Fuzzing
**Methodology**

Web fuzzing is a critical technique in web application security to identify vulnerabilities by testing various inputs. It involves automated testing of web applications by providing unexpected or random data to detect potential flaws that attackers could exploit.<br>

**Tools:**
- [FFUF](https://github.com/ffuf/ffuf/) - FFUF (Fuzz Faster U Fool) is a fast web fuzzer written in Go. It excels at quickly enumerating directories, files, and parameters within web applications. Its flexibility, speed, and ease of use make it a favorite among security professionals and enthusiasts
- [Gobuster](https://github.com/OJ/gobuster) - Gobuster is another popular web directory and file fuzzer. It's known for its speed and simplicity, making it a great choice for beginners and experienced users alike.

**Directory and File Fuzzing**

- Web applications often have directories and files that are not directly linked or visible to users. These hidden resources may contain sensitive information, backup files, configuration files, or even old, vulnerable application versions. Directory and file fuzzing aims to uncover these hidden assets, providing attackers with potential entry points or valuable information for further exploitation.<br>
```
### Dir Fuzzing
$ ffuf -w <path_to_wordlist> -u http://SERVER_IP:PORT/FUZZ

### File Fuzzing
$ ffuf -w <path_to_wordlist> -u http://IP:PORT/zed/FUZZ -e .php,.html,.txt,.bak,.js -v 
```

**Recursive Fuzzing**

- So far, we've focused on fuzzing directories directly under the web root and files within a single directory. But what if our target has a complex structure with multiple nested directories? Manually fuzzing each level would be tedious and time-consuming. This is where recursive fuzzing comes in handy.
```
$ ffuf -w <path_to_wordlist> -ic -v -u http://SERVER_IP:PORT/FUZZ -e .html -recursion 
```

**Virtual Host and Subdomain Fuzzing**

|Feature|Virtual Hosts|Subdomains|
|:----|:----|:----|
|Identification|Identified by the Host header in HTTP requests|Identified by DNS records, pointing to specific IP addresses|
|Purpose|Primarily used to host multiple websites on a single server|Used to organize different sections or services within a website|
|Security Risks|Misconfigured vhosts can expose internal applications or sensitive data|Subdomain takeover vulnerabilities can occur if DNS records are mismanaged|
```
### vHost Fuzzing
$ gobuster vhost -u http|https://<domain_name>:[port] -w <path_to_wordlist> --append-domain

### Subdomain Fuzzing
$ gobuster dns -d <domain_name> -w <path_to_wordlist>
$ ffuf -w <path_to_wordlist> -u https://SERVER_IP/ -H "Host:FUZZ.domain.xyz"
```

**Attack Fuzzing**
```
$ ffuf -w /usr/share/wordlists/SecLists/Fuzzing/command-injection-commix.txt -u http://SERVER_IP:Port/ -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "param=FUZZ"
```
