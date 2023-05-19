 echo Installing Ngnix
 yum install nginx -y &>>/tmp/frontend

 echo Downloading web content
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/frontend

 cd /usr/share/nginx/html
 echo Removing old content
 rm -rf *
 echo Etracting web content
 unzip /tmp/frontend.zip &>>/tmp/frontend

 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/frontend

 echo starting ngnix service
 systemctl enable nginx &>>/tmp/frontend
 systemctl restart nginx &>>/tmp/frontend
