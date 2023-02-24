#! /bin/bash

export VAGRANT_EXPERIMENTAL=disks

vm_status=$(vagrant status 2>/dev/null)

if [[ "$vm_status" != *"running"* ]] && [[ "$1" == 'up' ]];
then
  vagrant up
fi

if [[ "$vm_status" != *"not created"* ]] && [[ "$1" == 'down' ]];
then
  vagrant destroy -f
fi