color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

nodejs()
{
  echo -e "$color Downloading NodeJs Repo$nocolor"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
  echo -e "$color Installing Nodejs Server\e[om"
  yum install nodejs -y &>>$logfile
  npm install &>>$logfile
}

app_Start()
{
  echo -e "$color Adding user and location$nocolor"
  useradd roboshop
  mkdir $app_path
  cd $app_path
  echo -e "$color Downloading New App content and dependencies to ${component} server$nocolor"
  curl -O https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$logfile
  unzip ${component}.zip &>>$logfile
  rm -rf ${component}.zip &>>$logfile
}

mongo_schema()
{
  echo -e "$color Downloading and installing mongodb schema$nocolor"
  cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
  yum install mongodb-org-shell -y &>>$logfile
  mongo --host mongodb-dev.sadguru.shop <$app_path/schema/${component}.js &>>$logfile
}

service_start()
{
  echo -e "$color Creating ${component} service $nocolor"
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
  echo -e "$color Enabling and starting the ${component} service$nocolor"
  systemctl daemon-reload &>>$logfile
  systemctl enable ${component} &>>$logfile
  systemctl restart ${component}
}

maven()
{
  echo -e "$color Installing maven server$nocolor"
  yum install maven -y &>>$logfile
  app_start
  echo -e "$color Downloading dependencies and building application to ${component}server$nocolor"
  mvn clean package &>>$logfile
  mv target/${component}-1.0.jar ${component}.jar &>>$logfile

  echo -e "$color Downloading and installing the mysql schema$nocolor"
  yum install mysql -y &>>$logfile
  mysql -h mysql-dev.sadguru.shop -uroot -pRoboShop@1 </app/schema/${component}.sql &>>$logfile
  service_start
}

mysql_schema()
{
  echo -e "$color Downloading and installing the mysql schema$nocolor"
  yum install mysql -y &>>$logfile
  mysql -h mysql-dev.sadguru.shop -uroot -pRoboShop@1 </app/schema/${component}.sql &>>$logfile
}

python()
{
  echo -e "$color Installing python server$nocolor"
  yum install python36 gcc python3-devel -y &>>$logfile
  app_start
  echo -e "$color Downloading dependencies for python server$nocolor"
  pip3.6 install -r requirements.txt &>>$logfile
  service_start
}

