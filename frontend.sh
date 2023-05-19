 echo Installing Ngnix
 yum install nginx -y &>>/tmp/frontend
 echo status = $?
 echo Downloading web content
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/frontend
 echo status = $?

 cd /usr/share/nginx/html
 echo Removing old content
 rm -rf *
 echo status = $?
 echo Etracting web content
 unzip /tmp/frontend.zip &>>/tmp/frontend
 echo status = $?

 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/frontend
 echo status = $?
 echo starting ngnix service
 systemctl enable nginx &>>/tmp/frontend
 echo status = $?
 systemctl restart nginx &>>/tmp/frontend
 echo status = $?
