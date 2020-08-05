FROM centos:7
MAINTAINER q90016200 <q90016200@gmail.com> php7.2

# zsh
RUN yum install git -y
RUN yum install zsh -y
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN yum install initscripts -y

# 啟用 EPEL
RUN yum install epel-release -y
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum update -y

#other
RUN yum install wget vim -y


# nginx
# RUN yum install nginx -y
# RUN systemctl enable nginx

# PHP
RUN yum install php72w-fpm php72w-opcache php72w-pecl-mongodb php72w-mysqlnd php72w-curl php72w-mcrypt php72w-xml php72w-pecl-redis php72w-pecl-memcached php72w-gd php72w-mbstring php72w-bcmath ntpdate unzip -y
RUN sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
RUN sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf
RUN sed -i 's/expose_php\ =\ On/expose_php\ =\ Off/g' /etc/php.ini
RUN sed -i 's/short_open_tag\ =\ Off/short_open_tag\ =\ On/g' /etc/php.ini
RUN sed -i 's/max_execution_time\ =\ 30/max_execution_time\ =\ 600/g' /etc/php.ini
RUN sed -i 's/post_max_size\ =\ 8M/post_max_size\ =\ 128M/g' /etc/php.ini
RUN sed -i 's/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 128M/g' /etc/php.ini

RUN systemctl enable php-fpm

# composer
RUN yum install composer -y

