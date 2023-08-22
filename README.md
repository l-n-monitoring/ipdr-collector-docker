**CMTS IPDR collector docker**

IPDR is an alternative way to collect data from the CMTS. The exports supported can be different between CMTS vendors/models/sw_versions.

Verified vendors are:<br>
***Casa Systems, Arris and Cisco***

1. How it works:
   - Client connect to the CMTS and try to collect data that is defined in the configs/ipdr.json
   - ipdr collector will also send data to mongodb where you can see the data defined in configs/mongo_data.json
   - ipdr collector sends data to kafka broker
   - telegraf acts as a kafka consumer
   - telegraf will export the data to the outputs defined in telegraf.conf (influxdb and/or timescaledb by default)
   - it comes with grafana so, you can make your own dashboards
   - telegraf.conf also contains an example of snmp collection for other measurements that are not available by the IPDR
   - ***scheme**<br>
![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://myoctocat.com/assets/images/base-octocat.svg)    
     
