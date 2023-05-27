Rootpermission() {
  ID=$(id -u)
if [ $ID -ne 0 ];then
  echo You should run scfript with sudo previlige
  exit 1
fi
}

statuscheck() {
  if [ $1 -eq 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi
}

Nodejs() {
  echo Getting nodejs repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
  statuscheck $?

  echo Installing nodejs
  yum install nodejs -y &>>${log_file}
  statuscheck $?

  id roboshop &>>${log_file}
  if [ $? -ne 0 ]; then
     echo Adding roboshop user
     useradd roboshop &>>${log_file}
     statuscheck $?
  fi

  echo Download ${component} Application code
  curl -s -L -o /tmp/${component}.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>${log_file}
  statuscheck $?

  cd /home/roboshop
  echo Removing old content
  rm -rf ${component} &>>${log_file}
  statuscheck $?

  echo Extract ${component} schema
  unzip /tmp/${component}.zip &>>${log_file}
  statuscheck $?

  mv ${component}-main ${component} &>>${log_file}
  cd /home/roboshop/${component}

  echo Installing dependencies
  npm install   &>>${log_file}
  statuscheck $?

  echo Update SystemD service file
  sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/${component}/systemd.service
  statuscheck $?

  echo setup ${component} service
  mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service &>>${log_file}

  systemctl daemon-reload &>>${log_file}
  systemctl enable ${component} &>>${log_file}

  echo Starting ${component} service
  systemctl start ${component}  &>>${log_file}
  statuscheck $?

}