FROM nginx:1.15-alpine

# Remove the default Nginx configuration file and add cert directory
RUN rm -v /etc/nginx/nginx.conf


# Add ngnix config file
ADD nginx.conf /etc/nginx/


# Add certifcate (crt and key)
ADD ca.crt /etc/nginx/certs/
ADD client.crt /etc/nginx/certs/
ADD server.crt /etc/nginx/certs/
ADD server.key /etc/nginx/certs/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Expose ports 80 to redirect
EXPOSE 80 443

CMD ["nginx"]