# Nginx-Unit-FastAPI

<br>

## Build
<br>

```shell
$ docker buildx build --platform linux/amd64 -t nginx.fastapi:latest .
```

## Run
<br>

### Script
```shell
$ ./start.sh
```

### Manual
```shell
#Run Server
$ docker run -d                                                          \
    --mount type=bind,src="$(pwd)/config/",dst=/docker-entrypoint.d/   \
    --mount type=bind,src="$(pwd)/log/unit.log",dst=/var/log/unit.log  \
    --mount type=bind,src="$(pwd)/webapp",dst=/www                     \
    -p 8090:8090 -p 80:80 --name nginx "nginx.fastapi:latest"  

#Configure Unit
$ docker exec -it nginx curl -X PUT --data-binary @/docker-entrypoint.d/config.json \
    --unix-socket /var/run/control.unit.sock http://localhost/config

==========================================
{
    "success": "Reconfiguration done."
}
```
To configure Unit, PUT this snippet to the /config section via the control socket(`config.json`)

To confirm this works, query the listener. Unit responds with the `asgi.py` file from `webapp/front` , `webapp/back` directories.

```shell
#Front
$ curl -i 127.0.0.1
HTTP/1.1 200 OK
content-length: 27
content-type: application/json
Server: Unit/1.29.1
Date: Mon, 10 Apr 2023 16:27:51 GMT

{"Front":"Hello I'm front"}

#back
$ curl -i 127.0.0.1:8090/back
HTTP/1.1 200 OK
content-length: 25
content-type: application/json
Server: Unit/1.29.1
Date: Mon, 10 Apr 2023 16:29:19 GMT

{"Back":"Hello I'm Back"}
```
<br>

## Application
<br>

### Process Management
```shell
$ sudo curl -X GET --unix-socket /var/run/control.unit.sock  \
      http://localhost/control/applications/fastapi/restart
```
you can GET the /control/applications/ section of the API to restart an app

<br>

## Reference
[Nginx Unit in Docker](https://unit.nginx.org/howto/docker/)<br>
[Quick Start](https://unit.nginx.org/controlapi/)<br>
[Application](https://unit.nginx.org/configuration/#applications)