# f5-as3-demo

There are four types of files in this repo:
1. Main Postman collection:
  AS3-demo-get.json
  AS3-demo-update.json
2. AS3 JSON payload files. These are the main AS3-style config files that can be modified as needed. They wil be pulled into the above collections and run from Newman.
  Get-Pool-Members
  Get-Pools
  Get-VS
  Update-VS.json
  Update-iRule.json 
3. Environment file. This contains the needed environment variables that should be changed fairly infrequently, as needed.
  AS3-demo.postman_env.json
4. The readme file
  README.md (this file)


This repo makes use of Newman (https://learning.postman.com/docs/running-collections/using-newman-cli), the free CLI version of Postman, available both as a Linux binary and a container on Docker Hub (https://hub.docker.com/r/postman/newman).

The jepsteindocker/as3_newman_get and jepsteindocker/as3_newman_update containers extend the Newman container by providing the default collection and environment (from this repo) to only require the user to provide two arguments: the password and the command to run.
The Dockerfiles and usage examples are below:

  as3_newman_get:
    FROM postman/newman:ubuntu
    ENTRYPOINT newman run https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo-get.json -k --environment https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo.postman_env.json --env-var "command=$request" --env-var "pass=$pass"

  as3_newman_update:
    FROM postman/newman:ubuntu
    ENTRYPOINT newman run https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo-update.json -k --environment https://raw.githubusercontent.com/javajason/f5-as3-demo/main/AS3-demo.postman_env.json --env-var "command=$request" --env-var "pass=$pass"

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
  OR
$ docker run -e pass=$pass -e request="Update-VS.json" as3_newman:latest

$ docker run -e pass=$pass -e request="Update-iRule.json" as3_newman_update:latest --verbose
