echo setting =mongodb repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>> /tmp/mongodb
echo status = $?

echo Installing mongodb
yum install -y mongodb-org &>> /tmp/mongodb
echo status = $?

echo Updating mongodb listen address
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo status = $?

echo Enable mongodb
systemctl enable mongod &>> /tmp/mongodb
echo status = $?

echo restarting mongodb
systemctl restart mongod &>> /tmp/mongodb
echo status = $?

echo Downloading mongodb schema
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>> /tmp/mongodb
echo status = $?

cd /tmp
echo Unzipping mongodb
unzip mongodb.zip &>> /tmp/mongodb
echo status = $?

cd mongodb-main

echo Load catalogue service schema
mongo < catalogue.js &>> /tmp/mongodb
echo status = $?

echo Load user schema
mongo < users.js &>> /tmp/mongodb
echo status = $?




