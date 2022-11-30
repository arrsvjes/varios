#!/bin/bash
app_name="monetizing_billing_app"
t_scale_ns="3scale"

db_pass=$(oc -n $t_scale_ns get secret system-database -o json | jq -r .data.DB_PASSWORD | base64 -d )
mysql_pod=$(oc -n $t_scale_ns get po -l threescale_component_element=mysql --no-headers | grep "Running" | head -n1 | awk '{print $1}')
update_contract="update cinstances set trial_period_expires_at = date_add(now(), interval -1 day), created_at = date_add(now(), interval -1 day)  where name = '$app_name';"
mysql="/opt/rh/rh-mysql57/root/usr/bin/mysql"

oc -n $t_scale_ns exec $mysql_pod -i -t -- $mysql -u mysql -p"$db_pass" system -e "$update_contract"