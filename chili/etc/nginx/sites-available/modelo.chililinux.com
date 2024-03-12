#sudo mkdir /etc/nginx/ssl
#sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#    -keyout /etc/nginx/ssl/key.pem \
#    -out /etc/nginx/ssl/cert.pem

#sudo apt-get install certbot python3-certbot-nginx
#sudo certbot --nginx -d meusite.com -d www.meusite.com

# Subdomínio modelo.chililinux.com
server {
	listen 80;
	listen [::]:80;
	server_name modelo.chililinux.com;

	root /vg/void-mirror;
	index index.html index.htm index.xml index.php;

	location / {
      autoindex on;
      autoindex_exact_size off;
      autoindex_localtime off;
      autoindex_format xml;
#     xslt_stylesheet /usr/share/nginx/html/sort.xslt;
#     xslt_stylesheet /usr/share/nginx/html/autoindex.xslt;
      xslt_stylesheet /usr/share/nginx/html/custom.xslt;
      try_files $uri $uri/ =404;
	}
	location = /robots.txt {
		return 200 "User-agent: *\nDisallow: /\n";
	}
}
