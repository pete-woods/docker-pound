# Simple load balancer for Docker dev work

## Running from docker run
```
docker run -p 8000:8000 -eLOGIN_ADDRESS='10.0.0.1 10.0.0.2' -eFRONTEND_ADDRESS='10.0.0.3 10.0.0.4' -eBACKEND_ADDRESS='10.0.0.5 10.0.0.6' -t petewoods/development-load-balancer
```

## Part of docker-compose
```
version: '3.3'

services:
  keycloak1:
    ...
  keycloak2:
    ...

  backend1:
    ...
  backend2:
    ...

  frontend1:
    ...
  frontend2:
    ...

  load-balancer:
    image: petewoods/development-load-balancer
    ports:
      - "8000:8000"
    environment:
      LOGIN_FILTER: 'login.*'
      LOGIN_ADDRESS: 'keycloak1 keycloak2'
      LOGIN_PORT: '8080'

      BACKEND_FILTER: '^/(api)'
      BACKEND_ADDRESS: 'backend1 backend2'
      BACKEND_PORT: '8080'

      FRONTEND_ADDRESS: 'frontend1 frontend2'
      FRONTEND_PORT: '5000'
```