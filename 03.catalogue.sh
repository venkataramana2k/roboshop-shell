echo -e "\e[32m Downloading nodejs repo file\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m Installing nodejs repo file\e[0m"
yum install nodejs -y
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m Downloading new app content and dependencies to catalogue server\e[0m"
curl -O catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
unzip catalogue.zip
rm -rf catalogue.zip
npm install
echo -e "\e[32m creating catalogue service file\e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m downloading and installing maongodb schema\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.sadguru.shop
echo -e "\e[32m enabling and starting the catalogue service\e[0m"
systemctl daemon-reload
systemctl enable catalogue










