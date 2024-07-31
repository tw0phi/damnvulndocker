FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y locales apache2 php7.3 wget curl sudo \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && chown -R pentest:pentest /var/www/html

RUN useradd -rm -d /home/pentest -s /bin/bash -g root -G sudo -u 1000 pentest
RUN echo 'pentest:F00b4r_1234!' | chpasswd

ENV LANG en_US.utf8
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_RUN_USER pentest
ENV APACHE_RUN_GROUP pentest
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_LOG_DIR /var/log/apache2

COPY shell.php /var/www/html/shell.php

EXPOSE 80

CMD ["/usr/sbin/apache2", "-DFOREGROUND"]
