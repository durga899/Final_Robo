 echo Installing Ngnix
 yum install nginx -y

 echo Downloading web content
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

 cd /usr/share/nginx/html
 echo Removing old content
 rm -rf *
 echo Etracting web content
 unzip /tmp/frontend.zip

 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf

 echo starting ngnix service
 systemctl enable nginx
 systemctl restart nginx
