#!/bin/bash

#################################
#Something Usefull
#################################

OM_PATH="/opt/dell/srvadmin/bin/omreport";
FINAL_DATA_PATH="/tmp/server-info/";
if [ ! -d "$FINAL_DATA_PATH" ]
	then
		mkdir -p $FINAL_DATA_PATH;
fi


##################################
#1)Get the Version of OpenManage
##################################

OM_VERSION='';

OM_VERSION=`"$OM_PATH" about | grep -i "Version" | awk {'print $3'} 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$OM_VERSION" ]
	then
		OM_VERSION="Sorry I did't get that,Please contact SA!";
fi
echo "The OM Version is : ""$OM_VERSION";

##################################
#2)Get HostName
##################################

HOST_NAME='';

HOST_NAME=`"$OM_PATH" chassis info | grep -i "Host Name" | awk {'print $4'} 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$HOST_NAME" ]
	then
		HOST_NAME="Sorry I did't get that,Please contact SA!";
fi
echo "Host Name is : ""$HOST_NAME";

##################################
#3)Get Server Model
##################################

SERVER_MODEL='';

SERVER_MODEL=`"$OM_PATH" chassis info | grep -i "Chassis Model" | awk -F ":" '{print $2}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$SERVER_MODEL" ]
	then
		SERVER_MODEL="Sorry I did't get that,Please contact SA!";
fi
echo "Server model is : ""$SERVER_MODEL";




















