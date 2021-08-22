# Gatling gradle load test <img align="right" src="http://gatling.io/wp-content/uploads/2017/02/Gatling-logo.png" height="80px" />

This repository contains [Gatling](https://gatling.io/) Gradle test framework

## Gradle

---
**NOTE**

Use [Gatling Gradle Plugin](https://gatling.io/docs/gatling/reference/current/extensions/gradle_plugin/) for developing load test scripts.

---


Compiles Gatling simulation and copies resources ```gradle gatlingClasses```

Executes all Gatling simulations configured by extension ```gradle gatlingRun```

Run single simulation implemented in `com.jaitech.ltd.*` class

```shell
gradle gatlingRun-com.jaitech.ltd.PostcodeIoSimulation
```
Run all simulations

```shell
gradle gatlingRun
```
## Docker

---
**NOTE**

In Order to run tests locally using Docker
---
```shell
docker-compose up --build
```

Scale up to 5 instances

```shell
docker-compose up --build --scale gatling=2
```

Kill the instances

```shell
docker compose down
```
## Reports

HTML reports generated under ``build/reports/gatling/[simulation-name]/index.html``

## Contacts
Owner: [beemi.raja@gmail.com](beemi.raja@gmail.com)