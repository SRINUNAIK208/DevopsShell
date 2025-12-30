#!/bin/bash



R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Logs_Folder="/var/log/shellscript-log"
Script_Name="$(echo $0 | cut -d "." -f1)"
Logs_file="$Logs_Folder/$Script_Name.log"

mkdir -p $Logs_Folder

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

dnf list installed mysql &>> $Logs_file
if [ $? -eq 0 ]
then
    echo -e "$Y mysql is already installed...Nothing to do $N"
else
    echo -e "$R mysql is not installed..going to installing $N"
    dnf install mysql -y &>> $Logs_file
    VALIDATE $? "mysql"
fi

dnf list installed nginx &>> $Logs_file

if [ $? -eq 0 ]
then 
   echo "$Y nginx is already installed..Nothing to do $N"
else
   echo "$R nginx is not installed..going to installing $N"
   dnf install nginx -y &>> $Logs_file
   VALIDATE $? "nginx"
   exit 1
fi
dnf list installed python3 &>> $Logs_file

if [ $? -eq 0 ]
then 
   echo "$Y python3 is already installed..Nothing to do $N"
else
   echo "$R python3 is not installed..going ti installing $N"
   dnf install python3 -y &>> $Logs_file
   VALIDATE $? "python3"
   exit 1
fi
    