#!/bin/bash

### Script for starting docker ### 
##################################
#### GLOBAL SCRIPT PARAMETERS ####
##################################
aemDockerRoot=aem/dockerfiles
aemFileName=adobe-cq-wcm.jar
aemLicence=license.properties
publishContainer=publish

##################################
#### FUNCTIONS ####
##################################
# Check for file dependencies (i,e : aem jar file, properties.licences file) 
function validateAEM(){
	if ! [ -e $aemDockerRoot/$aemFileName ]
		then
			echo "Error: AEM jar file needs to be inside the '$aemDockerRoot' directory as '$aemFileName'."
			exit 1;
	fi

	if ! [ -e $aemDockerRoot/$aemLicense ]
		then
			echo "Error: License file needs to be inside the '$aemDockerRoot' directory as '$aemLicense'."
			exit 1;
	fi
}

# Create local images. Build aem base
function buildAEMBase(){	
	echo "Building AEM base image ..."
	docker build -t aem-base:6.1 -f $aemDockerRoot/Docker-aem-base ./$aemDockerRoot
}
############################################################################################
# Check if docker exists		
if ! [ -x "$(command -v docker)" ]
	then 
		echo "Error: Docker is not installed or not running."
		exit 1;
fi

#### START UP CODE ####

	validateAEM
	buildAEMBase
	docker build -t publish:6.1 -f $aemDockerRoot/Docker-aem-publish ./$aemDockerRoot
	docker-compose up -d
	
	echo "Waiting 60 sec for initial AEM docker startup ...."
	
	sleep 60;
	
	docker exec publish /opt/aem/postInstall.sh
	
	docker-compose restart
	
	echo "Waiting for AEM to initialize https ..."
	
	sleep 20;
	
	printf "#######################################\nSTART UP COMPLETE\n#######################################";