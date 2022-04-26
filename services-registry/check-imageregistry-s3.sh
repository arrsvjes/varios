#!/bin/bash
set -e

# Getting image registry storage type
oc get deployment/image-registry \
  -n openshift-image-registry \
  -o jsonpath='{.spec.template.spec.containers[*].env}' | \
jq -r '.[] | select(.name == "REGISTRY_STORAGE") | [.name , .value] | @tsv'

# Retrieving image registry S3 storage parameters
oc get deployment/image-registry \
  -n openshift-image-registry \
  -o jsonpath='{.spec.template.spec.containers[*].env}' | \
jq -r '.[] | select(.name | startswith("REGISTRY_STORAGE_S3")) | [.name , .value] | @tsv'
