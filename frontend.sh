 log_file=/tmp/frontend
 echo Installing Ngnix
 yum install nginx -y &>>${log_file}
 echo status = $?
 echo Downloading web content
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>${log_file}
 echo status = $?

 cd /usr/share/nginx/html
 echo Removing old content
 rm -rf *
 echo status = $?
 echo Etracting web content
 unzip /tmp/frontend.zip &>>${log_file}
 echo status = $?

 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
 echo status = $?
 echo starting ngnix service
 systemctl enable nginx &>>${log_file}
 echo status = $?
 systemctl restart nginx &>>${log_file}
 echo status = $?
