#!/usr/bin/env bash

#see https://rollout-rest-api.cloudbees.com/reference#authentication
APPLICATION_ID="5f36579640106f6ecc025857"
USER_TOKEN="bff622c1-d6b4-4c52-a00a-b36455fbe929"
URL="https://x-api.rollout.io/public-api/applications"
echo "${URL}/${APPLICATION_ID}/environments"

#list all environments
curl  "${URL}/${APPLICATION_ID}/environments" \
 -H "Authorization: Bearer ${USER_TOKEN}" \
 -H 'accept: application/json' |jq

echo "add repeat experiment"
curl -X PUT  ${URL}/${APPLICATION_ID}/Production/experiments \
  -H "Authorization: Bearer ${USER_TOKEN}" \
  -H 'content-type: application/json' \
  --data '{"type":"experiment","apiVersion":"1.0","flag":"repeat","name":"repeatExperiment","description":"Applies repeat to app","enabled":true,"labels":"do-not-merge","stickinessProperty":"fixed","value":true}'
echo "add shuffle experiment"
curl -X PUT  ${URL}/${APPLICATION_ID}/Production/experiments \
  -H "Authorization: Bearer ${USER_TOKEN}" \
  -H 'content-type: application/json' \
  --data '{"type":"experiment","apiVersion":"1.0","flag":"shuffle","name":"shuffleExperiment","description":"Applies shuffle to app","enabled":true,"labels":"do-not-merge","stickinessProperty":"fixed","value":true}'

#list all experiemnts https://rollout-rest-api.cloudbees.com/reference#experiments
curl "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/Production/experiments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" |jq
 
#list all experiemnts with value false
curl "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/Production/experiments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" |jq '.[] | select(.value==false)'

#list all experiemnts with value true
curl "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/Production/experiments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" | jq '.[] | select(.value==true)'

#curl "https://x-api.rollout.io/public-api/applications/applicationId/${APPLICATION_ID}/Production/flagName" \
#  -H 'accept: application/json' \
#  -H "Authorization: Bearer ${USER_TOKEN}" | jq
