# Workshop: Monitoring IRIS instances using SAM
Workshop where you will learn how to monitor InterSystems IRIS instances using SAM (System Alerting and Monitoring).

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
1. Run some InterSystems IRIS instances that will be executing simple HL7 productions.
These are the instances we will monitor. You can access them at:
http://localhost:9191/csp/sys/UtilHome.csp (`superuser`/`SYS`)
http://localhost:9291/csp/sys/UtilHome.csp (`superuser`/`SYS`)

```
cd iris
docker-compose up -d
```

2. Now, run SAM (System Alerting and Monitoring). You can access SAM at:
http://localhost:8080/api/sam/app/index.csp (`superuser`/`SYS`)

```
cd sam-1.0.0.115-unix
docker-compose up -d
```

# Examples  

## (a.1) Creating a new cluster
Clusters are set of instances you want to monitor using SAM. So, you first must define a new cluster.

* Access SAM in http://localhost:8080/api/sam/app/index.csp using `superuser`/`SYS`. System will ask you to change the password.

* Click on *Create Your First Cluster*
Cluster name: `workshop-cluster`

## (b.1) Adding an instance to monitor
After creating the cluster, you can add the instances you want to monitor.
As we will monitoring instances that are running as containers on the same host, we will use `host.docker.internal` as ip address.

* Click on *New* instances and add two instances:

IP: `host.docker.internal`
Port: `9192`
Name: `irisA`

IP: `host.docker.internal`
Port: `9292`
Name: `irisB`

* After defining instances, check you can see correctly the instance dashboard navigating `Clusters > workshop-cluster > instances`



Defining cluster alert rules

Check differences in config files

Alert Handling?

Metrics: /api/monitor
https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCM_rest

Application Metrics
https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=GCM_rest#GCM_rest_metrics_application


