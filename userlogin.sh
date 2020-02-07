#!/bin/bash
_remote_username=username
_remote_password=password
_current_password=

for i in `cat serverlist.txt `
do
sshpass -p $_current_password ssh -o StrictHostKeyChecking=no $remote_username@$i "echo '$_remote_username:$_remote_password' | sudo chpasswd"
done
