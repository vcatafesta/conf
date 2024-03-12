#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# Subdomínio void.chililinux.com
server {
   listen 80;
   listen [::]:80;
   server_name void.chililinux.com;
   if ($host = void.chililinux.com) {
      #return 301 https://void.chililinux.com:92/vg/void-mirror$request_uri;
      #return 301 https://void.chililinux.com/vg/void-mirror$request_uri;
      return 301 https://$server_name$request_uri;
   }
   return 404; # managed by Certbot
}

# Subdomínio void.chililinux.com
server {
   server_name void.chililinux.com;

   # Configuração do SSL para o subdomínio void.chililinux.com
   #listen [::]:443 ssl ipv6only=on; # managed by Certbot
   listen 443 ssl; # managed by Certbot
   ssl_certificate /etc/letsencrypt/live/void.chililinux.com/fullchain.pem; # managed by Certbot
   ssl_certificate_key /etc/letsencrypt/live/void.chililinux.com/privkey.pem; # managed by Certbot
   include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
   ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

   # Configuração do servidor web para o subdomínio void.chililinux.com
   #location /vg/void-mirror {
   # Configuração do seu site com o root correto para /vg/void-mirror no subdomínio void.chililinux.com HTTPS
   root /vg/void-mirror;
   index index.html index.htm index.xml;
   #}
   # Configuração adicional do servidor web, se necessário, para o subdomínio void.chililinux.com HTTPS
   # location / {
   #     # Configuração do seu site com o root correto no subdomínio void.chililinux.com HTTPS
   # }
   location / {
		autoindex on;
		autoindex_exact_size off;
		autoindex_localtime off;
		autoindex_format xml;
#		xslt_stylesheet /usr/share/nginx/html/sort.xslt;
		xslt_stylesheet /usr/share/nginx/html/autoindex.xslt;
      try_files $uri $uri/ =404;
   }
   location = /robots.txt {
      return 200 "User-agent: *\nDisallow: /\n";
   }
}
