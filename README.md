# Aurora

Aurora is an open source alternative to the OpenStack® Horizon dashboard, providing a modern customizable web user experience for IaaS and PaaS services.  
It’s currently being actively developed by [Cloudbase](http://www.cloudbase.it) and [Enter](http://www.entercloudsuite.com), looking for additional enterprise contributors and early adopter users.

## The Aurora Stack

Aurora UI is a brand new dashboard with a focus on customization and extensibility.  
Aurora API provides a layer of abstraction between the UI and an OpenStack infrastructure. The API Gateway is the entry point for the UI. It forwards client calls based on information provided by the Service Manager and following dynamically created routes.  
The core service is the main plugin that provides the plumbings to an OpenStack Infrastructure.  

aurora-ui => aurora-gateway => aurora-manager => aurora-core => OpenStack

### Build Status

| Microservices | Status |
| ------------- | ------ |
| Gateway | [![Gateway Build Status](http://185.48.34.80/api/badges/entercloudsuite/aurora-gateway/status.svg)](http://185.48.34.80/entercloudsuite/aurora-gateway) |
| Manager  | [![Manager Build Status](http://185.48.34.80/api/badges/entercloudsuite/aurora-manager/status.svg)](http://185.48.34.80/entercloudsuite/aurora-manager) |
| Core | [![Core Build Status](http://185.48.34.80/api/badges/entercloudsuite/aurora-core/status.svg)](http://185.48.34.80/entercloudsuite/aurora-core) |

## Try Aurora (the easy way)

### Running Aurora on Enter Cloud Suite

If you are looking an easy way to setup the Aurora stack, consider to try [Enter Cloud Suite](http://www.entercloudsuite.com) for an hosted cluster installation.
If you need an account visit the [Enter Cloud Suite](http://www.entercloudsuite.com) website for more details.

### Infrastructure Quickstart 

1. Clone the repo using git client.  
2. Add the **openrc.sh** file with your OpenStack environment variables in the **src** subfolder.  
3. Use `make start` to run the tool in a local Docker container, from where you can use the following commands:  
 - Set up the OpenStack client running `source openrc.sh`.
 - Verify that authentication is working properly by running an openstack command like: `openstack server list`.
 - Run `make create` to start the servers in your OpenStack project.  
 - Finally, use `make all` to start deploying a Docker Swarm cluster on the running servers.

### Deploy the Aurora Stack

Use `make login host=ansible-dockerswarm-manager` to log in to the manager node of the Docker Swarm cluster.  In order to start the Docker services copy to this server all the project stacks (the content of the **/src/stacks** subfolder) and run each stack with the Docker client.  
By now, Docker Stack doesn't support the dependency model of the compose file format, so you have to start the stacks in the following order to run Auror properly: 

```
$ sudo su -
...
$ docker stack deploy -c docker-stack.aurora.dep.yml aurora
$ docker stack deploy -c docker-stack.aurora.yml aurora
$ docker stack deploy -c docker-stack.aurora.manager.yml aurora
$ docker stack deploy -c docker-stack.aurora.core.yml aurora
```

Inspect Docker Swarm to check all the services are running.  
The command `docker service ls` should show a set of services that look something like this:   

```
ID            NAME            MODE        REPLICAS  IMAGE
3sm9wb2csuzg  aurora_rabbit   replicated  1/1       rabbitmq:3-alpine
da4h3v6z93u4  aurora_manager  replicated  1/1       ecsdevops/aurora-manager:latest
ejcavvgrad25  aurora_ui       replicated  1/1       ecsdevops/aurora-ui:latest
gsesxl33mfkq  aurora_api      replicated  1/1       ecsdevops/aurora-gateway:latest
i0t34uhhumm6  aurora_redis    replicated  1/1       redis:alpine
lvie1hkgqckq  aurora_core     replicated  1/1       ecsdevops/aurora-core:latest
```

### Getting Started with Aurora

It's time to load the Aurora Dashboard!  
Get the public IP address of one of your Docker Swarm nodes. Open it with your browser, setting the port to **9000**. You should see the login page of Aurora, where you can sign in with your Enter Cloud Suite credentials.    
If the browser can't load the login page, check the default Security Group of your Enter Cloud Suite project.
The following ports must be open:   
 - 3000 (API Gateway)  
 - 9000 (Dashboard)  

