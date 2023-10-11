color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/roboshop.log"

echo -e "$color Installing the Nginx server $nocolor"
yum install nginx -y &>>$logfile
echo -e "$color Removing default content $nocolor"
cd /usr/share/nginx/html
rm -rf * &>>$logfile
echo -e "$color Downloading new content to nginx server $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip frontend.zip &>>$logfile
rm -rf frontend.zip
echo -e "$color Configuring reverse proxy nginx server $nocolor"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "$color Enabling and starting the Nginx server $nocolor"
systemctl enable nginx &>>$logfile
systemctl restart nginx






