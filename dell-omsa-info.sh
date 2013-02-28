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
echo "The OM Version is :""$OM_VERSION";

##################################
#2)Get HostName
##################################

HOST_NAME='';

HOST_NAME=`"$OM_PATH" chassis info | grep -i "Host Name" | awk {'print $4'} 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$HOST_NAME" ]
	then
		HOST_NAME="Sorry I did't get that,Please contact SA!";
fi
echo "Host Name is :""$HOST_NAME";

##################################
#3)Get Server Model
##################################

SERVER_MODEL='';

SERVER_MODEL=`"$OM_PATH" chassis info | grep -i "Chassis Model" | awk -F ": " '{print $2}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$SERVER_MODEL" ]
	then
		SERVER_MODEL="Sorry I did't get that,Please contact SA!";
fi
echo "Server model is :""$SERVER_MODEL";

##################################
#4)Get Service Tag
##################################

SERVICE_TAG='';

SERVICE_TAG=`"$OM_PATH" chassis info | grep -i "Chassis Service Tag" | awk -F ": " '{print $2}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$SERVICE_TAG" ]
        then
                SERVICE_TAG="Sorry I did't get that,Please contact SA!";
fi
echo "Service Tag is :""$SERVICE_TAG";

###################################
#5)Get Service Code
###################################

SERVICE_CODE='';

SERVICE_CODE=`"$OM_PATH" chassis info | grep -i "express Service Code" | awk -F ": " '{print $2}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$SERVICE_CODE" ]
        then
                SERVICE_CODE="Sorry I did't get that,Please contact SA!";
fi
echo "Service Code is :""$SERVICE_CODE";

####################################
#6)Get idrac IP address
####################################

IDRAC_IP='';

IDRAC_IP=`"$OM_PATH" chassis remoteaccess | grep -i "IP Address   " | awk -F ": " '{print $2}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$IDRAC_IP" ]
        then
                IDRAC_IP="Sorry I did't get that,Please contact SA!";
fi
echo "Idrac IP Address is :""$IDRAC_IP";

####################################
#7)Get idrac mac address
####################################

IDRAC_MAC='';

IDRAC_MAC=`"$OM_PATH" chassis remoteaccess | grep -i "MAC Address" | awk -F ": " '{print $2}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$IDRAC_MAC" ]
        then
                IDRAC_MAC="Sorry I did't get that,Please contact SA!";
fi
echo "Idrac MAC Address is :""$IDRAC_MAC";

####################################
#8)Get idrac version
####################################

IDRAC_VERSION='';

IDRAC_VERSION=`"$OM_PATH" chassis firmware | grep -i "iDRAC" | awk '{print $1" "$3" "$4$5}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$IDRAC_VERSION" ]
        then
                IDRAC_VERSION="Sorry I did't get that,Please contact SA!";
fi
echo "Idrac firmware version is :""$IDRAC_VERSION";

####################################
#9)Get bios version
####################################

BIOS_VERSION='';
BIOS_VERSION=`"$OM_PATH" chassis bios | grep -i "Version" | awk '{print $3}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$BIOS_VERSION" ]
        then
                BIOS_VERSION="Sorry I did't get that,Please contact SA!";
fi
echo "Server BIOS version is :""$BIOS_VERSION";

####################################
#10)Get Raid kard model
####################################

RAID_NAME='';

RAID_NAME=`"$OM_PATH" storage controller | grep -i "Name" | awk '{print $3" "$4" "$5}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$RAID_NAME" ]
        then
		RAID_NAME="Sorry I did't get that,Please contact SA!";
fi
echo "Raid controller model is :""$RAID_NAME";

####################################
#11)Get Raid firmware version
####################################

RAID_FIRMWARE='';

RAID_FIRMWARE=`"$OM_PATH" storage controller | grep -m 1 -i "Firmware Version" | awk '{print $4}' 2>"$FINAL_DATA_PATH"error.log`;

if [ -z "$RAID_FIRMWARE" ]
        then
                RAID_FIRMWARE="Sorry I did't get that,Please contact SA!";
fi
echo "Raid controller Firmware is :""$RAID_FIRMWARE";

####################################
#12)Get CPU info
####################################

#CPU_MODEL='';
#CPU_SPEED='';


"$OM_PATH" chassis processors | grep -i "Index" | \
	while read LINE
		do
			read -a INDEX <<<$LINE;
			if [ -n "${INDEX[2]}" ]
				then
					CPU_MODEL=`"$OM_PATH" chassis processors | grep -A3 "$LINE" | grep -i "Processor Brand" | awk '{print $7}'`;
					CPU_SPEED=`"$OM_PATH" chassis processors | grep -A3 "$LINE" | grep -i "Processor Brand" | awk '{print $9}'`;
					echo "$CPU_MODEL""-""$CPU_SPEED";
			fi
		done;

if [ -z "$CPU_MODEL" ]
        then
                CPU_MODEL="Sorry I did't get that,Please contact SA!";
fi
echo "CPU is :""$CPU_MODEL";


"$OM_PATH" chassis processors | grep -i "Index" >> /tmp/dell-omsa-info.tmp
while read LINE
	do
		

	done;<< /tmp/dell-omsa-info.tmp


####################################
#13)Get Memory total
####################################



















