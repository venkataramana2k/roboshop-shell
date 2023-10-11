color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/user.log"

echo -e "$color Downloading Nodejs repo file$nocolor"
curl -SL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
echo -e "$color Installing Nodejs server$nocolor"
yum install nodejs -y &>>$logfile
echo - "$color Adding user and location$nocolor"
useradd roboshop &>>$logfile
mkdir /app &>>$logfile
cd /app
echo -e "$color Downloading new app content and dependencies to user server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>$logfile
unzip user.zip &>>$logfile
rm -rf user.zip
npm install &>>$logfile
echo -e "$color creating user service file$nocolor"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "$color Downloading and installing the mongodb schema$nocolor"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>>$logfile
mongo --host mongodb-dev.sadguru.shop </app/schema/user.js &>>$logfile
echo -e "$color Enabling and starting the user service$nocolor"
systemctl daemon-reload
systemctl enable user
systemctl restart user