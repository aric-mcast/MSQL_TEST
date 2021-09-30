server {
    listen 80;
	server_name test.aric-mcast.dev;

    location ~ /.well-known/acme-challenge{
        allow all;
        root /var/www/html;
    }
    location / {
        return 301 https://test.aric-mcast.dev$request_uri;
    }
}

server {
     listen 443 ssl http2;
     server_name test.aric-mcast.dev;
     root /var/www/html;

     ssl on;
     server_tokens off;
     ssl_certificate /etc/letsencrypt/live/test.aric-mcast.dev/fullchain.pem;
     ssl_certificate_key /etc/letsencrypt/live/test.aric-mcast.dev/privkey.pem;
     
     ssl_buffer_size 8k;
     ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
     ssl_prefer_server_ciphers on;
     ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

    location / {
          try_files $uri $uri/ /index.php$is_args$args;
    }
    location ~ \.php$ {
            try_files $uri =404;
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass wordpress:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $fastcgi_path_info;
    }
    location ~ /\.ht {
            deny all;
    }
    location = /favicon.ico { 
            log_not_found off; access_log off; 
    }
    location = /favicon.svg { 
            log_not_found off; access_log off; 
    }
    location = /robots.txt { 
            log_not_found off; access_log off; allow all; 
    }
    location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
            expires max;
            log_not_found off;
    }
}