# 🕸️ Caido Role

This role downloads, installs and manage [Caido](https://caido.io/), a lightweight web security auditing toolkit.

> 🚨 Each time this role is executed, it will update Caido to the latest version.

## 📚 Table of Contents

- [Requirements](#-requirements)
- [States](#-states)
- [Variables](#-variables)
- [Example Playbook](#-example-playbook)

## 💚 Requirements

- Ansible 2.15.5 or later.
- A target host running a supported operating system (see [`meta/main.yml`](./meta/main.yml) for a list of supported platforms).

## 🏷️ States

The following states are available for this role:

| State     | Description                                           |
| --------- | ----------------------------------------------------- |
| `present` | Ensure that the service is installed but not running. |
| `started` | Ensure that the service is installed and running.     |
| `absent`  | Ensure that the service is uninstalled.               |

## 🪄 Variables

The following variables can be set to customize the service:

| Variable   | Default | Description      |
| ---------- | ------- | ---------------- |
| caido_port | `1337`  | TCP port to use. |

## 📒 Example Playbooks

Here are some example playbooks for this role:

```yaml
# Install the service with default values.
- hosts: caido.home.lab
  become: true
  roles: [{ role: services/caido, state: present }]

# Install and start the service specifiying a custom port.
- hosts: caido.home.lab
  become: true
  roles: [{ role: services/caido, state: started }]
  vars:
    caido_port: 8080

# Start the service if installed.
- hosts: caido.home.lab
  become: true
  roles: [{ role: services/caido, state: started }]

# Stop the service.
- hosts: caido.home.lab
  become: true
  roles: [{ role: services/caido, state: present }]

# Uninstall the service.
- hosts: caido.home.lab
  become: true
  roles: [{ role: services/caido, state: absent }]
```
