**CMTS IPDR collector docker**

IPDR is an alternative way to collect data from the CMTS. The exports supported can be different between CMTS vendors/models/sw_versions.

Verified vendors are:<br>
***Casa Systems, Arris and Cisco***

1. How it works:
   **it doesn't work out of the box. There is a script "change_ip.sh" that will replace your server IP in all places needed**
   - Client connect to the CMTS and try to collect data that is defined in the configs/ipdr.json
   - ipdr collector will also send data to mongodb where you can see the data defined in configs/mongo_data.json
   - ipdr collector sends data to kafka broker
   - telegraf acts as a kafka consumer
   - telegraf will export the data to the outputs defined in telegraf.conf (influxdb and/or timescaledb by default)
   - it comes with grafana so, you can make your own dashboards
   - telegraf.conf also contains an example of snmp collection for other measurements that are not available by the IPDR
   - **scheme**<br>
![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](/assets/images/ipdr-docker-scheme.png)    

2. Adding CMTS:
   - edit configs/ipdr.json file and add cmtses under CMTS section.
   - edit telegraf.conf and add new cmts
   - restart ipdr-collector-docker and telegraf dockers

2. CMTS Configuration:<br>
**Make sure you delete all previous ipdr config on the CMTS**

   - Casa CMTS
```
ipdr session 3 service-type us-status
ipdr session 1 interval 1200
ipdr master **YOUR_SERVER_IP**
```
   - Cisco CMTS
```
ipdr session 2 DOCSIS-SAMIS-TYPE-2 DOCSIS-SAMIS-TYPE-2
ipdr session 3 DOCSIS-CMTS-CM-US-STATS-TYPE DOCSIS-CMTS-CM-US-STATS-TYPE
ipdr session 11 DOCSIS-CPE-TYPE-ADHOC DOCSIS-CPE-TYPE-ADHOC
ipdr session 12 DOCSIS-CPE-TYPE-EVENT DOCSIS-CPE-TYPE-EVENT
ipdr session 18 DOCSIS-CMTS-CM-REG-STATUS-TYPE-EVENT DOCSIS-CMTS-CM-REG-STATUS-TYPE-EVENT
ipdr session 19 DOCSIS-CMTS-CM-REG-STATUS-TYPE-ADHOC DOCSIS-CMTS-CM-REG-STATUS-TYPE-ADHOC
ipdr type 2 time-interval 15
ipdr type 3 time-interval 15
ipdr type 11 ad-hoc
ipdr type 12 event
ipdr type 18 event
ipdr type 19 ad-hoc
ipdr collector federal **YOUR_SERVER_IP**
ipdr associate 2 federal 5
ipdr associate 3 federal 5
ipdr associate 11 federal 5
ipdr associate 12 federal 5
ipdr associate 18 federal 5
ipdr associate 19 federal 5
ipdr template 2 SAMIS-TYPE2
ipdr template 3 CM-US
ipdr template 11 CPE-TYPE
ipdr template 12 CPE-TYPE
ipdr template 18 CM-STATUS
ipdr template 19 CM-STATUS
ipdr exporter start
cable metering ipdr-d3 session 2 type 2
```
   - Arris CMTS
```
cable metering mode docsis30
cable metering keep-alive-interval 600
cable metering collector  2 **YOUR_SERVER_IP**
cable metering session 2 service samis-1 method time report-cycle-set 2
cable metering session 4 service cpe method adhoc
cable metering session 5 service cpe method event report-cycle-set 2 evt-pace-gap 1
cable metering session 6 service cm-reg method event report-cycle-set 2 evt-pace-gap 1
cable metering session 7 service cm-reg method adhoc
cable metering session 8 service cm-us method time report-cycle-set 2
cable metering report-cycle set 1 start 15:42 interval 30
cable metering report-cycle set 2 start 22:00 interval 15
cable metering shutdown no
```