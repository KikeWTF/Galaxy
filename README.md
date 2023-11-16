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

> 📝 The documentation for each role is automatically generated from the `README.md` file in each role's directory.

> ⚠️ The tested platforms for each role are listed in the [`meta/main.yml`](./meta/main.yml) file. However, the roles may work on other platforms as well.

### 🤖 Proxmox

<details><summary>
    📁 <a href="./roles/proxmox/lxc/"><b>proxmox/lxc</b></a>
</summary>

This role downloads, creates and manages [LXC](https://linuxcontainers.org/lxc/) containers on [Proxmox](https://www.proxmox.com/) hosts.

</details>

### 🧑🏽‍🔧 Services

<details><summary>
    📁 <a href="./roles/services/duckdns/"><b>services/duckdns</b></a>
</summary>

This role installs and manage [DuckDNS](https://www.duckdns.org/), a free dynamic DNS service.

</details>

<details><summary>
    📁 <a href="./roles/services/caido/"><b>services/caido</b></a>
</summary>

This role installs and manage [Caido](https://caido.io/), a lightweight web security auditing toolkit.

</details>

<details><summary>
    📁 <a href="./roles/services/ldap/"><b>services/ldap</b></a>
</summary>

This role installs and configures [OpenLDAP](https://www.openldap.org/) on the server and [SSSD](https://sssd.io/) on any host. It can be used to set up centralized LDAP authentication and authorization for users and groups.

</details>
