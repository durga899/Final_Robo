log_file=/tmp/catalogue

ID = $(id -u)
if [ $ID -ne 0 ];then
  echo You should run scfript with sudo previlige
  exit 1
fi

echo Setup Nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

echo Installing nodejs
yum install nodejs -y &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

echo Adding roboshop user
useradd roboshop &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

echo Download catalogue Application code
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

cd /home/roboshop

echo Extract catalogue schema
unzip /tmp/catalogue.zip &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

mv catalogue-main catalogue &>>${log_file}
cd /home/roboshop/catalogue

echo Installing dependencies
npm install &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

echo setup catalogue service
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>${log_file}
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

systemctl daemon-reload
systemctl enable catalogue

echo Start catalogue service
systemctl start catalogue
if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi

