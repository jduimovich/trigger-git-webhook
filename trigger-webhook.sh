 #!/bin/bash
 # trigger-webhook  
URL=http://$1
TAG=$2 
if [ -z "$TAG" ]
then 
  TAG=$(date +"%Y-%m-%d-%H%M%S") 
fi  
echo "$0 $URL $TAG "

FILE=$(mktemp) 
PATCH=".head_commit.id=\"$TAG\""   
jq "$PATCH" payload.json > $FILE   
curl --silent -d @$FILE -H 'Content-Type: application/json'  $URL | jq
 
 