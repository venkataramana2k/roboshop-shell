color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/shipping.log"

echo -e "$color Installing maven server$nocolor"
yum install maven -y &>>$logfile
echo -e "$color Adding user and location$nocolor"
useradd roboshop &>>$logfile
mkdir /app &>>$logfile
cd /app
rm -rf *
echo -e "$color Downloading new app content to shipping server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>$logfile
unzip shipping.zip &>>$logfile
echo -e "$color Downloading dependencies and building application to shipping server$nocolor"
mvn clean package &>>$logfile
mv target/shipping-1.0.jar shipping.jar &>>$logfile
echo -e "$color creating shipping service file$nocolor"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "$color Downloading and installing the mysql schema$nocolor"
yum install mysql -y &>>$logfile
mysql -h mysql-dev.sadguru.shop -uroot -pRoboShop@1 </app/schema/shipping.sql &>>$logfile
echo -e "$color Enabling and starting the shipping service $nocolor"
systemctl daemon-reload
systemctl enable shipping &>>$logfile
systemctl restart shipping

