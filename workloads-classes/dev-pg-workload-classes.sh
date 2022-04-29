#!/bin/bash

oc new-app --name=dev-pg-workload-classes \
  --template=postgresql-persistent-sc \
  -p STORAGECLASS_NAME=pg-development-storage \
  -p VOLUME_CAPACITY=150Mi \
  -p POSTGRESQL_USER=developer \
  -p POSTGRESQL_PASSWORD=devel \
  -p POSTGRESQL_DATABASE=dev-workloads-classes \
  -p DATABASE_SERVICE_NAME=dev-pg-workload-classes-ge
