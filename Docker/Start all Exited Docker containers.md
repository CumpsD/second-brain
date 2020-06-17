# Start all Exited Docker containers

```bash
sudo docker ps -a | grep Exited | cut -d ' ' -f 1 | xargs sudo docker start
```
