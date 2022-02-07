#!/bin/bash

quit=0
if [ ! -w ./config/prometheus ]
then
    echo "The current user must have write permissions on directory ./config/prometheus"
    quit=1
fi
if [ ! -w ./config/prometheus/isc_alert_rules.yml ]
then
    echo "The current user must have write permissions on file ./config/prometheus/isc_alert_rules.yml"
    quit=1
fi
if [ ! -w ./config/prometheus/isc_prometheus.yml ]
then
    echo "The current user must have write permissions on file ./config/prometheus/isc_prometheus.yml"
    quit=1
fi
if [ "$quit" -eq 1 ]
then
    exit 1
fi

docker-compose -p sam up -d
