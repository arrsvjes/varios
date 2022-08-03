#!/bin/bash

source /usr/local/etc/ocp4.config
oc set build-hook bc/hook --post-commit --command -- \
    bash -c "\"curl -s -S -i -X POST http://builds-for-managers-${RHT_OCP4_DEV_USER}-post-commit.${RHT_OCP4_WILDCARD_DOMAIN}/api/builds -f -d 'developer=\${DEVELOPER}&git=\${OPENSHIFT_BUILD_SOURCE}&project=\${OPENSHIFT_BUILD_NAMESPACE}'\""

oc set build-hook bc/hook --post-commit --command -- \
    bash -c "\"curl -s -S -i -X POST http://buildformanagers-toorrm-dev.apps.sandbox-m2.ll9k.p1.openshiftapps.com/api/builds -f -d 'developer=\${DEVELOPER}&git=\${OPENSHIFT_BUILD_SOURCE}&project=\${OPENSHIFT_BUILD_NAMESPACE}'\""
