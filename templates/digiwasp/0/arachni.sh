#!/bin/bash


dispatcher_number=${1:-"2"}



cat ../../../../arachni.agent | docker build -t arachni.agent -
cat ../../../../arachni.webui | docker build -t arachni.webui -

docker-compose -f ./arachni.yml up -d

docker-compose -f ./arachni.yml scale dispatcher=${dispatcher_number}

#sh ./arachni.dispatcher.register

# show what we've setup
docker-compose -f /tmp/arachni.yml ps 
webui=$(docker ps |grep arachni_webui |awk '{print $1}')
docker exec $webui bin/arachni_web_script "Dispatcher.select(:address).each { |record| p \"Webui Dispatcher: #{record['address']} Description : #{record['description']}\" }" 
