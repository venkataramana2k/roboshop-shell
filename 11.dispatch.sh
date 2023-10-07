echo -e "\e[32m Installing golang server\e[0m"
yum install golang -y
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m Downloading new app content, dependencies and building software to dispatch server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
unzip dispatch.zip
go mod init dispatch
go get
go build
echo - "\e[32m creating dispatch service file\e[0"
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[32m Enabling and starting the dispatch service\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch



