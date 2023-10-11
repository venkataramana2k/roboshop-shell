color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/cart.log"

echo -e "$color Downloading Nodejs repo file$nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
echo -e "$color Installing Nodejs server$nocolor"
yum install nodejs -y &>>$logfile
echo -e "$color Adding user and location$nocolor"
mkdir /app &>>$logfile
useradd roboshop &>>$logfile
cd /app
echo -e "$color Downloading new app content and dependencies to cart server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>$logfile
unzip cart.zip &>>$logfile
rm -rf cart.zip
npm install &>>$logfile
echo -e "$color creating cart service file$nocolor"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "$color Enabling and starting the cart service$nocolor"
systemctl daemon-reload
systemctl enable cart &>>$logfile
systemctl restart cart

