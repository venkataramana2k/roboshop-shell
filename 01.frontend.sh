source common.sh
component=Nginx

echo -e "$color Installing the ${component} server$nocolor"
yum install ${component} -y &>>${logfile}
echo -e "$color Removing default ${component} content $nocolor"
cd /usr/share/${component}/html
rm -rf * &>>${logfile}
echo -e "$color Downloading new content to ${component}$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
unzip frontend.zip &>>${logfile}
rm -rf frontend.zip
echo -e "$color Configuring reverse proxy ${component} server $nocolor"
cp /root/roboshop-shell/roboshop.conf /etc/${component}/default.d/roboshop.conf
echo -e "$color Enabling and starting the ${component} server$nocolor"
systemctl enable ${component} &>>${logfile}
systemctl restart ${component}



