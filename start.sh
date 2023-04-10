docker run -d                                                          \
    --mount type=bind,src="$(pwd)/config/",dst=/docker-entrypoint.d/   \
    --mount type=bind,src="$(pwd)/log/unit.log",dst=/var/log/unit.log  \
    --mount type=bind,src="$(pwd)/webapp",dst=/www                     \
    -p 8090:8090 -p 80:80 --name nginx "nginx.fastapi:latest"                 

docker exec -it nginx curl -X PUT --data-binary @/docker-entrypoint.d/config.json \
    --unix-socket /var/run/control.unit.sock http://localhost/config
