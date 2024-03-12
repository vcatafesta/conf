#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# Subdomínio archlinux.chililinux.com
server {
   listen 80;
   listen [::]:80;
   server_name archlinux.chililinux.com;
   if ($host = archlinux.chililinux.com) {
      #return 301 https://archlinux.chililinux.com:93/vg/arch-mirror/archlinux$request_uri;
      #return 301 https://archlinux.chililinux.com/vg/arch-mirror/archlinux$request_uri;
      return 301 https://$server_name$request_uri;
      #return 301 https://archlinux.chililinux.com/vg/arch-mirror/archlinux$request_uri;
   }
   return 404; # managed by Certbot
}

# Subdomínio archlinux.chililinux.com
server {
   server_name archlinux.chililinux.com;

   # Configuração do servidor web para o subdomínio archlinux.chililinux.com
   #location /vg/arch-mirror/archlinux {
   # Configuração do seu site com o root correto para /vg/arch-mirror/archlinux no subdomínio archlinux.chililinux.com HTTPS
   root /vg/arch-mirror/archlinux;
   index index.html index.htm index.xml;
   autoindex on;
   #}
   # Configuração adicional do servidor web, se necessário, para o subdomínio archlinux.chililinux.com HTTPS
   # location / {
   #     # Configuração do seu site com o root correto no subdomínio archlinux.chililinux.com HTTPS
   # }
   location / {
      autoindex on;
      autoindex_exact_size off;
      autoindex_localtime off;
      autoindex_format xml;
#     xslt_stylesheet /usr/share/nginx/html/sort.xslt;
      xslt_stylesheet /usr/share/nginx/html/autoindex.xslt;
      try_files $uri $uri/ =404;
   }
   location = /robots.txt {
      return 200 "User-agent: *\nDisallow: /\n";
   }
   listen [::]:443 ssl ipv6only=on; # managed by Certbot
   listen 443 ssl; # managed by Certbot
   ssl_certificate /etc/letsencrypt/live/archlinux.chililinux.com/fullchain.pem; # managed by Certbot
   ssl_certificate_key /etc/letsencrypt/live/archlinux.chililinux.com/privkey.pem; # managed by Certbot
   include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
   ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
