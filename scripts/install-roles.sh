#! /bin/bash
# Make rule: install

root_dir=$(realpath "$(dirname "$0")")
cd "$root_dir/.." || exit

installed_roles=$(ansible-galaxy role list 2>/dev/null)

while read -r line || [[ -n $line ]];
do
  if [[ "$installed_roles" != *"$line"* ]];
  then 
    echo "performing install"
    ansible-galaxy role install "$(cat galaxy/roles.txt)"
    exit 0
  fi
done < galaxy/roles.txt