#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'

docker-compose up -d

echo -e "${BLUE} Confluent Platform is starting up...${NC}"

# ---- Set up Debezium source connector ---
export CONNECT_HOST=connect-debezium
echo -e "\n--\n\n$(date) Waiting for Kafka Connect to start on ${GREEN}$CONNECT_HOST${NC}… ⏳"
grep -q "Kafka Connect started" <(docker-compose logs -f $CONNECT_HOST)
echo -e "\n--\n$(date)  Creating Debezium connector"
. ./mysql-streaming/scripts/submit_debezium_config.sh
echo -e "\n--\n$(date)  Checking Debezium connector status"
. ./mysql-streaming/scripts/get_dbzm_status.sh

echo -e "\n--\n$(date)  ${BLUE} checking list of topics in Kafka cluster ${NC}"
echo -e "\n Note, there should be ${GREEN}MOVIES${NC} topic name in the list"
docker-compose exec kafka1 kafka-topics --bootstrap-server kafka1:9092 --list



# ---- Set up kafka to snowflake sink connector ---
export CONNECT_HOST=sf-connect
echo -e "\n--\n\n$(date) Waiting for Kafka Connect to start on ${GREEN}$CONNECT_HOST${NC}… ⏳"
grep -q "Kafka Connect started" <(docker-compose logs -f $CONNECT_HOST)
echo -e "\n  ${GREEN}Creating snowflake connector${NC}"
. ./apache-sf-connector/submit_snowflake_config.sh
echo -e "\n--\n$(date)  ${GREEN} Checking snowflake connector status ${NC}"
sleep 10
. ./apache-sf-connector/get_status_of_connector.sh


# ---- Setting up movies schema  ---
echo -e "\n--\n$(date) ${GREEN} posting avro schema for topic movies ${NC}"
curl -i -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  http://localhost:38081/subjects/movies-value/versions \
  -d @./mysql-streaming/data/schema/movies-schema.json 