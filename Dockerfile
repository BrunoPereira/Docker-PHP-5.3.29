FROM centos:6
MAINTAINER https://github.com/BrunoPereira/

RUN yum -y update && yum clean all
RUN yum -y install wget \
        libpng-devel \
        libjpeg-devel \
        libevent-1.4-2 \
        libmcrypt-devel.x86_64 \
        libxml2-devel \
        libssl-dev \
        openssl-devel \
        curl-devel \
        php-pear \
        php-devel \
        g++ \
        gcc \
        libc-dev \
        make && \
        yum clean all

# Download PHP src and configure
RUN export PHP_VER="5.3.29" && \
    wget -qO- http://php.net/get/php-${PHP_VER}.tar.gz/from/this/mirror | tar xz -C /tmp && \
    cd /tmp/php-${PHP_VER} && \
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/php \
        --localstatedir=/var \
        --with-config-file-path=/etc/php \
        --with-config-file-scan-dir=/etc/php/conf.d \
        --enable-fpm \
        --with-zlib \
        --enable-inifile \
        --enable-bcmath \
        --enable-mbstring \
        --enable-calendar \
        --without-sqlite3 \
        --without-pdo_sqlite \
        --enable-sockets \
        --enable-shmop \
        --disable-shared \
        --enable-soap \
        --with-mysql=mysqlnd \
        --disable-phar \
        --with-curl \
        --with-openssl \
        --with-gd \
        #--with-mcrypt \
        --with-jpeg-dir=/usr \
        --with-png-dir=/usr \
        --enable-zip &&\

    # Configure PHP extensions
        mkdir -p /etc/php/conf.d && \
        echo 'extension=curl.so' > /etc/php/conf.d/curl.ini && \
        echo 'extension=gd.so' > /etc/php/conf.d/gd.ini && \
        echo 'extension=mcrypt.so' > /etc/php/conf.d/mcrypt.ini && \
        echo 'extension=soap.so' > /etc/php/conf.d/soap.ini && \

        pecl install xdebug-2.2.7 && \
        # no config for xdebug so it won't be active by default
        pecl install memcache-2.2.7 # && \
        echo 'extension=memcache.so' > /etc/php/conf.d/memcache.ini && \





RUN sed -e 's/127.0.0.1:9000/9000/' \
        -e '/allowed_clients/d' \
        -e '/catch_workers_output/s/^;//' \
        -e '/error_log/d' \
        -i /etc/php-fpm.d/www.conf
#RUN mkdir -p /var/www/html
EXPOSE 9000
ENTRYPOINT /usr/sbin/php-fpm --nodaemonize
