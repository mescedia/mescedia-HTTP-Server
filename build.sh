#!/bin/bash

# groupadd -g 12914 mescedia-system
# useradd mescedia -u 12914 -g 12914 -m -s /usr/sbin/nologin


git clone https://github.com/sto/ngx_http_auth_pam_module.git
cd ngx_http_auth_pam_module
git checkout v1.5.5
cd ..


git clone https://github.com/openresty/headers-more-nginx-module.git
cd headers-more-nginx-module
git checkout v0.34
cd ..

git clone https://github.com/arut/nginx-dav-ext-module.git
cd nginx-dav-ext-module
git checkout v3.0.0
cd ..

git clone https://github.com/nginx/nginx
cd nginx
git checkout release-1.25.1

./auto/configure \
    --prefix=/usr/local/nginx \
    --sbin-path=/usr/local/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf   \
    --error-log-path=/var/log/nginx/error.log   \
    --http-log-path=/var/log/nginx/access.log   \
    --pid-path=/run/nginx.pid   \
    --lock-path=/run/lock/subsys/nginx  \
    --user=mescedia \
    --group=mescedia-system     \
    --with-file-aio \
    --with-http_ssl_module  \
    --with-http_v2_module   \
    --with-http_image_filter_module     \
    --with-http_realip_module   \
    --with-http_addition_module \
    --with-http_geoip_module    \
    --with-http_sub_module  \
    --with-http_gunzip_module   \
    --with-http_gzip_static_module  \
    --with-http_random_index_module \
    --with-http_secure_link_module  \
    --with-http_stub_status_module  \
    --with-http_dav_module  \
    --with-pcre \
    --with-http_auth_request_module \
    --add-module=./../headers-more-nginx-module     \
    --add-module=./../ngx_http_auth_pam_module  \
    --add-module=./../nginx-dav-ext-module  

make && make install

