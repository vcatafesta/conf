#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# begin Subdomínio linuxfromscratch.chililinux.com linuxfromscratch.chilios.com.b
server {
   listen 80;
   listen [::]:80;
   server_name linuxfromscratch.chililinux.com linuxfromscratch.chilios.com.b
   types_hash_max_size 4096;
   location / {
      root /srv/http/lfs;
      index index.html index.htm index.php;
      autoindex_format xml;
#     xslt_stylesheet autoindex/autoindex.xslt;
#     xslt_stylesheet autoindex/sort.xslt;
#     xslt_stylesheet autoindex/custom.xslt;
      xslt_stylesheet autoindex/arcolinux.xslt;
      try_files $uri $uri/ =404;
   }
   location /packages {
      try_files $uri $uri/ =404;
   }
   #     include fcgiwrap.conf;
   #     include php_fastcgi.conf;
   location = /robots.txt {
      return 200 "User-agent: *\nDisallow: /\n";
   }
}
# end
