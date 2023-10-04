echo -e "\e[33m installing the Nginx server \e[0m"
yum install nginx -y
echo -e "\e[33m Removing default content \e[0m"
cd /usr/share/nginx/html
rm -rf *
echo -e "\e[33m Downloading new content to nginx server \e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip frontend.zip
rm -rf frontend.zip
echo -e "\e[33m Configuring reverse proxy nginx server \e[0m"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m Enabling and starting the Nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx
