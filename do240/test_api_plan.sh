#!/bin/bash

USER_KEY=$1
COMMAND="curl -s https://api-3scale-apicast-staging.apps.ocp4.example.com:443/library/books?user_key=${USER_KEY}"

echo "Making 100 requests to ${COMMAND}"

for i in {1..100}; do
    echo "Request No: ${i}"
    $COMMAND > /dev/null
done

echo "Finished!"
