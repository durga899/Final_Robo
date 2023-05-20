echo setting =mongodb repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>> /tmp/mongodb
echo status = $?

echo Installing mongodb
yum install -y mongodb-org &>> /tmp/mongodb
echo status = $?

echo Enable mongodb
systemctl enable mongod &>> /tmp/mongodb
echo status = $?

echo Starting mongodb
systemctl start mongod &>> /tmp/mongodb
echo status = $?
echo done

