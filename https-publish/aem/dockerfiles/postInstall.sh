#!/bin/bash
echo 'Setting custom config properties ...' && \

until $(curl -u admin:admin --output /dev/null --silent --head --fail http://localhost:$CQ_PORT); do printf '.'; sleep 5; done && \
   
curl -u admin:admin -F "jcr:primaryType=sling:OsgiConfig" \
-F "alias=/crx/server" \
-F "dav.create-absolute-uri=true" \
-F "dav.create-absolute-uri@TypeHint=Boolean" \
http://localhost:$CQ_PORT/apps/system/config/org.apache.sling.jcr.davex.impl.servlets.SlingDavExServlet;
		
curl --data jcr:primaryType=sling:OsgiConfig \
--data  org.apache.felix.debug=true \
--data org.apache.felix.https.enable=true \
--data org.apache.felix.https.enable@TypeHint=Boolean \
--data org.apache.felix.https.keystore.key=cqse \
--data org.apache.felix.https.keystore.key.password=keypassword \
--data org.apache.felix.https.keystore.password=storepassword \
--data org.apache.felix.https.nio=true \
--data org.apache.felix.https.nio@TypeHint=Boolean \
--data org.apache.felix.https.keystore=crx-quickstart/ssl/keystorename.keystore \
--data org.osgi.service.http.port.secure=$CQ_HTTPS_PORT \
--user admin:admin http://localhost:$CQ_PORT/apps/system/config/org.apache.felix.http;

echo 'Finished setting custom config properties';
        
