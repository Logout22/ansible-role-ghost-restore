#!/bin/sh
set -o errexit
set -o nounset

export ANSIBLE_FORCE_COLOR=1

run_ansible()
{
    echo "Run Ansible"
    ansible-playbook \
        -e aws_access_key="$AWS_ACCESS_KEY_ID" \
        -e aws_secret_key="$AWS_SECRET_ACCESS_KEY" \
        -v /etc/ansible/roles/ansible-role-ghost-restore/tests/test.yml
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
run_ansible | tee idempotence.log
if grep -q 'changed=0.*failed=0' idempotence.log; then
  echo 'Idempotence test: pass'
else
  echo 'Idempotence test: fail'
  exit 1
fi
