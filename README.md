Hey. Use these commands to run me. You won't regret it.

Pass in the IP of the host to the containers that are being created as an environment variable


master branch:

```docker run -d -p 12345:12345 -p 8087:8087 -e "HOST_IP=127.0.0.1" --name core crokita/sdl-core:master```

develop branch:

```docker run -d -p 12345:12345 -p 8087:8087 -e "HOST_IP=127.0.0.1" --name core crokita/sdl-core:develop```

For extra fun, also expose the ports 5050, 5080 and 8090