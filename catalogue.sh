log_file=/tmp/catalogue

echo Setup Nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

echo Installing nodejs
yum install nodejs -y &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

echo Adding roboshop user
useradd roboshop &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

echo Download catalogue Application code
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

cd /home/roboshop

echo Etract catalogue schema
unzip /tmp/catalogue.zip &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

mv catalogue-main catalogue &>>${log_file}
cd /home/roboshop/catalogue

echo Installing dependencies
npm install &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

echo setup catalogue service
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

systemctl daemon-reload
systemctl enable catalogue

echo Start catalogue service
systemctl start catalogue
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
fi

