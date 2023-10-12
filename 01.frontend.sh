echo -e "\e[32m installing the Nginx server \e[0m"
yum install nginx -y &>>/tmp/frontend.log
echo -e "\e[32m Removing default content \e[0m"
cd /usr/share/nginx/html
rm -rf * &>>/tmp/frontend.log
echo -e "\e[32m Downloading new content to nginx server \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/frontend.log
unzip frontend.zip &>>/tmp/frontend.log
rm -rf frontend.zip
echo -e "\e[32m Configuring reverse proxy nginx server \e[0m"
cp /root/roboshop-shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf
echo -e "\e[32m Enabling and starting the Nginx server\e[0m"
systemctl enable nginx &>>/tmp/frontend.log
systemctl restart nginx


