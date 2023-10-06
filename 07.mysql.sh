echo -e "\e[32m Disabiling Mysql default version\e[0m"
yum module disable mysql -y
echo -e "\e[32m Setting up the MySQL5.7 repo file\e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[32m Installing mysql server\e[0m"
yum install mysql-community-server -y
echo -e "\e[32m Changing default root password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
echo -e "\e[32m Checking new password properly working or not\e[0m"
mysql -uroot -pRoboShop@1
echo -e "\e[32m Enabling and starting Mysql server\e[0m"
systemctl enable mysqld
systemctl restart mysqld

