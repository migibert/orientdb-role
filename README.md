OrientDB
========

[![Galaxy](http://img.shields.io/badge/ansible--galaxy-orientdb-blue.svg)](https://galaxy.ansible.com/list#/roles/2790)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)  
[![Circle CI](https://circleci.com/gh/migibert/orientdb-role/tree/master.svg?style=shield)](https://circleci.com/gh/migibert/orientdb-role)

This role challenges orientdb management automation. 
For now, it handles installation from website tarballs.
With default values, you can access OrientDB Studio on http://localhost:2480 with credentials root / root

Install it with `ansible-galaxy migibert.orientdb`

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
orientdb_users: Database users that can access all resources. Default value is { name: root, password: root }
orientdb_force_install: If it is set to True, the installation will be forced even if orientdb is already installed in the specified directory
```

Dependencies
------------

This role has no dependencies as it consider a JVM is already present on the target server.

Example Playbook
-------------------------

With all default values
```
- hosts: servers
  roles:
  - { role: migibert.orientdb }
```

With all default values override and no tuning options
```
- hosts: all

  vars:
    orientdb_version: 2.0.1
    orientdb_user: orientdb
    orientdb_user_password: $6$Ls2PCtO6PLby08$Hkh36Sn2V112FSexIHM25dHpnU2P1TflCQbj./e6kf3Pd.25s41uZu9dkeZSU7Ixy4fq.U8PSd6/FzjmSz3An/
    orientdb_dir: /opt    
    orientdb_log_dir: /var/log/orientdb
    orientdb_bind_ip: 0.0.0.0
    orientdb_enable_binary: True
    orientdb_binary_port_range: 2424-2430
    orientdb_enable_ssl: False
    orientdb_ssl_port_range: 2434-2440
    orientdb_enable_http: True
    orientdb_http_port_range: 2480-2490
    orientdb_users:
    - { name: admin, password: admin }
    - { name: root, password: root }

  roles:
  - { role: orientdb-role }
```

With total customization. You do not need to set all these variables, those you do not define keep their default values.
If you need a lot of variables definitions, I highly suggest you to define them outside the playbook.
```
- hosts: all

  vars:
    orientdb_version: 2.0.1
    orientdb_user: orientdb
    orientdb_user_password: $6$Ls2PCtO6PLby08$Hkh36Sn2V112FSexIHM25dHpnU2P1TflCQbj./e6kf3Pd.25s41uZu9dkeZSU7Ixy4fq.U8PSd6/FzjmSz3An/
    orientdb_dir: /opt
    orientdb_path: '{{    orientdb_dir}}/orientdb-community-{{    orientdb_version}}'
    orientdb_log_d  : /var/log/orientdb
    orientdb_bind_ip: 0.0.0.0
    orientdb_enable_binary: True
    orientdb_binary_port_range: 2424-2430
    orientdb_enable_ssl: False
    orientdb_ssl_port_range: 2434-2440
    orientdb_enable_http: True
    orientdb_http_port_range: 2480-2490
    orientdb_users:
    - name: root
      password: root

    orientdb_tuning_properties:
    - name: blueprints.graph.txMode
      value: 0
    - name: environment.dumpCfgAtStartup
      value: false
    - name: environment.concurrent
      value: true
    - name: cache.leve1.enabled
      value: false
    - name: cache.level1.size
      value: 0
    - name: cache.leve2.enabled
      value: false
    - name: cache.level2.size
      value: 0
    - name: client.channel.minPool
      value: 1
    - name: client.channel.maxPool
      value: 5
    - name: db_pool_min
      value: 1
    - name: db.pool.max
      value: 50
    - name: db.mvcc
      value: true
    - name: distributed.async.timeDelay
      value: 0
    - name: distributed.sync.maxRecordsBuffer
      value: 100
    - name: file.lock
      value: false
    - name: file.defrag.strategy
      value: 0
    - name: file.defrag.holeMaxDistance
      value: 32768
    - name: file.mmap.useOldManager
      value: false
    - name: file.mmap.lockMemory
      value: true
    - name: file.mmap.strategy
      value: 0
    - name: file.mmap.blockSize
      value: 1048576
    - name: file.mmap.bufferSize
      value: 8192
    - name: file.mmap.maxMemory
      value: 134Mb
    - name: file.mmap.overlapStrategy
      value: 2
    - name: file.mmap.forceDelay
      value: 500
    - name: file.mmap.forceRetry
      value: 20
    - name: index.auto.rebuildAfterNotSoftClose
      value: true
    - name: jna.disable.system.library
      value: true
    - name: lazyset.workOnStream
      value: false
    - name: log.console.level
      value: info
    - name: log.file.level
      value: fine
    - name: memory.optimizeTreshold
      value: 0.85
    - name: mvrbtree.lazyUpdates
      value: 1
    - name: mvrbtree.nodePageSize
      value: 128
    - name: mvrbtree.loadFactor
      value: 0.7f
    - name: mvrbtree.optimizeTreshold
      value: 100000
    - name: mvrbtree.entryPoints
      value: 16
    - name: mvrbtree.entryPointsFactor
      value: 1.0f
    - name: mvrbtree.ridBinaryTreshold
      value: 8
    - name: mvrbtree.ridNodePageSize
      value: 16
    - name: mvrbtree.ridNodeSaveMemory
      value: false
    - name: nonTX.recordUpdate.synch
      value: false
    - name: network.socketBufferSize
      value: 32768
    - name: network.lockTimeout
      value: 15000
    - name: network.socketTimeout
      value: 10000
    - name: network.retry
      value: 5
    - name: network.retryDelay
      value: 500
    - name: network.binary.maxLength
      value: 100000
    - name: network.binary.readResponse_max_time
      value: 30
    - name: network.binary.debug
      value: false
    - name: network.http.maxLength
      value: 100000
    - name: network.http.charset
      value: utf-8
    - name: network.http.sessionExpireTimeout
      value: 300
    - name: object.saveOnlyDirty
      value: false
    - name: profiler.enabled
      value: true
    - name: profiler.autoDump.interval
      value: 0
    - name: profiler.autoDump.reset
      value: true
    - name: profiler.config
      value: null
    - name: server.channel.cleanDelay
      value: 5000
    - name: server.log.dumpClientExceptionLevel
      value: FINE
    - name: server.log.dumpClientExceptionFullStackTrace
      value: false
    - name: server.cache.staticFile
      value: false
    - name: storage.keepOpen
      value: true
    - name: storage.record.lockTimeout
      value: 5000
    - name: tx.useLog
      value: true
    - name: tx.log_fileType
      value: classic
    - name: tx.log.synch
      value: false
    - name: tx.commit.synch
      value: true

  roles:
  - role: migibert.orientdb
```

Running in distribtued mode. Set `orientdb_enable_distributed` to `true` to enable distributed mode. Under `orientdb_distributed` you can either enable multicast or use tcp for discovery. If using tcp then you need to specify at least one node in `tcp_members`.

```
orientdb_enable_distributed: true

orientdb_distributed:
  multicast: False
  tcp_enabled: False
  tcp_members:
  - 192.168.22.5-10:2434
  - 192.168.18.22:2434
```

License
-------

MIT

Author Information
------------------

Mikaël Gibert, Developer / Devops
