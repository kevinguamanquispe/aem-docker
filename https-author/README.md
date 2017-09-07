# Docker instance set up

## Requirements 
- Latest Docker version (this code was tested with Version 17). For Mac https://docs.docker.com/docker-for-mac/install/#what-to-know-before-you-install.
- AEM jar 
- AEM license.properties file

## Start aem instance 
Before starting aem container you need to place the AEM jar and license file under `ddcom-docker/aem/dockerfiles`. The jar file needs to be renamed to `adobe-cq-wcm.jar`.

1. Open terminal and change directory to the root docker directory `ddcom-aem/ddcom-docker`
2. Run the startup script: `./startup.sh`

The script should take about 10 minutes to run. You will know that it is complete when you see the following message :
```
#######################################
START UP COMPLETE
#######################################
```
Once complete you should be able to access aem with the following URLS:
- http://localhost:4502
- https://localhost:5433

## Basic Docker commands 
If you need to stop or start the aem instance use the following commands: 
- Stop container: `docker-compose stop`
- Start container: `docker-compose start`
- Restart container: `docker-compose restart` 
- Enter inside running container (debugging): `docker exec -it author bash` 

** If you need to recreate your local aem run the startup script again. ** 

## Logs 
The log directory in AEM is configured as a mounting point in your workspace. To access logs go to `ddcom-docker/aem/volumes/author/crx-quickstart/logs`