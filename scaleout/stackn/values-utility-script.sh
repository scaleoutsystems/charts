#!/bin/bash

# v0.1.0
# Script can be improved by for example taking into account that this works only first time
# Later times strings such as <your-domain.com> and <your-k8s-config> will already be overwritten

set -e

echo "Running the utility script for setting up variables within the values.yaml file..."
# Extract currently assigned IP address (which is connected to Internet!)

echo "Extracting IP address..."
my_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo "Your current IP address is: $my_ip"

# Extract used network interface - Just for sysadmin purposes
#my_interface=$(ip route get 8.8.8.8 | awk -F"dev " 'NR==1{split($2,a," ");print a[1]}')

# Replace <your-domain.com> field with extracted IP adress in values.yaml file
echo "Replacing $my_ip inside the values.yaml file..."
echo "Appending nip.io wildcardars..."
sed -i "s/<your-domain.com>/$my_ip.nip.io/g" ./values.yaml
echo "Your current STACKn domain will be: $my_ip.nip.io"


# Generate k8s cluster config file - NOTE: we assume that microk8s is already installed and configured
cluster_config=$(microk8s.config | base64 | tr -d '\n')

# Replace <your-k8s-config> field in the chart-controller-secret.yaml file with the above create variable
sed -i "s/<your-k8s-config>/$cluster_config/g" ./templates/chart-controller-secret.yaml

echo "Done"

