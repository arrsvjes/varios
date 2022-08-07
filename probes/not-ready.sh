#!/bin/bash

APP_URL=$(oc get route probes -o jsonpath='{..spec.host}{"\n"}')
curl http://$APP_URL/flip?op=kill-ready
