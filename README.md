# Simple load balancer for Docker dev work

```
docker run -p 8000:8000 -eLOGIN_ADDRESS='10.0.0.1 10.0.0.2' -eFRONTEND_ADDRESS='10.0.0.3 10.0.0.4' -eBACKEND_ADDRESS='10.0.0.5 10.0.0.6' -t petewoods/development-load-balancer
```
