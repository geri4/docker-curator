This docker image runs curator tasks against an elasticsearch cluster to manage its indices.

The list of tasks currently are:
* purge old logstash indices

## Configuration

`ELASTICSEARCH_HOST` - The hostname or IP address of an elasticsearch cluster. Defaults to "127.0.0.1"

`ELASTICSEARCH_PORT` - The port of an elasticsearch cluster. Defaults to "9200"

`INDICES_PREFIX` - Prefix of indicex to purge. Defaults to "logstash-"

`MAX_INDEX_AGE` - The maximum age (in days) a logstash index can be until it is deleted. Defaults to 45

