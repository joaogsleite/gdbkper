#!/usr/bin/env sh

if [ ! -f .env ]; then
if [ ! -f .env.example ]; then
  echo "You must mount \$PWD into /backup: docker run -it --rm -v \$PWD:/backup n1zes/gdbkper $1 $2"
  echo "\$PWD folder must have a .env OR .env.example file"
  exit 1
else
  cp .env.example .env
fi
fi

source .env

if [ $1 == "init" ]; then
  gdrive about
  TOKEN=$(cat /root/.gdrive/token_v2.json | jq '.refresh_token')
  echo "
GDBKPER_TOKEN=$TOKEN
" >> .env
  exit
fi

mkdir -p /root/.gdrive/
echo "{
  \"access_token\": \"ya29.Il-iB_S6N1F6h3lcf6cvqJa26POF2Dni-4WXcr85mhbI20i6qbgt6GiNU9h2JTI2IDm36TqQEpP9iB_lblLvIsl1_ussa95yE-LXosxootFXP3JhHf7E0G2vAvAgEHCeow\",
  \"token_type\": \"Bearer\",
  \"refresh_token\": \"$GDBKPER_TOKEN\",
  \"expiry\": \"2019-01-01T23:08:05.517928506Z\"
}" > /root/.gdrive/token_v2.json

if [ $1 == "backup" ]; then
  NAME=$(date +%Y-%m-%d-%H-%M-%S)
  zip -1 -o /root/$NAME.zip -r .env $GDBKPER_FILES
  gdrive upload --parent $GDBKPER_FOLDER_ID /root/$NAME.zip
  exit
fi

if [ $1 == "restore" ]; then
  if [ -z "$2" ]; then
    echo "You must specify a query for restore command"
    exit 1
  fi
  rm -rf /root/*
  LIST=$(gdrive list --no-header --query "'$GDBKPER_FOLDER_ID' in parents and name contains '$2'")
  FILE_ID=$(echo $LIST|cut -d' ' -f1)
  gdrive download --path /root $FILE_ID
  unzip /root/*.zip
  rm -r /root/*
  exit
fi
