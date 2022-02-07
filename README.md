# Workshop: Monitoring IRIS instances using SAM
Workshop where you will learn how to monitor InterSystems IRIS instances using SAM (System Alerting and Monitoring).

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
1. Run an InterSystems IRIS instance that will be running a simple HL7 production.
This is the instance we will monitor.

```
cd iris
docker-compose up -d
```

http://localhost:52773/csp/sys/UtilHome.csp

2. Now, run SAM (System Alerting and Monitoring).
```
cd sam-1.0.0.115-unix
./start.sh
```

http://localhost:8080/api/sam/app/index.csp



# Examples  

## (a). Setup the instance you want to monitor in SAM

Create cluster

Create instance
host.docker.internal:52773

Create alert

Check differences in config files

Alert Handling?

Metrics: /api/monitor
https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCM_rest

Application Metrics
https://docs.intersystems.com/irislatest/csp/docbook/Doc.View.cls?KEY=GCM_rest#GCM_rest_metrics_application


