# reliability

## Prerequisite for Linux Environment 

Make sure following are installed for executing the script

* curl - For HTTP Request Response
* bc - For Math operations
* jq - For JSON parsing

These can be installed by following commands
```
sudo apt-get install curl
sudo apt-get install bc
sudo apt-get install jq
```
## Script 

Included file script.sh which has the total code which queries the status endpoint and checks for the following conditions:

1. Memory Usage is >95.0%
2. Disc Space Available on either disc < 1k
3. CPU usage is >97.0%

## What does it do? 

The `\status` web service used in the script was created using S3 bucket on Amazon Web Services.
This is static json file in the backend ; so while we run the script the result would always be the same.
For acquiring different results , we create multiple status files. Thus , url could be edited in the script and the script could be tested.

```
url='https://s3-us-west-2.amazonaws.com/harshg7/status'
url='https://s3-us-west-2.amazonaws.com/harshg7/status1'
url='https://s3-us-west-2.amazonaws.com/harshg7/status2'
url='https://s3-us-west-2.amazonaws.com/harshg7/status3'
```

## Cron : 

_BONUS: Specify the cron expression 
to enable this query to run every 5 minutes
```
*/5 * * * *  /path_to_script/script.sh
```
## How to run this script?

1. Firstly , git clone https://github.com/harshg7/reliability.git  repository on your local machine.
2. Install above mentioned commands used for linux environment.
3. Verify permissions for script.sh and change it to 555 .
4. There are two simple ways to run the script 
  i. Run ./script.sh from your correct path
  ii. Schedule script.sh using cron expression ( */5 * * * *  /path_to_script/script.sh )
5. Since our status service is in test env , edit the url variable as mentioned above to acheive all three different types of results.

## Results 

1. After the script is executed ; alert would be created by using PagerDuty Events Trigger API.
