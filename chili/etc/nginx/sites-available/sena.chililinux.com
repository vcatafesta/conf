#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# Subdomínio sena.chililinux.com
# Subdomínio sena.chilios.com.br
server {
    listen 80;
    listen [::]:80;
    server_name sena.chilios.com.br sena.chililinux.com;
    root /home/vcatafesta/var/www/html/vcatafesta/public_html;
    autoindex on;
    index index.html index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location /sena {
        alias /home/vcatafesta/var/www/html/vcatafesta/public_html;
    }

    location /chili {
        alias /home/vcatafesta/var/www/html/chili;
    }

    location /mega {
        alias /home/vcatafesta/var/www/html/megasena;
    }

   location /speedtest/ {
#     proxy_pass http://localhost:3000;
#      proxy_set_header Host $host;
#     proxy_set_header X-Real-IP $remote_addr;
#      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    #  proxy_pass http://localhost:3000/;
   #   proxy_set_header Host $host;
  #    proxy_set_header X-Real-IP $remote_addr;
 #     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#      proxy_set_header X-Forwarded-Proto $scheme;

#       proxy_pass http://localhost:3000/;
 #       proxy_http_version 1.1;
  #      proxy_set_header Upgrade $http_upgrade;
   #     proxy_set_header Connection "upgrade";

#      proxy_pass http://127.0.0.1:3000;
 #     proxy_set_header Host $host;
  #    proxy_set_header X-Real-IP $remote_addr;
   #   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#      return 301 http://$server_name:3000$request_uri;
#      proxy_pass http://$server_name:3000;
       rewrite ^/speedtest(.*)$ http://$server_name:3000 permanent;
       proxy_pass http://$server_name:3000/;
   }

    location /vcgi {
        root /home/vcatafesta/var/www/html;
        fastcgi_pass unix:/run/fcgiwrap.socket;
        fastcgi_index index.php;
        include fastcgi.conf;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param QUERY_STRING    $query_string;
        rewrite ^/cgi-bin/(.*)\.cgi /$1.cgi break;
        rewrite ^/cgi-bin/(.*)\.sh /$1.sh break;
        rewrite ^/cgi-bin/(.*)\.py /$1.py break;
        rewrite ^/cgi-bin/(.*)\.pl /$1.pl break;
        rewrite ^/cgi-bin/(.*)\.lua /$1.lua break;
        rewrite ^/cgi-bin/(.*)\.rb /$1.rb break;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
        fastcgi_index index.php;
        include fastcgi.conf;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
