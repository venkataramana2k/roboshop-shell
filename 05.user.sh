echo -e "\e[32m Downloading Nodejs repo file\e[0m"
curl -SL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m Installing Nodejs server\e[0m"
yum install nodejs -y
echo - "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m Downloading new app content and dependencies to user server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/user.zip
unzip user.zip
rm -rf user.zip
npm install
echo -e "\e[32m creating user service file\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[32m Downloading and installing the mongodb schema\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.sadguru.shop </app/schema/user.js
echo -e "\e[32m Enabling and starting the user service\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user