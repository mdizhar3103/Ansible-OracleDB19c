#!/bin/bash

############################################################
# Author: Mohd Izhar
# Description: Script to install Oracle19c DB using ansible
############################################################

echo ">>> Preparing environment"
yum install git ansible -y
echo ">>> Cloning Repo"
git clone https://github.com/mdizhar3103/Ansible-OracleDB19c.git
echo ">>> Repo Cloned"
sleep 5

cd Ansible-OracleDB19c/
echo ">>> Please Provide the Download Link/URL/Local-Path"
read -p '>>> Enter Download Link/URL/Local-Path: ' NEW_LINK_PATH
echo ">>> Entered Value is: $NEW_LINK_PATH"
if [ -z "$NEW_LINK_PATH" ]
then
      echo "Value can't be empty, re-run script and enter correct value."
      exit
fi
echo ">>> Updating The Download path/link/url"
new_val=`echo DOWNLOAD_LINK: $NEW_LINK_PATH`
sleep 2
sed -i -e "/^DOWNLOAD_LINK.*$/d" oracledb/vars/main.yml
echo $new_val >> oracledb/vars/main.yml
echo ">>> Updated Successfully"
sleep 3

echo ">>> Running Plybook - This will take a while, please wait"
sleep 5
ansible-playbook  playbook-oradb.yml 
echo ">>> Playbook execution completed"
sleep 5

echo ">>> Cleaning up the environment"
sleep 3
yum remove ansible -y
rm -rf ../Ansible-OracleDB19c/
echo ">>> Script Completed!"

echo "---"
echo -e ">>> Note: Log in with oracle user and run the following commands to check and verify the installation :\nwhich sqlplus\nsqlplus -V\nsqlplus /nolog"
echo "---"
sleep 5

