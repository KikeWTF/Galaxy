<h1 align="center">
    <a href="#"><img src="https://github.com/kikewtf/galaxy/raw/main/.github/readme/logo.png" alt="Galaxy" width="300" /></a>
    <br />
    <a href="https://github.com/kikewtf/galaxy/homelab/issues">
        <img src="https://img.shields.io/github/issues/kikewtf/homelab?color=fab387&labelColor=303446&style=for-the-badge" />
    </a>
    <a href="https://github.com/kikewtf/homelab">
        <img src="https://img.shields.io/github/repo-size/kikewtf/homelab?color=ea999c&labelColor=303446&style=for-the-badge" />
    </a>
    <br/>
    <a href="https://www.ansible.com/">
        <img src="https://img.shields.io/badge/ansible%20version->=2.15.5-b4befe?labelColor=303446&style=for-the-badge&logo=ansible" />
    </a>
    <br />
</h1>

<div align="center">
<hr/>

```yaml
🏠 Self-Hosted Homelab 🏠
🌌 Automation via Ansible 🌌
```

<hr/>
<h1></h1>
</div>

The following is a list of available Ansible roles for my own self-hosted Homelab setup:

## 🗃️ Ansible Roles Documentation

📁 **Role**: [proxmox](./roles/proxmox/)

✏️ **Details**: Streamlines the [Proxmox](https://www.proxmox.com/en/) management process. This role allows you to create templates and virtual machines effortlessly (similar to [Terraform](https://www.terraform.io/)).
It also allows you to manage the status of VMs.

📁 **Role**: [services/ldap](./roles/services/ldap/)

✏️ **Details**: This role installs and configures [OpenLDAP](https://www.openldap.org/) on the server and [SSSD](https://sssd.io/) on any host. It can be used to set up centralized LDAP authentication and authorization for users and groups.