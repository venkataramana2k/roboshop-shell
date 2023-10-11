color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/payment.log"

echo -e "$color Installing python server$nocolor"
yum install python36 gcc python3-devel -y &>>$logfile
echo -e "$color Adding user and Location$nocolor"
useradd roboshop &>>$logfile
mkdir /app &>>$logfile
cd /app
rm -rf *
echo -e "$color Downloading new app content and dependencies to payment server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>$logfile
unzip payment.zip &>>$logfile
pip3.6 install -r requirements.txt &>>$logfile
echo -e "$color creating payment service file$nocolor"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
echo -e "$color Enabling and starting the payment service$nocolor"
systemctl daemon-reload
systemctl enable payment &>>$logfile
systemctl restart payment

