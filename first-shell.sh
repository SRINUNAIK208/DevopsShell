#!/bin/bash



R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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

dnf list installed mysql
if [ $? -eq 0 ]
then
    echo -e " $Y mysql is already installed...Nothing to do $N"
else
    echo "$R mysql is not installed..going to installing $N"
    dnf install mysql -y
    VALIDATE $? "mysql"
fi
    