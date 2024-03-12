#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# begin Subdomínio packages.chililinux.com
server {
   listen 80;
   listen [::]:80;
   server_name packages.chililinux.com;
   if ($host = packages.chililinux.com) {
      #return 301 https://packages.chililinux.com:92/vg/void-mirror$request_uri;
      #return 301 https://packages.chililinux.com/vg/void-mirror$request_uri;
      return 301 https://$server_name$request_uri;
   }
   return 404; # managed by Certbot
}
server {
   server_name packages.chililinux.com;
   listen 443 ssl; # managed by Certbot
   ssl_certificate /etc/letsencrypt/live/packages.chililinux.com/fullchain.pem; # managed by Certbot
   ssl_certificate_key /etc/letsencrypt/live/packages.chililinux.com/privkey.pem; # managed by Certbot
   include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
   ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

   root /vg/void-mirror;
   index index.html index.htm index.xml;
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
# end
