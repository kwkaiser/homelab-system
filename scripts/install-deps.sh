#! /bin/bash
# Make rule: install

root_dir=$(realpath "$(dirname "$0")")
cd "$root_dir/.." || exit

installed_roles=$(ansible-galaxy role list 2>/dev/null)
installed_collections=$(ansible-galaxy collection list | grep -v - | grep -v Version | grep -v '#' | awk '{print $1}' 2>/dev/null)

while read -r line || [[ -n $line ]];
do
  if [[ "$installed_roles" != *"$line"* ]];
  then 
    echo "performing role install"
    ansible-galaxy role install "$line"
    exit 0
  fi
done < galaxy/roles.txt

while read -r line || [[ -n $line ]];
do
  if [[ "$installed_collections" != *"$line"* ]];
  then 
    echo "performing collection install"
    ansible-galaxy collection install "$line"
    exit 0
  fi
done < galaxy/collections.txt