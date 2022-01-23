#!/bin/bash

curl -s "http://localhost:8083/connectors/source-debezium/status"| jq -c -M '[.name,.connector.state,.tasks[].state]|join(":|:")'