# ### Note substitute test.local with your FQDN

# # CA
# openssl genrsa -aes256 -out ca.key 4096
# openssl req -new -x509 -key ca.key -days 365 -sha256 -subj "/C=IT/ST=Italy/L=Cremona/O=RD/OU=RD/CN=Client certificate" -out ca.crt

# #Server
# openssl genrsa -aes256 -out server.key 4096
# openssl rsa -in server.key -out server.key
# openssl req -subj "/CN=test.local" -sha256 -new -key server.key -out server.csr
# echo "subjectAltName = DNS:test.local" > extfile.cnf
# openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -extfile extfile.cnf

#Client
openssl genrsa -out client.key 4096
openssl req -subj "/CN=Client certificate/ID=1998" -new -key client.key -out client.csr
echo "extendedKeyUsage = clientAuth" > extfile2.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -extfile extfile2.cnf