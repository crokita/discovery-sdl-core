Hey. Use these commands to run me. You won't regret it.
Pass in the IP of the host to the containers that are being created as an environment variable

master branch:

```docker run -d -p 12435:12345 -p 8087:8087 -e "HOST_IP=127.0.0.1" crokita/sdl-core:master```

develop branch:

```docker run -d -p 12435:12345 -p 8087:8087 crokita/sdl-core:develop```