#!/bin/env bash

OCP_USER="admin"
OCP_PASS="redhat"
OCP_URL="https://api.ocp4.example.com:6443"

RHSSO_URL="keycloak-rhsso.apps.ocp4.example.com"
RHSSO_PORT="443"
#vars cannot start with a number
T_SCALE_PROJECT=3scale

ocp_login() {
    oc login -u "${OCP_USER}" -p "${OCP_PASS}" "${OCP_URL}"
}

save_rhsso_cert() {
    echo -n | openssl s_client -connect "${RHSSO_URL}":"${RHSSO_PORT}" -servername "${RHSSO_URL}" --showcerts | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > customCA.pem
}

inject_rhsso_cert_to_zync() {
    zync_pod=$(oc -n "${T_SCALE_PROJECT}" get pods -l threescale_component_element=zync-que -o name)
    oc -n "${T_SCALE_PROJECT}" exec "${zync_pod}" --  cat /etc/pki/tls/cert.pem > zync.pem
    # Add RHSSO cert to zync's cert chain
    cat customCA.pem >> zync.pem
    oc -n "${T_SCALE_PROJECT}" create configmap zync-new-ca-bundle --from-file=./zync.pem
    oc -n "${T_SCALE_PROJECT}" set volume dc/zync-que --add --name=zync-new-ca-bundle \
      --mount-path /etc/pki/tls/zync/zync.pem \
      --sub-path zync.pem \
      --source='{"configMap":{"name":"zync-new-ca-bundle","items":[{"key":"zync.pem","path":"zync.pem"}]}}' \
    && oc -n "${T_SCALE_PROJECT}" set env dc/zync-que SSL_CERT_FILE=/etc/pki/tls/zync/zync.pem
}

main() {
    ocp_login
    save_rhsso_cert
    inject_rhsso_cert_to_zync
}

main