# 🦆 DuckDNS Role

This role installs and manages [DuckDNS](https://www.duckdns.org/), a free dynamic DNS service.

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

| Required | Variable        | Default | Description                                                               |
| ---      | --------------- | ------- | ------------------------------------------------------------------------- |
| ✔        | duckdns_domains | `[]`    | A list of domains to update (more than zero, without the `.duckdns.org`). |
| ✔        | duckdns_token   | -       | The DuckDNS token to use for authentication.                              |

## 📒 Example Playbooks

Here are some example playbooks for this role:

```yaml
# Install the service omitting the token.
- hosts: dyndns.home.lab
  become: true
  roles: [{ role: services/duckdns, state: present }]
  vars: { duckdns_domains: [homedns] }

# Install and start the service specifiying the token.
- hosts: dyndns.home.lab
  become: true
  roles: [{ role: services/duckdns, state: started }]
  vars:
    duckdns_domains: [homedns]
    duckdns_token: 12345678-1234-4321-1234-123456789012

# Start the service if installed.
- hosts: dyndns.home.lab
  become: true
  roles: [{ role: services/duckdns, state: started }]

# Stop the service.
- hosts: dyndns.home.lab
  become: true
  roles: [{ role: services/duckdns, state: present }]

# Uninstall the service.
- hosts: dyndns.home.lab
  become: true
  roles: [{ role: services/duckdns, state: absent }]
```
