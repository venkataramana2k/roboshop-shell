echo -e "\e[32m Installing maven server\e[0m"
yum install maven -y
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
rm -rf *
echo -e "\e[32m Downloading new app content to shipping server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
unzip shipping.zip
echo -e "\e[32m Downloading dependencies and building application to shipping server\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[32m creating shipping service file\e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m Downloading and installing the mysql schema\e[0m"
yum install mysql -y
mysql -h mysql-dev.sadguru.shop -uroot -pRoboShop@1 </app/schema/shipping.sql
echo -e "\e[32m Enabling and starting the shipping service \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

