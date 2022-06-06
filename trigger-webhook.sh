 #!/bin/bash
 # trigger-webhook  
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

URL=http://$1
TAG=$2 
if [ -z "$TAG" ]
then 
  TAG=$(date +"%Y-%m-%d-%H%M%S") 
fi  
echo "$0 $URL $TAG "

FILE=$(mktemp) 
PATCH=".head_commit.id=\"$TAG\""   
jq "$PATCH" $SCRIPTDIR/payload.json > $FILE   
#
curl.exe --silent --insecure -d @$FILE -H 'Content-Type: application/json'  $URL | jq
 
 