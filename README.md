# gradle-container

A container to run gradle builds

## Build Instructions

Run build from docker or podman directly from github like this

```
podman build -t gradle:9.0.0 https://github.com/thomasw64/gradle-container.git
```

e.g. Example output
```
# podman build -t gradle:9.0.0 https://github.com/thomasw64/gradle-container.git
STEP 1/17: FROM icr.io/appcafe/ibm-semeru-runtimes:open-17-jdk-ubi-minimal
STEP 2/17: ARG GRADLEVERSION=9.0.0 
...
COMMIT gradle:9.0.0
--> a463c6ca845a
Successfully tagged localhost/gradle:9.0.0
a463c6ca845aef33d1a587873a52b49e8000f264c47ae8b85b8e28056bdcef12
```
