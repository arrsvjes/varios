#!/bin/bash

oc new-app --name=pg-capacity-extend \
  --template=postgresql-persistent-sc \
  -p STORAGECLASS_NAME=ocs-storagecluster-ceph-rbd \
  -p VOLUME_CAPACITY=30Mi \
  -p POSTGRESQL_USER=student \
  -p POSTGRESQL_PASSWORD=redhat \
  -p POSTGRESQL_DATABASE=capacity-extend-ge \
  -p DATABASE_SERVICE_NAME=pg-capacity-extend-ge
