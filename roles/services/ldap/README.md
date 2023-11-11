# 👥 LDAP Role

This role installs and configures [OpenLDAP](https://www.openldap.org/) on the server and [SSSD](https://sssd.io/) on any host. It can be used to set up centralized LDAP authentication and authorization for users and groups.

## 📚 Table of Contents

- [Requirements](#-requirements)
- [States](#-states)
- [Variables](#-variables)
- [Features](#-features)
    - [Encryption](#-encryption)
    - [Sudo Rules](#-sudo-rules)
    - [Password Policies](#-password-policies)
- [Example Playbook](#-example-playbook)

## 💚 Requirements

- Ansible 2.9 or later.
- A target host running a supported operating system (see [`meta/main.yml`](./meta/main.yml) for a list of supported platforms).

## 🏷️ States

The following states are available for this role:

| State | Description |
| --- | --- |
| `present` | Ensure that the LDAP client/server is installed and configured. |
| `configured` | Alias for `present`. |
| `started` | Ensure that the LDAP client/server is installed, configured and running. |
| `stopped` | Ensure that the LDAP client/server is installed and configured but not running. |
| `absent` | Ensure that the LDAP client/server is not installed. |

## 🪄 Variables

The following variables can be set to customize the LDAP configuration:

| Side | Variable | Default | Description |
| --- | --- | --- | --- |
| Server | ldap_admin_pass | `ldapadminldap` | Password of the administrative user (LAM also uses this password). |
| Server | ldap_admin_user | `admin` | Username of the administrative user. |
| Server | ldap_default_group | `users` | The default group to use for new users. |
| Server | ldap_default_pass | `changeme` | The default password to use for new users. |
| Both | ldap_dn | `dc=home,dc=lab` | The base DN for LDAP searches. |
| Both | ldap_fqdn | `ldap.home.lab` | The FQDN of the LDAP server. |
| Server | ldap_lam | `true` | Enable LDAP Account Manager (LAM). |
| Server | ldap_maxid | `30000` | The maximum UID/GID number to use for LDAP users/groups. |
| Server | ldap_minid | `10000` | The minimum UID/GID number to use for LDAP users/groups. |
| Both | ldap_port | `389` if not TLS, else `636` | The port to use for LDAP connections. |
| Both | ldap_proxy_pass | `readonly` | The password to use for the read-only user. |
| Both | ldap_proxy_user | `proxy` | The username for the read-only user. |
| Server | ldap_server_ip | `192.168.1.2` | The IP address of the LDAP server. |
| Server | ldap_sudo_rules | `[]` | A list of sudo rules to create in LDAP. |
| Both | ldap_tls | `true` | Enable LDAPS and disable LDAP. |
| Server | ldap_utils | `true` | Enable LDAP Utils. |
| Server | ldap_users | `[]` | A list of users (and inherit groups) to create in LDAP. |

## ✨ Features

This role was designed to be used in a home lab environment. It is not intended to be used in production.

However, it can be used to set up a basic LDAP server that has the following features:

### 🔐 Encryption

The OpenLDAP server is configured to use TLS for secure connections. The TLS certificate and key are generated using [`openssl`](https://www.openssl.org/). The certificate is self-signed by default but trusted among all hosts in the inventory.

The self-signed certificates can be found in `/etc/ldap/sasl2/` on the LDAP server and `/etc/sssd/ldap.crt` on all other hosts.

The offered TLS ciphers are the following:

```
SECURE128:PFS:-VERS-SSL3.0:-VERS-TLS-ALL:+VERS-TLS1.2:+VERS-TLS1.3:-SHA1:-ARCFOUR-128
```

Strong ciphers are used by default. This is the [`nmap`](https://nmap.org/) report:

<details>
<summary>ssl-enum-ciphers.nse</summary>

```rb
PORT    STATE SERVICE
636/tcp open  ldapssl
| ssl-enum-ciphers: 
|   TLSv1.2: 
|     ciphers: 
|       TLS_DHE_RSA_WITH_AES_128_CCM (dh 2048) - A
|       TLS_DHE_RSA_WITH_AES_128_GCM_SHA256 (dh 2048) - A
|       TLS_DHE_RSA_WITH_AES_256_CCM (dh 2048) - A
|       TLS_DHE_RSA_WITH_AES_256_GCM_SHA384 (dh 2048) - A
|       TLS_DHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (dh 2048) - A
|       TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (secp256r1) - A
|       TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (secp256r1) - A
|       TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (secp256r1) - A
|       TLS_RSA_WITH_AES_128_CCM (rsa 4096) - A
|       TLS_RSA_WITH_AES_128_GCM_SHA256 (rsa 4096) - A
|       TLS_RSA_WITH_AES_256_CCM (rsa 4096) - A
|       TLS_RSA_WITH_AES_256_GCM_SHA384 (rsa 4096) - A
|     compressors: 
|       NULL
|     cipher preference: client
|     warnings: 
|       Key exchange (dh 2048) of lower strength than certificate key
|       Key exchange (secp256r1) of lower strength than certificate key
|   TLSv1.3: 
|     ciphers: 
|       TLS_AKE_WITH_AES_128_CCM_SHA256 (secp256r1) - A
|       TLS_AKE_WITH_AES_128_GCM_SHA256 (secp256r1) - A
|       TLS_AKE_WITH_AES_256_GCM_SHA384 (secp256r1) - A
|       TLS_AKE_WITH_CHACHA20_POLY1305_SHA256 (secp256r1) - A
|     cipher preference: client
|_  least strength: A
```

</details>

### 🗝️ Sudo Rules

The LDAP server is configured to store sudo rules in LDAP. The sudo rules can be found under `ou=sudo` on the LDAP server.

The default schema for sudo rules is the following:

<details>
<summary>sudo.ldif</summary>

```ldif
dn: ou=sudoers,<dc>
objectClass: organizationalUnit
ou: sudoers
description: Sudoers organizational unit

dn: cn=defaults,<dc>
objectClass: top
objectClass: sudoRole
cn: defaults
description: Default sudo rules
sudoOption: env_reset
sudoOption: env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_CO
 LORS"
sudoOption: env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
sudoOption: env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAG
 ES"
sudoOption: env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
sudoOption: env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORI
 TY"
sudoOption: secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/l
 ocal/bin

dn: cn=sudoers,ou=groups,<dc>
cn: sudoers
gidNumber: 10000
description: Sudoers users
objectClass: posixGroup
```

</details>

To create new sudo rules, use the `ldap_sudo_rules` variable. For example:

```yaml
ldap_sudo_rules:
    # User rules
  - name: puma
    host: ALL
    runas: root
    command: /usr/bin/id

    # Group rules
  - name: '%management'
    host: ALL
    runas: ALL
    command: ALL
```

If you want a user to be able to run any command as any user on any host, you can use the `sudo` attribute in the `ldap_users` variable. For example:

```yaml
ldap_users:
  - surname: Puma
    sudo: true
```

## 📃 Password Policies

The LDAP server is configured to force passwords to be at least 8 characters long and a bit complex. The password policies can be found under `ou=policies` on the LDAP server.

> 💡 Users that use `ldap_default_pass` as password will be forced to change their password on first login.

The default schema for password policies is the following:

<details>
<summary>ppolicies.ldif</summary>

```ldif
dn: ou=policies,<dc>
ou: policies
description: Policies organizational unit
objectClass: organizationalUnit

dn: cn=default,ou=policies,<dc>
cn: default
pwdAttribute: userPassword
pwdMaxAge: 0
pwdExpireWarning: 0
pwdCheckQuality: 2
pwdMinLength: 8
pwdInHistory: 5
pwdMaxFailure: 5
pwdGraceAuthNLimit: 0
pwdFailureCountInterval: 0
pwdLockout: TRUE
pwdLockoutDuration: 1800
pwdMustChange: TRUE
pwdAllowUserChange: TRUE
pwdSafeModify: TRUE
objectClass: top
objectClass: device
objectClass: pwdPolicy
```

</details>

## 📒 Example Playbook

Here's an example playbook that uses the LDAP role:

```yaml
# Install, configure and start the LDAP server with default values.
- hosts: ldap.home.lab
  become: true
  roles: service/ldap

# Install, configure and start the LDAP client with default values.
- hosts: all:!ldap.home.lab
  become: true
  roles: service/ldap

# Install and configure the LDAP server and clients with a custom domain and a custom manager.
- hosts: all
  become: true
  roles:
    - role: service/ldap
      vars:
        ldap_server_ip: 10.10.10.11
        ldap_fqdn: ldap.example.com
        ldap_admin_user: 'DC Manager'
        ldap_admin_pass: Sup3r!SeCreT!P42s

# Install and configure the LDAP server with custom users and groups, and disable ldap-utils and LAM.
- hosts: all
  become: true
  roles:
    - role: service/ldap
      vars:
        ldap_lam: false
        ldap_utils: false
        ldap_users:
          - name: Kike
            surname: Puma
            sudo: true
          - surname: Ansible
            group: management
            system: true
            sudo: true
          - surname: Guest
            groups: guests

# Stop all the services
- hosts: all
  become: true
  roles:
    - role: services/ldap
      state: stopped

# Uninstall the LDAP server and clients.
- hosts: all
  become: true
  roles:
    - role: service/ldap
      state: absent
```

## ✅ TODOs

- [ ] Implement "automount" via LDAP.
- [ ] Implement "hosts" via LDAP (maybe).
- [ ] RedHat / CentOS / Fedora support.