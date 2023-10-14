color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"



status()
{
  if [ $? -eq 0 ];then
    echo success
  else
    echo failure
  fi
}


nodejs()
{
  echo -e "$color Downloading NodeJs Repo$nocolor"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${logfile}
  status
  echo -e "$color Installing Nodejs Server$nocolor"
  yum install nodejs -y &>>${logfile}
  status
  app_start
  echo -e "$color installing dependencies $nocolor"
  npm install &>>${logfile}
  status
  service_start
}


app_start()
{
  echo -e "$color Adding user$nocolor"
  id roboshop &>>${logfile}
  if [ $? -ne 0 ];then
    useradd roboshop &>>${logfile}
  fi
  status
  echo -e "$color creating default app path $nocolor"
  rm -rf ${app_path} &>>${logfile}
  mkdir ${app_path} &>>${logfile}
  status
  cd ${app_path}
  echo -e "$color Downloading New App content and dependencies to ${component} server$nocolor"
  curl -O https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}
  unzip ${component}.zip &>>${logfile}
  status
}


mongo_schema()
{
  systemctl daemon-reload
  echo -e "$color Downloading and installing mongodb schema$nocolor"
  cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
  status
  echo -e "$color loading mongodb schema$nocolor"
  yum install mongodb-org-shell -y &>>${logfile}
  status
  echo -e "$color installing schema $nocolor"
  mongo --host mongodb-dev.sadguru.shop  </app/schema/{component}.js &>>${logfile}
  status
}


service_start()
{
  echo -e "$color Creating ${component} service $nocolor"
  cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
  status
  echo -e "$color system reload the ${component} service $nocolor"
  systemctl daemon-reload
  status
  echo -e "$color Enabling and starting the ${component} service $nocolor"
  systemctl enable ${component} &>>${logfile}
  systemctl restart ${component}
  status
}


maven()
{
  echo -e "$color Installing maven server$nocolor"
  yum install maven -y &>>${logfile}
  status
  app_start
  echo -e "$color cleaning package$nocolor"
  mvn clean package &>>${logfile}
  status
  echo -e "$color building application$nocolor"
  mv target/${component}-1.0.jar ${component}.jar &>>${logfile}
  status
  mysql_schema
  service_start
}


mysql_schema()
{
  echo -e "$color installing the mysql schema$nocolor"
  yum install mysql -y &>>${logfile}
  status
  echo -e "$color setting mysql schema$nocolor"
  mysql -h mysql-dev.sadguru.shop -uroot -pRoboShop@1 </${app_path}/schema/${component}.sql &>>${logfile}
  status
}


python()
{
  echo -e "$color Installing python server$nocolor"
  yum install python36 gcc python3-devel -y &>>${logfile}
  status
  app_start
  echo -e "$color Downloading dependencies for python service$nocolor"
  pip3.6 install -r requirements.txt &>>${logfile}
  status
  service_start
}
