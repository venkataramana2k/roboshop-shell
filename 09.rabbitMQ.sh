color="\e[32m"
nocolor="\e[0m"
logfile=="/tmp/rabbitmq.log"

echo -e "$color Downloading rabbitmq repo file$nocolor"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$logfile
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$logfile
echo -e "$color Installing Rabbitmq-server$nocolor"
yum install rabbitmq-server -y &>>$logfile
echo - "$color Enabling and starting the Rabbitmq-server$nocolor"
systemctl enable rabbitmq-server &>>$logfile
systemctl start rabbitmq-server
echo -e "$color Adding user and setting permissions $nocolor"
rabbitmqctl add_user roboshop roboshop123 &>>$logfile
rabbitmqctl set permissions -p /roboshop ".*" ".*" ".*" &>>$logfile
