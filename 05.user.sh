echo -e "\e[32m Downloading Nodejs repo file\e[0m"
curl -SL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/user.log
echo -e "\e[32m Installing Nodejs server\e[0m"
yum install nodejs -y &>>/tmp/user.log
echo - "\e[32m Adding user and location\e[0m"
useradd roboshop &>>/tmp/user.log
mkdir /app &>>/tmp/user.log
cd /app
echo -e "\e[32m Downloading new app content and dependencies to user server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/user.log
unzip user.zip &>>/tmp/user.log
rm -rf user.zip
npm install &>>/tmp/user.log
echo -e "\e[32m creating user service file\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[32m Downloading and installing the mongodb schema\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>>/tmp/user.log
mongo --host mongodb-dev.sadguru.shop </app/schema/user.js &>>/tmp/user.log
echo -e "\e[32m Enabling and starting the user service\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user