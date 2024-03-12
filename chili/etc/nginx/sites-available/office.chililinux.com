#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# Subdomínio localhost
# Subdomínio chilios.chililinux.com
# Subdomínio office.chililinux.com
# Subdomínio chilios.chilios.com.br
# Subdomínio office.chilios.com.br
server {
   listen 80;
   listen [::]:80;
   server_name localhost chilios.chililinux.com office.chililinux.com
   chilios.chilios.com.br office.chilios.com.br;
   types_hash_max_size 4096;

   location / {
      root /github/ChiliOS;
      index index.html index.htm index.php;
      autoindex on;
      autoindex_exact_size off;
      autoindex_localtime off;
      autoindex_format xml;
#     xslt_stylesheet /usr/share/nginx/html/sort.xslt;
      xslt_stylesheet /usr/share/nginx/html/autoindex.xslt;
      try_files $uri $uri/ =404;
   }
   #     include fcgiwrap.conf;
   #     include php_fastcgi.conf;
   location = /robots.txt {
      return 200 "User-agent: *\nDisallow: /\n";
   }
}
