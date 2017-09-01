#!/bin/bash -e
es_node_list="bematech-do-es-01 bematech-do-es-02 bematech-do-es-03 bematech-do-es-04 bematech-do-es-05 bematech-do-es-06 bematech-do-es-07 bematech-do-es-08 bematech-do-es-09 bematech-do-es-10 bematech-do-es-11 bematech-do-es-12 bematech-do-es-13 bematech-do-es-18 bematech-do-es-19 bematech-do-es-14 bematech-do-es-15 bematech-do-es-16 bematech-do-es-17"

shard_list_file="/Users/mac/shard_file.txt"

es_index="master-index-abae8b30ac9b11e692000401f8d88101-new3"

for es_node in $es_node_list; do
    count=$(grep $es_node $shard_list_file | wc -l)
    bematech_shard_count=$(grep $es_node $shard_list_file | grep $es_index | wc -l)
    primary_count=$(grep $es_node $shard_list_file | grep $es_index | grep " | p | " | wc -l)
    replica_count=$(grep $es_node $shard_list_file | grep $es_index | grep " | r | " | wc -l)

    primary_count=$(echo "${primary_count}" | sed -e 's/^[ \t]*//')
    replica_count=$(echo "${replica_count}" | sed -e 's/^[ \t]*//')
    echo "In $es_node, shard count: $count, bematech_shard_count shard count: $bematech_shard_count, $primary_count(p), $replica_count(r)"
done
