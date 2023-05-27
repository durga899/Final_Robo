log_file=/tmp/redis

source common.sh

Rootpermission

echo Getting  Redis repos
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}
statuscheck $?

echo Enable redis
dnf module enable redis:remi-6.2 -y &>>${log_file}
statuscheck $?

echo Installing redis
yum install redis -y &>>${log_file}
statuscheck $?

echo Updating redis listen address
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf

statuscheck $?

systemctl enable redis &>>${log_file}
systemctl retart redis &>>${log_file}
statuscheck $?
