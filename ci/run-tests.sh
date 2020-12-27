#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

run_ansible()
{
    echo "Run Ansible"
    ansible-playbook \
        -e aws_access_key="$AWS_ACCESS_KEY_ID" \
        -e aws_secret_key="$AWS_SECRET_ACCESS_KEY" \
        -v /etc/ansible/roles/ansible-role-ghost-restore/tests/test.yml | tee ansible.log
    if grep -q 'failed=[1-9]' ansible.log; then
        echo 'Ansible failed'
        exit 1
    fi
}

. venv/bin/activate
echo "Install requirements"
pip install -r /etc/ansible/roles/ansible-role-ghost-restore/requirements.txt
echo "Install roles"
ansible-galaxy install -r /etc/ansible/roles/ansible-role-ghost-restore/roles/requirements.yml
echo "Check syntax"
ansible-playbook -v /etc/ansible/roles/ansible-role-ghost-restore/tests/test.yml --syntax-check
echo "Run linter"
ansible-lint /etc/ansible/roles/ansible-role-ghost-restore
echo "Run ansible"
run_ansible
echo "Run idempotence test"
run_ansible
if grep -q 'changed=[1-9]' ansible.log; then
  echo 'Idempotence test: fail'
  exit 1
else
  echo 'Idempotence test: pass'
fi
