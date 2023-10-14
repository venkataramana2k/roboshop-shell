color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/dispatch.log"

echo -e "$color Installing golang server$nocolor"
yum install golang -y &>>${logfile}
echo -e "$color Adding user and location$nocolor"
useradd roboshop &>>${logfile}
mkdir /app &>>${logfile}
cd /app
echo -e "$color Downloading new app content, dependencies and building software to dispatch server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>${logfile}
unzip dispatch.zip &>>${logfile}
go mod init dispatch &>>${logfile}
go get &>>${logfile}
go build &>>${logfile}
echo -e "$color creating dispatch service file$nocolor"
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "$color Enabling and starting the dispatch service$nocolor"
systemctl daemon-reload
systemctl enable dispatch &>>${logfile}
systemctl restart dispatch





