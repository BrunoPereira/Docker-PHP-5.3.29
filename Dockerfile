FROM debian:jessie
MAINTAINER https://github.com/BrunoPereira/

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      php5-pecl-http \
      librecode0 \
      libmysqlclient-dev \
      libmcrypt-dev \
      libjpeg-dev \
      libpng12-dev \
      libxml2 \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

# phpize & broker deps
RUN apt-get update && apt-get install -y --no-install-recommends \
      autoconf \
      file \
      g++ \
      gcc \
      libc-dev \
      make \
      pkg-config \
      re2c \
      automake \
      libtool \
      libtool-bin 
      protobuf-compiler \
      protobuf-c-compiler \
      libprotobuf-dev \
      libprotobuf9 \
      libprotobuf-lite9\ 
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV GPG_KEYS 0B96609E270F565C13292B24C13C70B87267B52D 0A95E9A026542D53835E3F3A7DEC4E69FC9C83D7 0E604491
RUN set -xe \
  && for key in $GPG_KEYS; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

# compile openssl, otherwise --with-openssl won't work
RUN OPENSSL_VERSION="1.0.2d" \
      && cd /tmp \
      && mkdir openssl \
      && curl -sL "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" -o openssl.tar.gz \
      && curl -sL "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz.asc" -o openssl.tar.gz.asc \
      && gpg --verify openssl.tar.gz.asc \
      && tar -xzf openssl.tar.gz -C openssl --strip-components=1 \
      && cd /tmp/openssl \
      && ./config && make && make install \
      && rm -rf /tmp/*

ENV PHP_VERSION 5.3.29

# php 5.3 needs older autoconf
# --enable-mysqlnd is included below because it's harder to compile after the fact the extensions are (since it's a plugin for several extensions, not an extension in itself)
RUN buildDeps=" \
                autoconf2.13 \
                libcurl4-openssl-dev \
                libreadline6-dev \
                librecode-dev \
                libgeoip1 \
                libssl-dev \
                libxml2-dev \
                xz-utils \
                bzip2 \
                libevent-dev \
                libxpm-dev \
      " \
      && set -x \
      && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
      && curl -SL "http://php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror" -o php.tar.xz \
      && curl -SL "http://php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror" -o php.tar.xz.asc \
      && gpg --verify php.tar.xz.asc \
      && mkdir -p /usr/src/php \
      && tar -xof php.tar.xz -C /usr/src/php --strip-components=1 \
      && rm php.tar.xz* \
      && cd /usr/src/php \
      && ./configure \
            --with-config-file-path="$PHP_INI_DIR" \
            --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
            --enable-fpm \
            --with-fpm-user=www-data \
            --with-fpm-group=www-data \
            --disable-cgi \
            --with-curl \
            --with-openssl=/usr/local/ssl \
            --with-readline \
            --with-recode \
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
            --with-gd \
            --with-mcrypt \
            --with-jpeg-dir=/usr \
            --with-png-dir=/usr \
            --enable-zip \
      && make -j"$(nproc)" \
      && make install \
      && { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
      && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
      && make clean

   #### Install PHP extensions
   # Install Broker - PHP extension
RUN     cd /tmp \
        && curl -sL "https://github.com/BrunoPereira/Docker-PHP-5.3.29/broker.tar.xz" broker.tar.xz \
        && tar -xzf broker.tar.xz -C broker \
        && cd /tmp/broker/clients/c-component/libsapo-broker2 \
        && ./bootstrap && ./configure && make all && make install \
        && cd /tmp/broker/clients/php-ext-component/ \
        && phpize && ./configure && make && make install \
        && libtool --finish /tmp/broker/clients/php-ext-component/modules \
        && echo "extension=sapobroker.so" > /usr/local/etc/php/conf.d/sapobroker.ini \
        && ln -s /usr/local/lib/libsapo-broker2.so.2.1.0 /usr/lib/libsapo-broker2.so \
        && ln -s /usr/local/lib/libsapo-broker2.so.2.1.0 /usr/lib/libsapo-broker2.so.2 \
        && ln -s /usr/local/lib/libsapo-broker2.so.2.1.0 /usr/lib/libsapo-broker2.so.2.1.0

   # Install PHP PECL extensions
RUN     pecl install xdebug-2.2.7 && \
        # no config for xdebug so it won't be active by default
        pecl install memcache-2.2.7 
RUN     echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini 

RUN set -ex \
  && cd /usr/local/etc \
  && if [ -d php-fpm.d ]; then \
    # for some reason, upstream's php-fpm.conf.default has "include=NONE/etc/php-fpm.d/*.conf"
    sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
    cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
  else \
    # PHP 5.x don't use "include=" by default, so we'll create our own simple config that mimics PHP 7+ for consistency
    mkdir php-fpm.d; \
    cp php-fpm.conf.default php-fpm.d/www.conf; \
    { \
      echo '[global]'; \
      echo 'include=etc/php-fpm.d/*.conf'; \
    } | tee php-fpm.conf; \
  fi \
  && { \
    echo '[global]'; \
    echo 'error_log = /proc/self/fd/2'; \
    echo; \
    echo '[www]'; \
    echo '; if we send this to /proc/self/fd/1, it never appears'; \
    echo 'access.log = /proc/self/fd/2'; \
    echo; \
    echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
    echo 'catch_workers_output = yes'; \
  } | tee php-fpm.d/docker.conf \
  && { \
    echo '[global]'; \
    echo 'daemonize = no'; \
    echo; \
    echo '[www]'; \
    echo 'listen = 9000'; \
  } | tee php-fpm.d/zz-docker.conf

WORKDIR /var/www/html

EXPOSE 9000
CMD ["php-fpm"]
