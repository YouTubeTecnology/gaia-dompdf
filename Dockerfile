FROM php:5.6-apache

# Usa i repository di archivio e disattiva il controllo di validità della Release
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Aggiorna e installa le librerie necessarie
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev && \
    rm -rf /var/lib/apt/lists/*

# Installa estensione GD con supporto a JPEG e FreeType
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd mcrypt

# Copia i file del progetto nel web root
COPY . /var/www/html/
