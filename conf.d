#
# The default server
#
server {
    listen       80;
    server_name  35.172.128.148;

    #charset koi8-r;

    #access_log  logs/host.access.log  main;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;

    root   /var/www/html;


    location / {
        index  index.html index.htm index.php;

        #try_files $uri $uri/ /index.php?q=$request_uri;

    }

    location ~* ^.*/portfolio/(.*\.(jpg|jpeg|png|gif|ico|css|js))$ {
        alias /var/www/html/stage/portfolio/$1;
        expires 15d;
        add_header Cache-Control no-cache;
 }

    # for portfolio non optimized

    location ~* ^.*/portfolio-.*/$ {
        try_files $uri /portfolio/index.html;
    }

    location ~* ^.*/portfolio-expires/(.*\.(jpg|jpeg|png|gif|ico|css|js))$ {
        alias /var/www/html/stage/portfolio/$1;
        expires 15d;
    }

    location ~* ^.*/portfolio-no-store/(.*\.(jpg|jpeg|png|gif|ico|css|js))$ {
        alias /var/www/html/stage/portfolio/$1;
        add_header Cache-Control no-store;
    }

    location ~* ^.*/portfolio-no-cache/(.*\.(jpg|jpeg|png|gif|ico|css|js))$ {
        alias /var/www/html/stage/portfolio/$1;
        add_header Cache-Control no-cache;
    }




    location /admin {
        auth_basic "Administrator Login";
        auth_basic_user_file /var/www/admin/.htpasswd;
    }

    #!!! IMPORTANT !!! We need to hide the password file from prying eyes
    # This will deny access to any hidden file (beginning with a .period)
    location ~ /\. { deny  all; }

    error_page  404              /404.html;
    location = /404.html {
        root   /usr/share/nginx/html;
    }

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
