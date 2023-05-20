log_file=/tmp/catalogue

echo Setup Nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
echo status = $?

echo Installing nodejs
yum install nodejs -y &>>${log_file}
echo status = $?

echo Adding roboshop user
useradd roboshop &>>${log_file}
echo status = $?

echo Download catalogue Application code
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${log_file}
echo status = $?

cd /home/roboshop

echo Etract catalogue schema
unzip /tmp/catalogue.zip &>>${log_file}
echo status = $?

mv catalogue-main catalogue
cd /home/roboshop/catalogue

echo Installing dependencies
npm install &>>${log_file}
echo status = $?

echo setup catalogue service
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
echo status = $?

systemctl daemon-reload
systemctl enable catalogue

echo Start catalogue service
systemctl start catalogue
echo status = $?

