FROM centos:7
LABEL Description="php7.4 nginx" VENDOR="q90016200 <q90016200@gmail.com>"


# install common tools
RUN yum install git wget vim ntpdate unzip openssl -y

# zsh
RUN yum install zsh -y
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup Yum Repository - EPEL
RUN yum install epel-release -y
RUN yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

RUN yum update -y && yum install yum-utils -y

# install common tools 2
RUN yum install go -y

# install nginx
RUN yum install nginx -y
RUN systemctl enable nginx

# install php 7.4
RUN yum-config-manager --enable remi-php74
RUN yum --enablerepo=remi-php74 install php php-fpm -y

# install php modules
RUN yum install php-opcache php-pecl-mongodb php-zip php-mysqlnd php-mcrypt php-xml php-mbstring php-curl php-pecl-redis php-pecl-memcached php-gd php-bcmath php-soap -y

RUN sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
RUN sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf
RUN sed -i 's/expose_php\ =\ On/expose_php\ =\ Off/g' /etc/php.ini
RUN sed -i 's/short_open_tag\ =\ Off/short_open_tag\ =\ On/g' /etc/php.ini
RUN sed -i 's/max_execution_time\ =\ 30/max_execution_time\ =\ 600/g' /etc/php.ini
RUN sed -i 's/post_max_size\ =\ 8M/post_max_size\ =\ 128M/g' /etc/php.ini
RUN sed -i 's/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 128M/g' /etc/php.ini

# php session permissions
# RUN mkdir /var/lib/php/session
RUN chmod -R 777 /var/lib/php/session

RUN systemctl enable php-fpm

# install composer
RUN yum install composer -y