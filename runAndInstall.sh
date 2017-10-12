#!/bin/bash

# install fluorine
if [ ! -z "$3" ]; then
echo "Installing package $1 stream $2 version $3"
/usr/bin/apt-get ---yes update && /usr/bin/apt-get ---yes --force-yes --allow-unauthenticated install "$1"-"$2"="$3" || exit $?
else
echo "Installing package $1 stream $2 latest version"
/usr/bin/apt-get ---yes update && /usr/bin/apt-get ---yes --force-yes --allow-unauthenticated install "$1"-"$2" || exit $?
fi

unzip -j /opt/graebert-gmbh/Fluorine/fluorine-1.0.0-SNAPSHOT-fat.jar config.json -d /opt/graebert-gmbh/Fluorine/


if [ -z "$LICENSING" ]; then
	echo "Licensing service not configured"
	exit 1
elif [ "$LICENSING" == "test" ]; then
	licensing="licensing-service-testing.graebert.com"
	customerPortal="customer-portal-testing.graebert.com"
elif [ "$LICENSING" == "live" ]; then
	licensing="licensing-service.graebert.com"
	customerPortal="customer-portal.graebert.com"
fi

accountid=$ACCOUNTID


# environment config sets
if [ -z "$DBPARAMS" ]; then
  echo "No Environment Set"
  exit 1
elif [ "$DBPARAMS" == "development" ]; then
        dynamodb="kudo_development"
        dynamodbLocal="kudo_development"
        dynamodbregion="us-east-1"
        dynamodbregionLocal="us-east-1"
        s3region="us-east-1"
        s3bucket="kudo-development-user-data"
        oauth="oauth.dev.graebert.com"
        websocket="ws.dev.graebert.com"
        delta="false"
        timeout="30"
        logentriesToken="3eb3daed-e135-4cf8-a20e-aba126e7efa7"
        statsdKey="d335e1b4-2cdc-443a-89b6-798e554e3e6f"
        statsdHost="localhost"
        statsdPort="8125"
        statsdPrefix="development"
        elasticacheEnabled="false"
        elasticacheEndpoint="elasticache.ydg19a.cfg.use1.cache.amazonaws.com"
        elasticachePort="11211"
        isIndependentLogin="true"
        isOnshapeAllowed="true"
        isTrimbleAllowed="true"
        isKudoAllowed="true"
        isEditAllowed="true"
        sesregion="us-east-1"
        xray="true"
		host="127.0.0.1"
		sqsRegion="eu-west-1"
		thumbnailBucket="kudo-thumbnails"
		thumbnailBucketRegion="us-east-1"
		sqsQueue="ThumbnailsQueue"
		sqsResponseQueue="ThumbnailResponses"
		OneDriveClientId="f65ed1bf-8937-4c07-874a-d2a168254af5"
		OneDriveClientSecret="CaiKKPeHjKvYpBWTuhuxEn5"
		BoxClientId="gyvfy3gkpyeib2oyxsh1eu59348xoeec"
        BoxClientSecret="jQNm8bjM5y5O9qhun2Hyhs1U1vWARtgk"
		TrimbleOauthKey="_puSLfeLaLpFPwLRiXOHI_AvRfoa"
		TrimbleOauthSecret="Gel9WFfMKLw2Qhp8sarT1ELF04sa"
		TrimbleIdentityURL="identity-stg.trimble.com"
		TrimbleApiURL="staging.qa1.gteam.com"
		domain="dev.graebert.com"
elif [ "$DBPARAMS" == "development-production" ]; then
        dynamodb="kudo_development"
        dynamodbLocal="kudo_development"
        dynamodbregion="us-east-1"
        dynamodbregionLocal="us-east-1"
        s3region="us-east-1"
        s3bucket="kudo-development-user-data"
        oauth="oauth.dev.graebert.com"
        websocket="ws.dev.graebert.com"
        delta="false"
        timeout="30"
        logentriesToken="3eb3daed-e135-4cf8-a20e-aba126e7efa7"
        statsdKey="d335e1b4-2cdc-443a-89b6-798e554e3e6f"
        statsdHost="localhost"
        statsdPort="8125"
        statsdPrefix="development"
        elasticacheEnabled="false"
        elasticacheEndpoint="cache-development.ydg19a.cfg.use1.cache.amazonaws.com"
        elasticachePort="11211"
        isIndependentLogin="false"
        isOnshapeAllowed="false"
        isTrimbleAllowed="false"
        isKudoAllowed="false"
        isEditAllowed="false"
        sesregion="us-east-1"
        xray="true"
		host="127.0.0.1"
		sqsRegion="eu-west-1"
		thumbnailBucket="kudo-thumbnails"
		thumbnailBucketRegion="us-east-1"
		sqsQueue="ThumbnailsQueue"
		sqsResponseQueue="ThumbnailResponses"
		OneDriveClientId="f65ed1bf-8937-4c07-874a-d2a168254af5"
		OneDriveClientSecret="CaiKKPeHjKvYpBWTuhuxEn5"
		BoxClientId="gyvfy3gkpyeib2oyxsh1eu59348xoeec"
        BoxClientSecret="jQNm8bjM5y5O9qhun2Hyhs1U1vWARtgk"
		TrimbleOauthKey="_puSLfeLaLpFPwLRiXOHI_AvRfoa"
		TrimbleOauthSecret="Gel9WFfMKLw2Qhp8sarT1ELF04sa"
		TrimbleIdentityURL="identity-stg.trimble.com"
		TrimbleApiURL="staging.qa1.gteam.com"
		domain="dev.graebert.com"
elif [ "$DBPARAMS" == "staging" ]; then
        dynamodb="kudo_staging"
		dynamodbLocal="kudo_staging"
		dynamodbregion="eu-central-1"
		dynamodbregionLocal="eu-central-1"
        s3region="eu-central-1"
        s3bucket="kudo-staging-data"
		oauth="oauth.kudo.graebert.com"
		websocket="ws-staging.kudo.graebert.com"
		delta="false"
		timeout="30"
        logentriesToken="ea1ea04a-37d9-45fc-8729-b47660b0c0a5"
        statsdKey="d335e1b4-2cdc-443a-89b6-798e554e3e6f"
        statsdHost="localhost"
        statsdPort="8125"
        statsdPrefix="staging"
        elasticacheEnabled="false"
        elasticacheEndpoint=""
        elasticachePort=""
        isIndependentLogin="false"
        isOnshapeAllowed="false"
        isTrimbleAllowed="true"
        isKudoAllowed="false"
        isEditAllowed="false"
        sesregion="eu-west-1"
		xray="true"
		host="127.0.0.1"
		sqsRegion="eu-central-1"
		thumbnailBucket="kudo-staging-thumbnails"
		thumbnailBucketRegion="eu-central-1"
		sqsQueue="ThumbnailsQueue"
		sqsResponseQueue="ThumbnailResponses"
		OneDriveClientId="f65ed1bf-8937-4c07-874a-d2a168254af5"
		OneDriveClientSecret="CaiKKPeHjKvYpBWTuhuxEn5"
		BoxClientId="2j93yprw2jfctez000zb5d3cy55asa08"
        BoxClientSecret="HocVfcoVgbXlUwfcHiPzXirmcCuoNg9O"
		TrimbleOauthKey="57wWwrCO86fzm4wv3YNUKT8RygAa"
		TrimbleOauthSecret="Z7COHphNnrG3IubG8FO1tBolHasa"
		TrimbleIdentityURL="identity.trimble.com"
		TrimbleApiURL="app.connect.trimble.com"
		domain="kudo.graebert.com"
elif [ "$DBPARAMS" == "production" ]; then
        dynamodb="kudo_production"
		dynamodbLocal="kudo_production"
		dynamodbregion="eu-central-1"
		dynamodbregionLocal="eu-central-1"
        s3region="eu-central-1"
        s3bucket="kudo-production-data"
		oauth="oauth.kudo.graebert.com"
		websocket="ws.kudo.graebert.com"
		delta="false"
		timeout="30"
        logentriesToken="2fb0d4ef-6d9c-478f-9f2a-2b1315d30aa9"
        statsdKey="d335e1b4-2cdc-443a-89b6-798e554e3e6f"
        statsdHost="localhost"
        statsdPort="8125"
        statsdPrefix="production"
        elasticacheEnabled="false"
        elasticacheEndpoint=""
        elasticachePort=""
        isIndependentLogin="false"
        isOnshapeAllowed="false"
        isTrimbleAllowed="false"
        isKudoAllowed="false"
        isEditAllowed="false"
        sesregion="eu-west-1"
		xray="true"
		delta="false"
		host="127.0.0.1"
		sqsRegion="eu-central-1"
		thumbnailBucket="kudo-production-thumbnails"
		thumbnailBucketRegion="eu-central-1"
		sqsQueue="ThumbnailsQueue"
		sqsResponseQueue="ThumbnailResponses"
		OneDriveClientId="f65ed1bf-8937-4c07-874a-d2a168254af5"
		OneDriveClientSecret="CaiKKPeHjKvYpBWTuhuxEn5"
		BoxClientId="2j93yprw2jfctez000zb5d3cy55asa08"
        BoxClientSecret="HocVfcoVgbXlUwfcHiPzXirmcCuoNg9O"
		TrimbleOauthKey="57wWwrCO86fzm4wv3YNUKT8RygAa"
		TrimbleOauthSecret="Z7COHphNnrG3IubG8FO1tBolHasa"
		TrimbleIdentityURL="identity.trimble.com"
		TrimbleApiURL="app.connect.trimble.com"
		domain="kudo.graebert.com"
fi


sed -i 's/VAR_EMAIL_SERVER/email-smtp.us-east-1/' /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_EMAIL_REGION/$sesregion/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_S3_REGION/$s3region/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_DYNAMO_REGION/$dynamodbregion/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_DYNAMO_LOCAL_REGION/$dynamodbregionLocal/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_ELASTICACHE_ENABLED/$elasticacheEnabled/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_ELASTICACHE_ENDPOINT/$elasticacheEndpoint/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_ELASTICACHE_PORT/$elasticachePort/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/\"VAR_DEMO_KUDO\"/$isKudoAllowed/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/\"VAR_DEMO_TRIMBLE\"/$isTrimbleAllowed/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/\"VAR_DEMO_ONSHAPE\"/$isOnshapeAllowed/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/\"VAR_DEMO_EDITOR\"/$isEditAllowed/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_DYNAMO_PREFIX/$dynamodb/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_DYNAMO_LOCAL_PREFIX/$dynamodbLocal/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_S3_BUCKET/$s3bucket/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_LICENSING/$licensing/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_OAUTH/$oauth/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_WEBSOCKET/$websocket/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_DELTA/$delta/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_TIMEOUT/$timeout/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_XRAY/$xray/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_HOST/$host/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_THUMBNAIL_BUCKET/$thumbnailBucket/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_SQS_REGION/$sqsRegion/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_SQS_QUEUE/$sqsQueue/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_SQS_RESPONSE_QUEUE/$sqsResponseQueue/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_SQS_AWS_ACCOUNT/$accountid/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_ONEDRIVE_CLIENT_ID/$OneDriveClientId/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_ONEDRIVE_CLIENT_SECRET/$OneDriveClientSecret/" /opt/graebert-gmbh/Fluorine/config.json				  
sed -i "s/VAR_BOX_CLIENT_ID/$BoxClientId/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_BOX_CLIENT_SECRET/$BoxClientSecret/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_TRIMBLE_KEY/$TrimbleOauthKey/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_TRIMBLE_SECRET/$TrimbleOauthSecret/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_TRIMBLE_IDENTITY_URL/$TrimbleIdentityURL/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_TRIMBLE_API_URL/$TrimbleApiURL/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_STATSD_KEY/$statsdKey/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_STATSD_HOST/$statsdHost/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_STATSD_PORT/$statsdPort/" /opt/graebert-gmbh/Fluorine/config.json
sed -i "s/VAR_STATSD_PREFIX/$statsdPrefix/" /opt/graebert-gmbh/Fluorine/config.json


if [ -z "$APIURL" ]; then
sed -i "s,VAR_API_SERVER,https://$SERVICE_80_NAME.$domain," /opt/graebert-gmbh/Fluorine/config.json
else
sed -i "s,VAR_API_SERVER,https://$APIURL," /opt/graebert-gmbh/Fluorine/config.json
fi

if [ -z "$APIURL" ]; then
sed -i "s,VAR_API_SERVER,https://$SERVICE_80_NAME.$domain," /usr/share/nginx/www/fluorine.json
else
sed -i "s,VAR_API_SERVER,https://$APIURL," /usr/share/nginx/www/fluorine.json
fi

sed -i "s,VAR_EDITOR_SERVER,$EDITOR," /usr/share/nginx/www/fluorine.json
sed -i "s/\"VAR_DEMO_EDITOR\"/$isEditAllowed/" /usr/share/nginx/www/fluorine.json
sed -i "s/VAR_DEBUG/$DEBUG_EDITOR/" /usr/share/nginx/www/fluorine.json
sed -i "s/\"VAR_CHANGE_URL\"/$DEBUG_EDITOR/" /usr/share/nginx/www/fluorine.json
sed -i "s/\"VAR_TRIAL\"/$TRIAL/" /usr/share/nginx/www/fluorine.json
sed -i "s/\"VAR_INDEPENDENT_LOGIN\"/$isIndependentLogin/" /usr/share/nginx/www/fluorine.json
sed -i "s/VAR_OAUTH/$oauth/" /usr/share/nginx/www/fluorine.json
sed -i "s/VAR_WEBSOCKET/$websocket/" /usr/share/nginx/www/fluorine.json
sed -i "s/VAR_CUSTOMER_PORTAL/$customerPortal/" /usr/share/nginx/www/fluorine.json
sed -i "s/VAR_TRIMBLE_IDENTITY_URL/$TrimbleIdentityURL/" /usr/share/nginx/www/fluorine.json
sed -i "s/\"VAR_INTERCOM\"/$INTERCOM/" /usr/share/nginx/www/fluorine.json

export LOGENTRIES_TOKEN=$logentriesToken
sed -i "s/VAR_PACKAGE/$1/" /etc/le/conf.d/fluorine.conf
sed -i "s/VAR_STREAM/$2/" /etc/le/conf.d/fluorine.conf
sed -i "s/VAR_REGION/$AWS_DEFAULT_REGION/" /etc/le/conf.d/fluorine.conf

/etc/init.d/logentries restart
/etc/init.d/rsyslog restart
           
sed -i "s/VAR_THUMBNAIL_BUCKET/$thumbnailBucket/g" /etc/nginx/conf.d/fluorine
cp /home/ubuntu/fluorine-site /etc/nginx/sites-enabled/fluorine-site
rm /etc/nginx/sites-enabled/fluorine-site.bak

# Start nginx
service nginx start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# Start fluorine
/etc/init.d/fluorine start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start fluorine: $status"
  exit $status
fi
# give some time for startup
sleep 5

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container will exit with an error
# if it detects that either of the processes has exited.
# Otherwise it will loop forever, waking up every 60 seconds
  
while [ /bin/true ]
do
  ps aux | grep -q "nginx: master process"
  PROCESS_1_STATUS=$?
  ps aux | grep -q '/usr/bin/java -Dvertx.options.workerPoolSize'
  PROCESS_2_STATUS=$?

  echo nginx status $PROCESS_1_STATUS
  echo fluorine status $PROCESS_2_STATUS  
 
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrongcd ../
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done
