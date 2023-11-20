.PHONY: default
default: all

.PHONY: all services
all: proxmox services
services: loki spiderman ultron

.PHONY: proxmox
proxmox:
	@echo "--------------------------------------------------------------"
	@echo " Running '$@' playbook..."
	@echo "--------------------------------------------------------------"
	@echo
	@ansible-playbook -kuroot playbooks/hosts/$@.yml -t started
	@echo
	@echo "--------------------------------------------------------------"
	@echo " '$@' playbook finished. Waiting for boot..."
	@echo "--------------------------------------------------------------"
	@sleep 10

.PHONY: loki spiderman ultron
loki spiderman ultron:
	@echo "--------------------------------------------------------------"
	@echo " Running '$@' playbook..."
	@echo "--------------------------------------------------------------"
	@echo
	@ansible-playbook -uroot playbooks/hosts/$@.yml -t started
	@echo
	@echo "--------------------------------------------------------------"
	@echo " '$@' playbook finished."
	@echo "--------------------------------------------------------------"

.PHONY: start
start: services

.PHONY: stop
stop:
	@echo "--------------------------------------------------------------"
	@echo " Stopping all the services..."
	@echo "--------------------------------------------------------------"
	@echo
	@ansible-playbook -uroot playbooks/hosts/loki.yml -t present
	@ansible-playbook -uroot playbooks/hosts/ultron.yml -t present
	@ansible-playbook -uroot playbooks/hosts/spiderman.yml -t present
	@echo
	@echo "--------------------------------------------------------------"
	@echo " All services stopped."
	@echo "--------------------------------------------------------------"