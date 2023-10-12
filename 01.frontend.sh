source common.sh
component=nginx

echo -e "$color installing the nginx server $nocolor"
yum install nginx -y &>>${logfile}
echo -e "$color Removing default content $nocolor"
cd /usr/share/nginx/html
rm -rf * &>>${logfile}
echo -e "$color Downloading new content to nginx server $nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
unzip frontend.zip &>>${logfile}
rm -rf frontend.zip
echo -e "$color Enabling and starting the nginx server$nocolor"
systemctl enable nginx &>>${logfile}
systemctl restart nginx


