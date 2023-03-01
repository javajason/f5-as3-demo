# f5-as3-demo
Based on Newman container on Docker Hub (see https://hub.docker.com/r/postman/newman).
Uses jepsteindocker/as3_newman_get and jepsteindocker/as3_newman_update containers.
Dockerfiles:
  as3_newman_get:
    FROM postman/newman:ubuntu
    ENTRYPOINT newman run https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo-get.json -k --environment https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo.postman_env.json --env-var "Command=$request" --env-var "pass=$pass"

  as3_newman_update:
    FROM postman/newman:ubuntu
    ENTRYPOINT newman run https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo-update.json -k --environment https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo.postman_env.json --env-var "Command=$request" --env-var "pass=$pass"

To run in Docker:

Get:
$ docker pull jepsteindocker/as3_newman_get
$ docker run --env-file secrets.txt -e request="Get-VS" as3_newman_get:latest
  OR
$ docker run -e pass=$pass -e request="Get-VS" -e "--verbose" as3_newman_get:latest

$ docker run -e pass=$pass -e request="Get-Pools" as3_newman_get:latest
$ docker run -e pass=$pass -e request="Get-Pool-Members" as3_newman_get:latest
	(update AS3Tenant in environment file or update URL to specify tenant in Get-Pool-Members file)

Update:
$ docker pull jepsteindocker/as3_newman_update
$ docker run --env-file secrets.txt -e request="Update-VS.json" as3_newman:latest
AND
$ docker run -e pass=$pass -e request="Update-VS.json" as3_newman:latest
