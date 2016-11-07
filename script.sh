url='https://s3-us-west-2.amazonaws.com/harshg7/status'
echo $(curl -s $url) > temp.txt
memstatus=$(jq '."mem-used-pct"'< temp.txt)

memthreshold=95.0
cputhreshold=97.0

if [ 1 -eq "$(echo "${memstatus} > ${memthreshold}" | bc)" ]
then  
    details='memory_overload '
fi

cpustatus=$(jq '."cpu-used-pct"'< temp.txt)
if [ 1 -eq "$(echo "${cpustatus} > ${cputhreshold}" | bc)" ]
then  
    details+='cpu_overload '
fi

diskstatus1=$(jq '."disc-space-avail"[0]."availbytes"'< temp.txt |sed 's/"//g')
diskstatus2=$(jq '."disc-space-avail"[1]."availbytes"'< temp.txt |sed 's/"//g')
if [ 1024 -gt $diskstatus1 ]
then  
    details+='Disk1 has less free space '
fi
if [ 1024 -gt $diskstatus2 ]
then  
    details+='Disk2 has less free space  '
fi
echo $details

curl -H "Content-type: application/json" -X POST \
    -d '{ 
	 "username":"monitoring"
	 "password":"f0rth3w1n"
	 "service_key":"abcdefg"
      "event_type": "trigger",
      "client_url": "https://monitoring.service.com",
      "details": "${details}"
    }' \
    "https://some_url/createIncident"
