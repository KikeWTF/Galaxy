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

| State | Description |
| --- | --- |
| `present` | Ensure that the Caido service is installed and configured. |
| `configured` | Alias for `present`. |
| `started` | Ensure that the Caido service is installed, configured and running. |
| `stopped` | Ensure that the Caido service is installed, configured but not running. |
| `absent` | Ensure that the Caido service is uninstalled. |

## 🪄 Variables

The following variables can be set to customize the Caido service:

| Variable | Default | Description |
| --- | --- | --- |
| caido_port | `1337` | TCP port to use for the Caido service. |

## 📒 Example Playbooks

Here are some example playbooks for this role:

```yaml
# Download, install, configure and start the Caido service with default values.
- hosts: caido.home.lab
  become: true
  roles: services/caido

# Download, install, configure and start the Caido service with custom values.
- hosts: caido.home.lab
  become: true
  roles:
    - role: services/caido
      vars:
        caido_port: 8080

# Start the caido service.
- hosts: caido.home.lab
  become: true
  roles:
    - role: services/caido
      state: started

# Stop the caido service.
- hosts: caido.home.lab
  become: true
  roles:
    - role: services/caido
      state: stopped

# Stop and uninstall the Caido service.
- hosts: caido.home.lab
  become: true
  roles:
    - role: services/caido
      state: absent
```
