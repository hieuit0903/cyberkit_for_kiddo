- Some system information command:
```
uname -r
whoami
netstat
ss
ps
pwd
who
env
lsblk
lsusb
lsof
lspci
```

- Find Files and Directories:
```
$ which python3
$ find / -type f -name *.conf -user root -size +20k -newermt 2020-03-03 -exec ls -al {} \; 2>/dev/null
$ locate *.conf
$ find / -perm -4000 -type f -user root 2>/dev/null
```

- Filter Contents:
```
$ cat /etc/passwd | more
$ less /etc/passwd
$ head /etc/passwd
$ tail /etc/passwd
$ cat /etc/passwd | sort
$ cat /etc/passwd | grep "/bin/bash"
```

```
cut \\ remove specific delimiters and show the words on a line in a specified position
$ cat /etc/passwd | grep -v "false\|nologin" | cut -d":" -f1

root
sync
postgres
mrb34n
cryCry
test01
```
```
tr \\ replace certain characters from a line with characters defined by us
$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " "

root x 0 0 root /root /bin/bash
sync x 4 65534 sync /bin /bin/sync
postgres x 111 117 PostgreSQL administrator,,, /var/lib/postgresql /bin/bash
mrb34n x 1000 1000 mrb3n /home/mrb34n /bin/bash
cryCry x 1001 1001  /home/cryCry /bin/bash
test01 x 1002 1002  /home/test01 /bin/bash
```
```
column \\ display such results in tabular form using the "-t."
$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | column -t

root         x  0     0      root               /root        		 /bin/bash
sync         x  4     65534  sync               /bin         		 /bin/sync
postgres     x  111   117    PostgreSQL         administrator,,,    /var/lib/postgresql		/bin/bash
mrb34n        x  1000  1000   mrb34n              /home/mrb34n  	     /bin/bash
cryCry     x  1001  1001   /home/cryCry     /bin/bash
test01  x  1002  1002   /home/test01  /bin/bash
```
```
awk \\ 
$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}'

root /bin/bash
sync /bin/sync
postgres /bin/bash
mrb34n /bin/bash
cryCry /bin/bash
test01 /bin/bash
```
```
sed \\  change specific names in the whole file or standard input
$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}' | sed 's/bin/ZED/g'

root /ZED/bash
sync /ZED/sync
postgres /ZED/bash
mrb34n /ZED/bash
cryCry /ZED/bash
test01 /ZED/bash
```
- Network Monitor:
```
\\ Outbound Connection Monitor:
netstat -nputw
```
- Iptables:
```
\\ Block Outbound connection:
sudo iptables -A OUTPUT -p tcp -d <IP> -j DROP
\\ Display Outbound Rule:
sudo iptables -L OUTPUT -n -v
```
