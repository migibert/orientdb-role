OrientDB
========

[![Galaxy](http://img.shields.io/badge/ansible--galaxy-orientdb-blue.svg)](https://galaxy.ansible.com/migibert/orientdb)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)  
[![Circle CI](https://circleci.com/gh/migibert/orientdb-role/tree/master.svg?style=shield)](https://circleci.com/gh/migibert/orientdb-role)

This role challenges orientdb management automation.

With default values, you can access OrientDB Studio on http://localhost:2480 with credentials root / root

Install it with `ansible-galaxy install migibert.orientdb`

> **WARNING**: From version 2.0.0, this role only handles OrientDB >= 3 installations. If you need to manage an OrientDB in version < 3, please use versions 1.x of this role.


Requirements
------------

OrientDB is written in Java and needs a JVM for running. This role does not cover this installation and consider as a prerequisite a JVM presence and a defined $JAVA_HOME environment variable.
Distributed mode relies on Hazelcast which needs Java 8.

Role Variables
--------------
Take a look at default variables to have an idea of a complete configuration.

```
orientdb_autoback_delay: Delay time for auto backups. Default is 4h.
orientdb_autoback: Enables auto backup. Default is False.
orientdb_autoback_start: Start time for auto backup. Default is 23:00:00.
orientdb_autoback_db_include: Databases to include in automatic backup as a list. Default value is [] which means all databases are backed up.
orientdb_autoback_db_exclude: Databases to exclude in automatic backup as a list. Default value is [].
orientdb_version: OrientDB server version. Default value is 2.0.1.
orientdb_user: System user, OrientDB directories owner. Default value is orientdb.
orientdb_user_password: Hashed value of orientdb_user password. Default value is hashed 'orientdb' : $6$Ls2PCtO6PLby08$Hkh36Sn2V112FSexIHM25dHpnU2P1TflCQbj./e6kf3Pd.25s41uZu9dkeZSU7Ixy4fq.U8PSd6/FzjmSz3An/
orientdb_dir: Installation directory. Default is /opt
orientdb_path: Installation path, used by server scripts for $ORIENTDB_HOME definition. Default value is '{{orientdb_dir}}/orientdb-{{orientdb_version}}'
orientdb_log_dir: Log directory for orientdb server.
orientdb_bind_ip: Server ip to bind. Default value is 0.0.0.0
orientdb_enable_graph: Enables graph server. Default value is false.
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
    orientdb_autoback_delay: 4h.
    orientdb_autoback: False
    orientdb_autoback_start: 23:00:00
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
    orientdb_path: '{{orientdb_dir}}/orientdb-community-{{orientdb_version}}'
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
      - name: environment.dumpCfgAtStartup
        value: false
      - name: environment.concurrent
        value: true
      - name: environment.lockManager.concurrency.level
        value: 64
      - name: environment.allowJVMShutdown
        value: true
      - name: script.pool.maxSize
        value: 20
      - name: memory.useUnsafe
        value: true
      - name: memory.chunk.size
        value: 2147483647
      - name: memory.directMemory.safeMode
        value: true
      - name: memory.directMemory.trackMode
        value: false
      - name: memory.directMemory.onlyAlignedMemoryAccess
        value: true
      - name: jvm.gc.delayForOptimize
        value: 600
      - name: storage.openFiles.limit
        value: 512
      - name: storage.componentsLock.cache
        value: 10000
      - name: storage.diskCache.pinnedPages
        value: 20
      - name: storage.diskCache.bufferSize
        value: 4096
      - name: storage.diskCache.writeCachePart
        value: 15
      - name: storage.diskCache.writeCachePageTTL
        value: 86400
      - name: storage.diskCache.writeCachePageFlushInterval
        value: 25
      - name: storage.diskCache.writeCacheFlushInactivityInterval
        value: 60000
      - name: storage.diskCache.writeCacheFlushLockTimeout
        value: -1
      - name: storage.diskCache.diskFreeSpaceCheckInterval
        value: 5
      - name: storage.diskCache.diskFreeSpaceCheckIntervalInPages
        value: 2048
      - name: storage.diskCache.keepState
        value: true
      - name: storage.configuration.syncOnUpdate
        value: true
      - name: storage.compressionMethod
        value: nothing
      - name: storage.encryptionMethod
        value: nothing
      - name: storage.encryptionKey
        value: null
      - name: storage.makeFullCheckpointAfterCreate
        value: false
      - name: storage.makeFullCheckpointAfterOpen
        value: true
      - name: storage.makeFullCheckpointAfterClusterCreate
        value: true
      - name: storage.trackChangedRecordsInWAL
        value: false
      - name: storage.useWAL
        value: true
      - name: storage.wal.syncOnPageFlush
        value: true
      - name: storage.wal.cacheSize
        value: 3000
      - name: storage.wal.fileAutoCloseInterval
        value: 10
      - name: storage.wal.maxSegmentSize
        value: 128
      - name: storage.wal.maxSize
        value: 4096
      - name: storage.wal.commitTimeout
        value: 1000
      - name: storage.wal.shutdownTimeout
        value: 10000
      - name: storage.wal.fuzzyCheckpointInterval
        value: 300
      - name: storage.wal.reportAfterOperationsDuringRestore
        value: 10000
      - name: storage.wal.restore.batchSize
        value: 1000
      - name: storage.wal.readCacheSize
        value: 1000
      - name: storage.wal.fuzzyCheckpointShutdownWait
        value: 600
      - name: storage.wal.fullCheckpointShutdownTimeout
        value: 600
      - name: storage.wal.path
        value: null
      - name: storage.diskCache.pageSize
        value: 64
      - name: storage.diskCache.diskFreeSpaceLimit
        value: 256
      - name: storage.lowestFreeListBound
        value: 16
      - name: storage.lockTimeout
        value: 0
      - name: storage.record.lockTimeout
        value: 2000
      - name: storage.useTombstones
        value: false
      - name: storage.cluster.usecrc32
        value: false
      - name: record.downsizing.enabled
        value: true
      - name: object.saveOnlyDirty
        value: false
      - name: db.pool.min
        value: 1
      - name: db.pool.max
        value: 100
      - name: db.pool.idleTimeout
        value: 0
      - name: db.pool.idleCheckDelay
        value: 0
      - name: db.mvcc.throwfast
        value: false
      - name: db.validation
        value: true
      - name: db.document.serializer
        value: ORecordSerializerBinary
      - name: db.makeFullCheckpointOnIndexChange
        value: true
      - name: db.makeFullCheckpointOnSchemaChange
        value: true
      - name: db.mvcc
        value: true
      - name: db.use.distributedVersion
        value: false
      - name: nonTX.recordUpdate.synch
        value: false
      - name: nonTX.clusters.sync.immediately
        value: manindex
      - name: trackAtomicOperations
        value: false
      - name: tx.commit.synch
        value: false
      - name: tx.autoRetry
        value: 1
      - name: tx.log.fileType
        value: classic
      - name: tx.log.synch
        value: false
      - name: tx.useLog
        value: true
      - name: index.embeddedToSbtreeBonsaiThreshold
        value: 40
      - name: index.sbtreeBonsaiToEmbeddedThreshold
        value: -1
      - name: index.auto.synchronousAutoRebuild
        value: true
      - name: index.auto.lazyUpdates
        value: 10000
      - name: index.flushAfterCreate
        value: true
      - name: index.manual.lazyUpdates
        value: 1
      - name: index.durableInNonTxMode
        value: true
      - name: index.ignoreNullValuesDefault
        value: false
      - name: index.txMode
        value: FULL
      - name: index.cursor.prefetchSize
        value: 500000
      - name: index.auto.rebuildAfterNotSoftClose
        value: true
      - name: hashTable.slitBucketsBuffer.length
        value: 1500
      - name: sbtree.maxDepth
        value: 64
      - name: sbtree.maxKeySize
        value: 10240
      - name: sbtree.maxEmbeddedValueSize
        value: 40960
      - name: sbtreebonsai.bucketSize
        value: 2
      - name: sbtreebonsai.linkBagCache.size
        value: 100000
      - name: sbtreebonsai.linkBagCache.evictionSize
        value: 1000
      - name: sbtreebonsai.freeSpaceReuseTrigger
        value: 0.5
      - name: ridBag.embeddedDefaultSize
        value: 4
      - name: ridBag.embeddedToSbtreeBonsaiThreshold
        value: 40
      - name: ridBag.sbtreeBonsaiToEmbeddedToThreshold
        value: -1
      - name: collections.preferSBTreeSet
        value: false
      - name: file.trackFileClose
        value: false
      - name: file.lock
        value: true
      - name: file.deleteDelay
        value: 10
      - name: file.deleteRetry
        value: 50
      - name: security.userPasswordSaltIterations
        value: 65536
      - name: security.userPasswordSaltCacheSize
        value: 500
      - name: security.userPasswordDefaultAlgorithm
        value: PBKDF2WithHmacSHA256
      - name: security.createDefaultUsers
        value: true
      - name: network.maxConcurrentSessions
        value: 1000
      - name: network.socketBufferSize
        value: 32768
      - name: network.lockTimeout
        value: 15000
      - name: network.socketTimeout
        value: 15000
      - name: network.requestTimeout
        value: 3600000
      - name: network.retry
        value: 5
      - name: network.retryDelay
        value: 500
      - name: network.binary.loadBalancing.enabled
        value: false
      - name: network.binary.loadBalancing.timeout
        value: 2000
      - name: network.binary.maxLength
        value: 16384
      - name: network.binary.readResponse.maxTimes
        value: 20
      - name: network.binary.debug
        value: false
      - name: network.http.installDefaultCommands
        value: true
      - name: network.http.serverInfo
        value: OrientDB Server v {{orientdb_version}}
      - name: network.http.maxLength
        value: 1000000
      - name: network.http.streaming
        value: true
      - name: network.http.charset
        value: utf-8
      - name: network.http.jsonResponseError
        value: true
      - name: network.http.jsonp
        value: false
      - name: network.http.sessionExpireTimeout
        value: 300
      - name: network.http.useToken
        value: false
      - name: network.token.secretKey
        value:
      - name: network.token.encryptionAlgorithm
        value: HmacSHA256
      - name: network.token.expireTimeout
        value: 60
      - name: profiler.enabled
        value: false
      - name: profiler.config
        value: null
      - name: profiler.autoDump.interval
        value: 0
      - name: profiler.maxValues
        value: 200
      - name: sequence.maxRetry
        value: 100
      - name: sequence.retryDelay
        value: 200
      - name: storageProfiler.intervalBetweenSnapshots
        value: 100
      - name: storageProfiler.cleanUpInterval
        value: 5000
      - name: log.console.level
        value: info
      - name: log.file.level
        value: info
      - name: log.console.ansi
        value: auto
      - name: class.minimumClusters
        value: 0
      - name: cache.local.impl
        value: com.orientechnologies.orient.core.cache.ORecordCacheWeakRefs
      - name: cache.local.enabled
        value: true
      - name: command.timeout
        value: 0
      - name: command.cache.enabled
        value: false
      - name: command.cache.evictStrategy
        value: PER_CLUSTER
      - name: command.cache.minExecutionTime
        value: 10
      - name: command.cache.maxResultsetSize
        value: 500
      - name: query.parallelAuto
        value: false
      - name: query.parallelMinimumRecords
        value: 300000
      - name: query.parallelResultQueueSize
        value: 20000
      - name: query.scanPrefetchPages
        value: 20
      - name: query.scanBatchSize
        value: 1000
      - name: query.scanThresholdTip
        value: 50000
      - name: query.limitThresholdTip
        value: 10000
      - name: query.live.support
        value: true
      - name: statement.cacheSize
        value: 100
      - name: sql.graphConsistencyMode
        value: tx
      - name: client.channel.maxPool
        value: 100
      - name: client.connectionPool.waitTimeout
        value: 5000
      - name: client.channel.dbReleaseWaitTimeout
        value: 10000
      - name: client.ssl.enabled
        value: false
      - name: client.ssl.keyStore
        value: null
      - name: client.ssl.keyStorePass
        value: null
      - name: client.ssl.trustStore
        value: null
      - name: client.ssl.trustStorePass
        value: null
      - name: client.krb5.config
        value: null
      - name: client.krb5.ccname
        value: null
      - name: client.krb5.ktname
        value: null
      - name: client.credentialinterceptor
        value: null
      - name: client.session.tokenBased
        value: true
      - name: client.channel.minPool
        value: 1
      - name: server.openAllDatabasesAtStartup
        value: false
      - name: server.channel.cleanDelay
        value: 5000
      - name: server.cache.staticFile
        value: false
      - name: server.log.dumpClientExceptionLevel
        value: FINE
      - name: server.log.dumpClientExceptionFullStackTrace
        value: false
      - name: server.security.file
        value: false
      - name: distributed.crudTaskTimeout
        value: 3000
      - name: distributed.commandTaskTimeout
        value: 120000
      - name: distributed.commandQuickTaskTimeout
        value: 5000
      - name: distributed.commandLongTaskTimeout
        value: 86400000
      - name: distributed.deployDbTaskTimeout
        value: 1200000
      - name: distributed.deployChunkTaskTimeout
        value: 15000
      - name: distributed.deployDbTaskCompression
        value: 7
      - name: distributed.asynchQueueSize
        value: 0
      - name: distributed.asynchResponsesTimeout
        value: 15000
      - name: distributed.purgeResponsesTimerDelay
        value: 15000
      - name: distributed.conflictResolverRepairerChain
        value: majority,content,version
      - name: distributed.conflictResolverRepairerCheckEvery
        value: 5000
      - name: distributed.conflictResolverRepairerBatch
        value: 100
      - name: distributed.txAliveTimeout
        value: 30000
      - name: distributed.requestChannels
        value: 1
      - name: distributed.responseChannels
        value: 1
      - name: distributed.heartbeatTimeout
        value: 10000
      - name: distributed.checkHealthCanOfflineServer
        value: false
      - name: distributed.checkHealthEvery
        value: 10000
      - name: distributed.autoRemoveOfflineServers
        value: -1
      - name: distributed.publishNodeStatusEvery
        value: 5000
      - name: distributed.localQueueSize
        value: 10000
      - name: distributed.dbWorkerThreads
        value: 8
      - name: distributed.queueMaxSize
        value: 10000
      - name: distributed.backupDirectory
        value: ../backup/databases
      - name: distributed.concurrentTxMaxAutoRetry
        value: 10
      - name: distributed.atomicLockTimeout
        value: 300
      - name: distributed.concurrentTxAutoRetryDelay
        value: 100
      - name: distributed.queueTimeout
        value: 500000
      - name: jna.disable.system.library
        value: true
      - name: oauth2.secretkey
        value:
      - name: lazyset.workOnStream
        value: true
      - name: mvrbtree.timeout
        value: 0
      - name: mvrbtree.nodePageSize
        value: 256
      - name: mvrbtree.loadFactor
        value: 0.7
      - name: mvrbtree.optimizeThreshold
        value: 100000
      - name: mvrbtree.entryPoints
        value: 64
      - name: mvrbtree.optimizeEntryPointsFactor
        value: 1.0
      - name: mvrbtree.entryKeysInMemory
        value: false
      - name: mvrbtree.entryValuesInMemory
        value: false
      - name: mvrbtree.ridBinaryThreshold
        value: -1
      - name: mvrbtree.ridNodePageSize
        value: 64
      - name: mvrbtree.ridNodeSaveMemory
        value: false

  roles:
  - role: migibert.orientdb
```

Running in distributed mode
-------

Set `orientdb_enable_distributed` to `true` to enable distributed mode. Under `orientdb_distributed` you can either enable multicast or use tcp for discovery. If using tcp then you need to specify at least one node in `tcp_members`.

The service discovery part is defined through these variables:
```
orientdb_enable_distributed: true

orientdb_distributed:
  hazelcast_group: orientdb
  hazelcast_password: orientdb
  multicast_enabled: False
  multicast_group: 235.1.1.1
  multicast_port: 2434
  tcp_enabled: False
  tcp_members: []
  - 192.168.22.5-10:2434
  - 192.168.18.22:2434
```

The distributed database configuration part is defined through these variables:
```
orientdb_distributed_db_config:
  autoDeploy: true
  executionMode: "undefined"
  readQuorum: 1
  writeQuorum: 2
  readYourWrites: true
  newNodeStrategy: "static"
  dataCenters:
    rome:
      writeQuorum: "majority"
      servers:
        - "europe-0"
        - "europe-1"
        - "europe-2"
    denver:
      writeQuorum: "majority"
      servers:
        - "usa-0"
        - "usa-1"
        - "usa-2"
  servers:
    "*": "master"
  clusters:
    index: {}
    internal: {}
    "*":
      servers:
        - "<NEW_NODE>"
```

Testing distributed mode
-------

Under test/vagrant, you will find the following files:
- Vagrantfile which creates two machines without any provisioning
- inventory with those two machines ips and convenient variables for simplifying tests
- provision-multicast.yml which installs orientdb in distributed mode with a multicast discovery setting
- provision-tcp.yml which installs orientdb in distributed mode with a known peers discovery setting

Notes:
- the two discovery modes multicast and tcp are not compatible so choose one at time ;)
- tests are manual at the moment but will be automated as soon as possible

You can play cluster tests with the following commands:
```
vagrant up && ansible-playbook -i inventory provision-multicast.yml
```
or
```
vagrant up && ansible-playbook -i inventory provision-tcp.yml
```

Kitchen tests
-------
- Requirements: VirtualBox, Ruby and Bundler (gem install bundle)
- Run ```bundle install``` this will install all test dependencies from Gemfile
- To test: ```bundle exec kitchen test```

License
-------

MIT

Author Information
------------------

Mikaël Gibert, Developer / Devops
