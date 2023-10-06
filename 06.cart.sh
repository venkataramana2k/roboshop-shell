echo -e "\e[32m Downloading Nodejs repo file\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m Installing Nodejs server\e[0m"
yum install nodejs -y
echo -e "\e[32m Adding user and location\e[0m"
mkdir /app
useradd roboshop
cd /app
echo -e "\e[32m Downloading new app content and dependencies to cart server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/cart.zip
unzip cart.zip
rm -rf cart.zip
npm install
echo -e "\e[32m creating cart service file\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[32m Enabling and starting the cart service\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart

