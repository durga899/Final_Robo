log_file=/tmp/user

source common.sh

Rootpermission

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

echo Download user Application code
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip" &>>${log_file}
statuscheck $?

cd /home/roboshop
echo Removing old content
rm -rf user &>>${log_file}
statuscheck $?

echo Extract catalogue schema
unzip /tmp/user.zip &>>${log_file}
statuscheck $?

mv user-main user &>>${log_file}
cd /home/roboshop/user

echo Installing dependencies
npm install   &>>${log_file}
statuscheck $?

echo Update SystemD service file
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/user/systemd.service
statuscheck $?

echo setup user service
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service &>>${log_file}

systemctl daemon-reload &>>${log_file}
systemctl enable user &>>${log_file}

echo Starting user service
systemctl start user  &>>${log_file}
statuscheck $?
