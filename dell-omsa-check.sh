#!/bin/bash
function CheckChassis ()
{
OMREPORTPATH="/opt/dell/srvadmin/bin/"
TRIGGER=`"$OMREPORTPATH"omreport chassis | grep -i "$1" | awk {'print $1'}`;
echo "$TRIGGER";
}

function CheckRaidStatus ()
{
OMREPORTPATH="/opt/dell/srvadmin/bin/"
"$OMREPORTPATH"omreport storage vdisk | grep '^ID' | \
        while read LINE
                do
                        read -a VDISKIDALL <<<$LINE;
                        VDISKID="${VDISKIDALL[2]}";
                        VDISKIDSTATUS=`"$OMREPORTPATH"omreport storage vdisk | grep -1 "$VDISKID" | grep -i "status" | awk {'print $3'}`;
			VDISKTYPE=`"$OMREPORTPATH"omreport storage vdisk | grep -6 "$VDISKID" | grep -i "layout" | awk {'print $3'}`; 
                        if [[ "$VDISKIDSTATUS" != "Ok" ]]
                                then
                                        TRIGGER="$VDISKID--$VDISKTYPE--$VDISKIDSTATUS";
                                        echo "$TRIGGER";
                        fi
                done;
}

function CheckStorage ()
{
OMREPORTPATH="/opt/dell/srvadmin/bin/"
OMREPORTTEMP="/tmp/omreport_temp"
"$OMREPORTPATH"omreport storage pdisk controller=0 | grep '^ID' | \
	while read LINE
		do
			read -a PDISKIDALL <<<$LINE;
			PDISKID="${PDISKIDALL[2]}";
			"$OMREPORTPATH"omreport storage pdisk controller=0 > "$OMREPORTTEMP";
			PDISKIDSTATUS=`cat "$OMREPORTTEMP" | grep -m 1 -1 "$PDISKID" | grep -i "status" | awk {'print $3'}`;
			if [[ "$PDISKIDSTATUS" != "Ok" ]]
				then
					TRIGGER="$PDISKID--$PDISKIDSTATUS";
                                        echo "$TRIGGER";
			fi
		done;
}


case "$1" in
	fans)
		TRIGGERVALUE=`CheckChassis $1`;
		if [ -z "$TRIGGERVALUE" ]
		        then
        		        TRIGGERVALUE="UNKNOWN";
		fi
		echo "$TRIGGERVALUE";;
	intrusion)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	memory)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	supplies)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	management)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	processors)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	temperatures)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	voltages)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	hardware)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	batteries)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
	storage)
		TRIGGERVALUE=`CheckStorage`;
		if [ -z "$TRIGGERVALUE" ]
        		then
                	TRIGGERVALUE="Ok";
		fi
		echo $TRIGGERVALUE;;
	raid)
                TRIGGERVALUE=`CheckRaidStatus`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                        TRIGGERVALUE="Ok";
                fi
                echo $TRIGGERVALUE;;
	*)
                TRIGGERVALUE=`CheckChassis $1`;
                if [ -z "$TRIGGERVALUE" ]
                        then
                                TRIGGERVALUE="UNKNOWN";
                fi
                echo "$TRIGGERVALUE";;
esac;






