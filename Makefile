########
# util #
########

.phony: list graph 

graph:
	make -Bnd $(target) | make2graph | dot -Tpng -o dep-graph.png

list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | grep -E -v -e '^[^[:alnum:]]' -e '^$@$$'

clean: vm-down

#######
# vms #
#######

.phony: vm-up vm-down
vm-up:
	./scripts/vm-toggle.sh up

vm-down:
	./scripts/vm-toggle.sh down

###########
# ansible #
###########

.phony: install deploy redeploy

install:
	./scripts/install-roles.sh	

deploy: vm-up
	ansible-playbook setup-lab.yml

redeploy: | clean deploy
