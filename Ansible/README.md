## 🤖 Ansible: IaC for Server Configuration 🛠️ 🔧
Ansible is an automation tool that allows you to define and manage server configurations across various systems. This project includes playbooks for common server setup tasks.

### Common Package Installation and SSH Hardening
---
This section guides you through installing common packages and hardening SSH configurations on your servers using Ansible, streamlining your server management process.

🔧 **Features:**
- Automated installation of common packages
- SSH security enhancements
- Support for both Debian/Ubuntu and Rocky/Fedora/RHEL systems

📝 **Prerequisites:**
- Ansible installed on your local machine
- SSH access to target servers
- Basic understanding of YAML and Ansible concepts

### Contents:
* `inventory`: defines the structure of your inventory file, including hosts and variables
* `ansible.cfg`: configures Ansible settings for your playbooks
* `base_pkg_install.yml`: installs common packages on Debian/Ubuntu and Rocky/Fedora/RHEL systems

### Getting Started

- Clone this repository to your local machine
- Navigate to the Ansible directory
- Edit the `inventory` file to include your target servers
- Review and modify the `base_pkg_install.yml` file to customize the list of packages to install
- Run the playbook

