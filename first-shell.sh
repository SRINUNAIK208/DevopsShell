#!/bin/bash



R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Logs_Folder="/var/log/shellscript-log"
Script_Name="$(echo $0 | cut -d "." -f1)"
Logs_file="$Logs_Folder/$Script_Name.log"

mkdir -p $Logs_Folder

PACKAGES=("mysql" "nginx" "python3" "httpd")

UserId=$(id -u)

if [ $UserId -eq 0 ]
then 
    echo -e "$G user running the script with root access $N"
else
    echo -e "$R user not running the script with root access $N"
    exit 1
fi



VALIDATE(){
    
    if [ $1 -eq 0 ]
    then
       echo -e " $2 installation... $G success $N"
    else
       echo -e " $2 installation...$R failure $N"
       exit 1
    fi

}
for package in ${PACKAGES[@]}
do
   dnf list installed $package &>> $Logs_file
if [ $? -eq 0 ]
then
    echo -e "$Y $package is already installed...Nothing to do $N"
else
    echo -e "$R $package is not installed..going to installing $N"
    dnf install $package -y &>> $Logs_file
    VALIDATE $? "$package"
fi


done
