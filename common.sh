Rootpermission() {
  ID=$(id -u)
if [ $ID -ne 0 ];then
  echo You should run scfript with sudo previlige
  exit 1
fi
}

statuscheck() {
  if [ $? == 0 ]; then
  echo Status = Success
else
  echo Status = Failure
  exit 1
fi
}