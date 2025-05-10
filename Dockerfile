FROM php:7.4-apache
# Cambia le sorgenti e disattiva il controllo validità
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Ora esegui apt-get update e install
RUN apt-get update && apt-get install -yq \
    libfreetype6-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev

RUN docker-php-ext-install gd
COPY . /var/www/html/
