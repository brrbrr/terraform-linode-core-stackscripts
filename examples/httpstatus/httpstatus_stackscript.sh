#!/bin/bash

## Domain settings
# <UDF name="ss_hostname" Label="hostname" example="example.host" />

## Linode/SSH Security Settings
#<UDF name="ss_username" label="The limited sudo user to be created for the Linode" default="">
#<UDF name="ss_password" label="The password for the limited sudo user" example="an0th3r_s3cure_p4ssw0rd" default="">
#<UDF name="ss_pubkey" label="The SSH Public Key that will be used to access the Linode" default="">

## Enable logging for the StackScript
exec > >(tee /dev/ttyS0 /var/log/stackscript.log) 2>&1
set -xo pipefail

## Import the Bash StackScript Library (https://cloud.linode.com/stackscripts/1)
source <ssinclude StackScriptID=1>

system_update
debian_upgrade

goodstuff

system_install_package iptables
secure_server "$SS_USERNAME" "$SS_PASSWORD" "$SS_PUBKEY"
# Open port 80 and 443
add_port 'ipv4' 80 'tcp'
add_port 'ipv6' 80 'tcp'
add_port 'ipv4' 443 'tcp'
add_port 'ipv6' 443 'tcp'
save_firewall

system_install_package docker.io
systemctl enable docker 
docker run --rm --name httpstatus -p 80:80 -p 443:443 -d ghcr.io/aaronpowell/httpstatus:936ec2d66410ec300b7db7488064079bfec24978


stackscript_cleanup