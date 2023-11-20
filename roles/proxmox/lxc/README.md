# 📦 Proxmox LXC Role

This role downloads, creates and manages [LXC](https://linuxcontainers.org/lxc/) containers on [Proxmox](https://www.proxmox.com/) hosts.

## 📚 Table of Contents

- [Requirements](#-requirements)
- [States](#-states)
- [Variables](#-variables)
  - [Proxmox](#-proxmox)
  - [Containers](#-containers)
- [Example Playbook](#-example-playbook)

## 💚 Requirements

- Ansible 2.15.5 or later.
- A target host running a supported Proxmox operating system (see [`meta/main.yml`](./meta/main.yml) for a list of supported platforms).

## 🏷️ States

The following states are available for this role:

| State | Description |
| --- | --- |
| `present` | Ensure that the LXC containers are created and configured. |
| `configured` | Alias for `present`. |
| `started` | Ensure that the LXC containers are created, configured and running. |
| `stopped` | Ensure that the LXC containers are created, configured but not running. |
| `absent` | Ensure that the LXC containers are not created. |

## 🪄 Variables

### 💽 Proxmox

The following variables can be set to customize the LXC configuration:

| Variable | Default | Description |
| --- | --- | --- |
| ldap_admin_pass | `ldapadminldap` | Password of the administrative user (LAM also uses this password). |
| proxmox_admin_user | `{{ ansible_user }}@pam` | Username of the Proxmox instance. |
| proxmox_admin_pass | `{{ ansible_password }}` | Password of the Proxmox instance. |
| proxmox_container_minid | `1000` | Minimum ID for the LXC containers. |
| proxmox_container_storage | `local-lvm` | Storage for the LXC containers. |
| proxmox_containers | `[]` | List of LXC containers to create. |
| proxmox_default_cores | `1` | Default number of cores for the LXC containers. |
| proxmox_default_disk | `8` | Default disk size for the LXC containers (in GB). |
| proxmox_default_memory | `512` | Default memory size for the LXC containers (in MB). |
| proxmox_default_dns | `192.168.1.1` | Default DNS server for the LXC containers. |
| proxmox_default_searchdomain | `lab` | Default search domain for the LXC containers. |
| proxmox_default_password | `{{ proxmox_admin_pass }}` | Default password for the LXC containers. |
| proxmox_storage | `local` | Storage for the LXC templates. |
| proxmox_timezone | `Europe/Madrid` | Timezone for the LXC containers. |

### 📦 Containers

The `proxmox_containers` variable can be used to create LXC containers. The accepted values are the following:

| Variable     | Default                                           | Description                                                                  |
| ------------ | ------------------------------------------------- | ---------------------------------------------------------------------------- |
| cores        | `{{ proxmox_default_cores }}`                     | Number of cores of the LXC container.                                        |
| description  | `{{ name }}`                                      | Description of the LXC container.                                            |
| disk         | `{{ proxmox_default_disk }}`                      | Disk size of the LXC container (in GB).                                      |
| distro       |  **required** (no defaults)                       | Template of the LXC container. It should be available via `pveam available`. |
| ipv4         | **required** (no defaults)                        | IPv4 address of the LXC container.                                           |
| memory       | `{{ proxmox_default_memory }}`                    | Memory size of the LXC container (in MB).                                    |
| mounts       | omitted                                           | List of mounts (external disks) for the LXC container.                       |
| name         | **required** (no defaults)                        | Name and hostname of the LXC container.                                      |
| nameserver   | `{{ proxmox_default_dns }}`                       | DNS server of the LXC container.                                             |
| onboot       | `true`                                            | Whether the LXC container should start on boot.                              |
| password     | `{{ ansible_password }}`                          | `root` password of the LXC container.                                        |
| pubkey       | omitted                                           | SSH public key to add to the `root` user of the LXC container.               |
| searchdomain | `{{ proxmox_default_searchdomain }}`              | Search domain of the LXC container.                                          |
| storage      | `{{ proxmox_container_storage }}`                 | Storage of the LXC container.                                                |
| swap         | omitted                                           | Swap size of the LXC container (in MB).                                       |
| tags         | `[ {{ distro }} ]`                                | Tags of the LXC container.                                                   |
| vmid         | `proxmox_minid` + Latest octect of the IP address | ID of the LXC container.                                                     |

## 📒 Example Playbooks

Here are some example playbooks for this role:

```yaml
# Download, create, configure and start a LXC container with default values.
- hosts: proxmox.home.lab
  become: true
  roles: proxmox/lxc
  vars:
    proxmox_containers:
      - name: helloworld
        ipv4: 10.10.10.1
        distro: debian-12-standard_12.2-1_amd64.tar.zst

# Download, create, configure and start a LXC container with shared mount.
- hosts: proxmox.home.lab
  become: true
  roles: proxmox/lxc
  vars:
    proxmox_containers:
      - name: nas
        ipv4: 10.10.10.2
        distro: debian-12-standard_12.2-1_amd64.tar.zst
        mounts:
          - mp0: /mnt/pve/storage,mp=/mnt/storage

# Download, create, configure and start a LXC container with custom values.
- hosts: proxmox.home.lab
  become: true
  roles: proxmox/lxc
  vars:
    proxmox_containers:
      - name: helloworld
        ipv4: 192.168.12.5
        cpu: 2
        memory: 1024
        disk: 16
        searchdomain: example.com
        distro: gentoo-current-openrc_20231009_amd64.tar.xz

# Start all the LXC containers.
- hosts: proxmox.home.lab
  become: true
  roles:
    - role: proxmox/lxc
      state: started

# Stop all the LXC containers.
- hosts: proxmox.home.lab
  become: true
  roles:
    - role: proxmox/lxc
      state: stopped

# Stop and remove all the LXC containers.
- hosts: proxmox.home.lab
  become: true
  roles:
    - role: proxmox/lxc
      state: absent

# Stop and remove some LXC containers.
- hosts: proxmox.home.lab
  become: true
  roles:
    - role: proxmox/lxc
      state: absent
  vars:
    proxmox_containers:
      - ipv4: 10.10.10.1
      - ipv4: 192.168.12.5
```
