#!/usr/bin/env bash

curl -s "http://localhost:8084/connectors/SnowflakeSinkConnector/status"| jq -c -M '[.name,.connector.state,.tasks[].state]|join(":|:")'
