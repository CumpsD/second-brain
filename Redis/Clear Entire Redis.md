# Clear Entire Redis

```bash
NODES=`redis-cli -h cache.network.local cluster nodes | cut -f2 -d' '`
echo $NODES
for node in $NODES; do echo Flushing node $node...; redis-cli -h ${node%:*} -p ${node##*:} flushall; done
```
