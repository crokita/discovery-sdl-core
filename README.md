Hey. Use these commands to run me. You won't regret it.

Pass in the IP of the host to the containers that are being created as an environment variable


master branch:

```docker run -d -p 12345:12345 -p 8087:8087 --name core crokita/discovery-core:master```

develop branch:

```docker run -d -p 12345:12345 -p 8087:8087 --name core crokita/discovery-core:develop```

For extra fun, also expose the ports 5050, 5080 and 8090