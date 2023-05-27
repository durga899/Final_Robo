log_file=/tmp/mysql

source common.sh

echo Getting mysql repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>${log_file}
statuscheck $?

echo Disabling defalut mysql
dnf module disable mysql &>>${log_file}
statuscheck $?

echo install mysql server
yum install mysql-community-server -y &>>${log_file}
statuscheck $?

echo Start mysql service
systemctl enable mysqld &>>${log_file}
systemctl restart mysqld &>>${log_file}
statuscheck $?


# grep temp /var/log/mysqld.log