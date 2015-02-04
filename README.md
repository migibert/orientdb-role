OrientDB
========

[![Galaxy](http://img.shields.io/badge/ansible--galaxy-orientdb-blue.svg)](https://galaxy.ansible.com/list#/roles/2790)

This role challenges orientdb management automation.
For now, it handles installation from website tarballs.

Requirements
------------

OrientDB is written in Java and needs a JVM for running. This role does not cover this installation and consider as a prerequisite a JVM presence and a defined $JAVA_HOME environment variable.

Role Variables
--------------

```
orientdb_version: OrientDB server version. Default value is 2.0.1.
orientdb_user: System user, OrientDB directories owner. Default value is orientdb.
orientdb_user_password: Hashed value of orientdb_user password. Default value is hashed 'orientdb' : $6$Ls2PCtO6PLby08$Hkh36Sn2V112FSexIHM25dHpnU2P1TflCQbj./e6kf3Pd.25s41uZu9dkeZSU7Ixy4fq.U8PSd6/FzjmSz3An/
orientdb_dir: Installation directory. Default is /opt
orientdb_path: Installation path, used by server scripts for $ORIENTDB_HOME definition. Default value is '{{orientdb_dir}}/orientdb-community-{{orientdb_version}}'
orientdb_log_dir: Log directory for orientdb server.
orientdb_bind_ip: Server ip to bind. Default value is 0.0.0.0
orientdb_enable_binary: Enables binary communication with server. Default value is True
orientdb_binary_port_range: Port range associated to binary communication. Default value is 2424-2430
orientdb_enable_ssl: Enables ssl communication with server. Default value is False
orientdb_ssl_port_range: Port range associated to ssl communication. Default value is 2434-2440
orientdb_enable_http: Enables http communication with server. Default value is True
orientdb_http_port_range: Port range associated to http communication. Default value is 2480-2490
```

Dependencies
------------

This role has no dependencies as it consider a JVM is already present on the target server.

Example Playbook
-------------------------

```
- hosts: servers
  roles:
  - { role: migibert.orientdb }
```

License
-------

MIT

Author Information
------------------

Mikaël Gibert, Developer / Devops
