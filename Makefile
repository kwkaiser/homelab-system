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

.phony: vm-up vm-down ssh
vm-up:
	./scripts/vm-toggle.sh up

vm-down:
	./scripts/vm-toggle.sh down

ssh:
	ssh -o "StrictHostKeyChecking no" kwkaiser@192.168.58.68

###########
# ansible #
###########

.phony: install deploy redeploy k8s-config k8s-dns k8s

install:
	./scripts/install-deps.sh

deploy-dev: vm-up
	ANSIBLE_CONFIG=inv/dev/ansible.cfg ansible-playbook -i inv/dev setup-lab.yml $(verbosity) 

deploy-prod:
	ANSIBLE_CONFIG=inv/prod/ansible.cfg ansible-playbook -i inv/prod -kK test.yml $(verbosity) 

redeploy: | clean deploy

k8s: k8s-config 

k8s-config:
	rm -rf $$HOME/.kube/config
	mkdir -p $$HOME/.kube
	ansible -i inv/dev homelab-mainarray -b -m fetch -a 'dest=/home/kwkaiser/.kube/config src=/etc/rancher/k3s/k3s.yaml flat=true'
	chmod 600 $$HOME/.kube/config

k8s-dns:
	kubectl rollout restart deployment/coredns -n kube-system

############
# cleaning #
############

.phony: clean-pg

clean-app:
	ansible homelab-mainarray -b -m shell -a 'rm -rf /bulk-pool/nfs/application/*'