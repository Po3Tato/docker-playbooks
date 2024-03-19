## Ansible Introduction
This Ansible repo contains beginner playbooks that can be tweaked around to your heart's desire. I created this repo to automate fresh server instances initial setup.

### Key Points:

- Default or everyday personal use applications can be installed right after the server has been deployed
- Hardening of ssh login and disabling password login

### Getting Started and Usage
If you are reading this I will assume you have Anible installed on your computer. If you do not then i recommend installing it first before you continue.
Do not forget to create a `secrets.yml`(any name) and update accordingly

To create a `secrets.yml` run this command in terminal
```
ansible-vault create secret.yml
```
This will promot you to input a password. Do not forget the password as you will need it every time you run a playbook with hidden variables.
The location of your `secrets.yml` matter. If you put it in the global Ansible folder, it will apply to all subfolders. If you put it in a specific subdolder make sure to point the secrets folder when running ansible.
```
ansible-playbook run.yml --extra-vars @secrets.yml
#if secrets.yml is in the root directory
```

- Create a `host.txt` file. This will contain all the devices you will want ansible to interact with.
---
If you are encountering any issues feel free to reach out.