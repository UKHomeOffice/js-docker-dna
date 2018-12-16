#!/usr/bin/env bash
exe() { sleep 4;echo "" ;echo "\$ [info] $@"; sleep 5 ; "$@" ;sleep 3 ;echo "";}


echo "\$  -- delete tmp-js-docker-dna folder"
exe rm -rf /Users/aabdi/workspace/tmp-js-docker-dna

echo "\$  -- clone into tmp-js-docker-dna"

exe git clone https://github.com/Abdul2/js-docker-dna.git /Users/aabdi/workspace/tmp-js-docker-dna


echo "\$  --- assuming you have downloaded files into Downloads folder"


echo "\$  -- cd to /Users/aabdi/workspace/tmp-js-docker-dna"
exe cd ${HOME}/workspace/tmp-js-docker-dna

echo "\$  -- copy files from Downloads "
exe cp ${HOME}/Downloads/TIB_js-jrs_7.1.0_bin.zip js/.
exe cp ${HOME}/Downloads/jasperserver.license js/.
exe cp ${HOME}/Downloads/default_master.properties js/.
exe cp ${HOME}/Downloads/apache-tomcat-8.5.35.tar.gz tomcat/.

echo "\$  -- stop all runnign containers"
exe docker stop $(docker ps -a -q)

echo "\$  -- remove all containers"
exe docker rm $(docker ps -a -q)


echo "\$  -- remove all images"
exe docker rmi -f $(docker images -a -q)

echo "\$  -- cd to tomcat folder"
exe cd /Users/aabdi/workspace/tmp-js-docker-dna/tomcat

echo "\$  -- build tomcat image"
exe docker build -t tomcat   .

echo "\$  -- stand up a postgres container and associate its IP with js container"
exe docker run --name js-postgres -e POSTGRES_PASSWORD=password -d postgres
exe export ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' js-postgres)



echo "\$  -- cd to js"
exe cd /${HOME}/workspace/tmp-js-docker-dna/js

echo "\$  -- update the default_master.propeties "
exe sed -i -- "s/js-db-host/$ip/" default_master.properties

echo "\$  -- build js"
docker build -t js .

echo "\$  -- run js container"
exe docker run -d -p 8090:8080  js

echo go to http://localhost:8090/jasperserver-pro
