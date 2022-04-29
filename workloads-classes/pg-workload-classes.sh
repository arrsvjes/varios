#!/bin/bash

oc new-app --name=pg-workload-classes \
  --template=postgresql-persistent-sc \
  -p STORAGECLASS_NAME=ocs-storagecluster-ceph-rbd-xfs \
  -p VOLUME_CAPACITY=150Mi \
  -p POSTGRESQL_USER=student \
  -p POSTGRESQL_PASSWORD=redhat \
  -p POSTGRESQL_DATABASE=workloads-classes \
  -p DATABASE_SERVICE_NAME=pg-workload-classes-ge
