#! /bin/bash
#see https://rollout-rest-api.cloudbees.com/reference#authentication 

#ENV_PROD_KEY=5e95ad1fa6de03e3b693732d
APPLICATION_ID=5e95ad1fa6de037e1793732b
USER_TOKEN=bff622c1-d6b4-4c52-a00a-b36455fbe929

#list all environments
curl  "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/environments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" |jq 

#list all experiemnts https://rollout-rest-api.cloudbees.com/reference#experiments
curl "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/Production/experiments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" |jq
 
#list all disabled experiemnts
curl "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/Production/experiments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" |jq '.[] | select(.value==false)'

#list all enabled  experiemnts
curl "https://x-api.rollout.io/public-api/applications/${APPLICATION_ID}/Production/experiments" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${USER_TOKEN}" |jq '.[] | select(.value==true)'
