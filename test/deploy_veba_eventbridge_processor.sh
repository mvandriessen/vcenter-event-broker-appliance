#!/bin/bash
# Copyright 2020 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

# Sample Shell Script to test deployment of VEBA w/AWS EventBridge Processor

OVFTOOL_BIN_PATH="/Applications/VMware OVF Tool/ovftool"
VEBA_OVA="../output-vmware-iso/vCenter_Event_Broker_Appliance_0.4.0-beta.ova"

# vCenter
DEPLOYMENT_TARGET_ADDRESS="192.168.30.200"
DEPLOYMENT_TARGET_USERNAME="administrator@vsphere.local"
DEPLOYMENT_TARGET_PASSWORD="VMware1!"
DEPLOYMENT_TARGET_DATACENTER="Primp-Datacenter"
DEPLOYMNET_TARGET_CLUSTER="Supermicro-Cluster"

VEBA_NAME="VEBA-TEST-AWS-EVENTBRIDGE-PROCESSOR"
VEBA_IP="192.168.30.170"
VEBA_HOSTNAME="veba.primp-industries.com"
VEBA_PREFIX="24 (255.255.255.0)"
VEBA_GW="192.168.30.1"
VEBA_DNS="192.168.30.1"
VEBA_DNS_DOMAIN="primp-industries.com"
VEBA_NTP="pool.ntp.org"
VEBA_OS_PASSWORD="VMware1!"
VEBA_NETWORK="VM Network"
VEBA_DATASTORE="sm-vsanDatastore"
VEBA_DEBUG="True"
VEBA_VCENTER_SERVER="192.168.30.200"
VEBA_VCENTER_USER="administrator@vsphere.local"
VEBA_VCENTER_PASS="VMware1!"
VEBA_VCENTER_DISABLE_TLS="True"
VEBA_AWS_EVENTBRIDGE_ACCESS_KEY="FILL_ME_IN_PLEASE"
VEBA_AWS_EVENTBRIDGE_ACCESS_SECRET="FILL_ME_IN_PLEASE"
VEBA_AWS_EVENTBRIDGE_EVENT_BUS="FILL_ME_IN_PLEASE"
VEBA_AWS_EVENTBRIDGE_REGION="us-west-2"
VEBA_AWS_EVENTBRIDGE_RULE_ARN="FILL_ME_IN_PLEASE"

### DO NOT EDIT BEYOND HERE ###

"${OVFTOOL_BIN_PATH}" \
    --powerOn \
    --noSSLVerify \
    --sourceType=OVA \
    --allowExtraConfig \
    --diskMode=thin \
    --name="${VEBA_NAME}" \
    --net:"VM Network"="${VEBA_NETWORK}" \
    --datastore="${VEBA_DATASTORE}" \
    --prop:guestinfo.ipaddress=${VEBA_IP} \
    --prop:guestinfo.hostname=${VEBA_HOSTNAME} \
    --prop:guestinfo.netmask="${VEBA_PREFIX}" \
    --prop:guestinfo.gateway=${VEBA_GW} \
    --prop:guestinfo.dns=${VEBA_DNS} \
    --prop:guestinfo.domain=${VEBA_DNS_DOMAIN} \
    --prop:guestinfo.ntp=${VEBA_NTP} \
    --prop:guestinfo.root_password=${VEBA_OS_PASSWORD} \
    --prop:guestinfo.vcenter_server=${VEBA_VCENTER_SERVER} \
    --prop:guestinfo.vcenter_username=${VEBA_VCENTER_USER} \
    --prop:guestinfo.vcenter_password=${VEBA_VCENTER_PASS} \
    --prop:guestinfo.vcenter_disable_tls_verification=${VEBA_VCENTER_DISABLE_TLS} \
    --prop:guestinfo.event_processor_type="AWS EventBridge" \
    --prop:guestinfo.aws_eb_access_key=${VEBA_AWS_EVENTBRIDGE_ACCESS_KEY} \
    --prop:guestinfo.aws_eb_access_secret=${VEBA_AWS_EVENTBRIDGE_ACCESS_SECRET} \
    --prop:guestinfo.aws_eb_event_bus=${VEBA_AWS_EVENTBRIDGE_EVENT_BUS} \
    --prop:guestinfo.aws_eb_region=${VEBA_AWS_EVENTBRIDGE_REGION} \
    --prop:guestinfo.aws_eb_arn=${VEBA_AWS_EVENTBRIDGE_RULE_ARN} \
    --prop:guestinfo.debug=${VEBA_DEBUG} \
    "${VEBA_OVA}" \
    "vi://${DEPLOYMENT_TARGET_USERNAME}:${DEPLOYMENT_TARGET_PASSWORD}@${DEPLOYMENT_TARGET_ADDRESS}/${DEPLOYMENT_TARGET_DATACENTER}/host/${DEPLOYMNET_TARGET_CLUSTER}"
