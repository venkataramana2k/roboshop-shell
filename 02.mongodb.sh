color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/mongodb.log"

echo -e "$color Downloading Mongodb Repo$nocolor"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$logfile
echo -e "$color Installing Mongodb server$nocolor"
yum install mongodb-org -y &>>$logfile
echo -e "$color Changing the listen address$nocolor"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "$color Enabling and starting Mongodb server$nocolor"
systemctl enable mongod &>>$logfile
systemctl restart mongod
