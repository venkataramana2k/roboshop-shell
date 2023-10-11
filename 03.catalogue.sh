color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/catalogue.log"


echo -e "$color Downloading NodeJs Repo$nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
echo -e "$color Installing Nodejs Server\e[om"
yum install nodejs -y &>>$logfile
echo -e "$color Adding user and location$nocolor"
useradd roboshop
mkdir /app
cd /app
echo -e "$color Downloading New App content and dependencies to catalogue server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>$logfile
unzip catalogue.zip &>>$logfile
rm -rf catalogue.zip &>>$logfile
npm install
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "$color Downloading and installing mongodb schema$nocolor"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>>$logfile
mongo --host mongodb-dev.sadguru.shop </app/schema/catalogue.js &>>$logfile
echo -e "$color Enabling and starting the catalogue service$nocolor"
systemctl daemon-reload &>>$logfile
systemctl enable catalogue &>>$logfile
systemctl restart catalogue
