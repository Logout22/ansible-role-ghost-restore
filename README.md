Ghost Restore
=============

A role to restore a Ghost blog from AWS S3.
It is designed to work together with
[ansible-role-ghost-backup](https://github.com/Logout22/ansible-role-ghost-backup).

Requirements
------------

Make sure that Python and pip are installed on your hosts.
Right now, only SQLite is supported as backend database for Ghost.

Installation
------------

- Create a Python venv:

      python3 -m venv venv
      source venv/bin/activate

- Install Ansible and Python requirements:

      pip install -r requirements.txt

- Install Ansible roles:

      ansible-galaxy install -r roles/requirements.yml

- Run the tests:

      ANSIBLE_ROLES_PATH=..:$ANSIBLE_ROLES_PATH \
        ansible-playbook \
        -e aws_access_key=$AWS_ACCESS_KEY_ID \
        -e aws_secret_key=$AWS_SECRET_ACCESS_KEY \
        tests/test.yml

  The role requires a dedicated Ghost user, so you will need to run the tests either as root (sudo)
  or change the target user and path in `tests/test.yml` to your own user account / home directory.
  Alternatively, you can build one of the docker containers from the `ci/` folder
  and try the role there.

Role Variables
--------------

tbd

Dependencies
------------

None

Example Playbook
----------------

tbd

License
-------

GPL3
