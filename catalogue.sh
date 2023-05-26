log_file=/tmp/catalogue

source common.sh

Rootpermission()

echo Setup Nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo Installing nodejs
yum install nodejs -y &>>${log_file}
statuscheck()

id roboshop &>>${log_file}
if [ $? -ne 0 ]; then
   echo Adding roboshop user
   useradd roboshop &>>${log_file}
   statuscheck()
fi

echo Download catalogue Application code
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${log_file}
statuscheck()

cd /home/roboshop
echo Removing old content
rm -rf catalogue &>>${log_file}
statuscheck()

echo Extract catalogue schema
unzip /tmp/catalogue.zip &>>${log_file}
statuscheck()

mv catalogue-main catalogue &>>${log_file}
cd /home/roboshop/catalogue

echo Installing dependencies
npm install &>>${log_file}
statuscheck()

echo setup catalogue service
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>${log_file}
statuscheck()

systemctl daemon-reload
systemctl enable catalogue

echo Start catalogue service
systemctl start catalogue
statuscheck()

