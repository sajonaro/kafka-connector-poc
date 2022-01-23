#!/usr/bin/env bash

curl -i -X PUT -H "Content-Type:application/json" \
  http://localhost:8084/connectors/SnowflakeSinkConnector/config \
  -d'{
        "connector.class":"com.snowflake.kafka.connector.SnowflakeSinkConnector",
        "tasks.max":"1",
        "topics":"movies",
        "snowflake.topic2table.map": "movies:movies",
        "buffer.count.records":"100",
        "buffer.flush.time":"60",
        "buffer.size.bytes":"65536",
        "snowflake.url.name":"https://xxxxx.east-us-2.azure.snowflakecomputing.com:443",
        "snowflake.user.name":"phase2_poc",
        "snowflake.private.key": ".....",
        "snowflake.database.name":"SANDBOX",
        "snowflake.schema.name":"PUBLIC",
        "key.converter":"org.apache.kafka.connect.storage.StringConverter",
        "value.converter":"com.snowflake.kafka.connector.records.SnowflakeAvroConverter",
        "value.converter.schema.registry.url":"http://schema-registry:38081"
  }'









