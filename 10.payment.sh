echo -e "\e[32m Installing python server\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[32m Adding user and Location\e[0m"
useraddr roboshop
mkdir /app
cd /app
echo -e "\e[32m Downloading new app content and dependencies to payment server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/payment.zip
unzip payment.zip
pip3.6 install -r requirements.txt
echo -e "\e[32m creating payment service file\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[32m Enabling and starting the payment service\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment