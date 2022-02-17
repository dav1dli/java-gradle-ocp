# ocp-java-build

Example Java spring boot application.
The repository includes examples of how to build the app and its container using Red Hat UBI images and deploy it on Openshift using native manifests and helm chart.

Sources: https://github.com/spring-guides/gs-spring-boot.git

Pre-requsites: 
* JDK 11
* Internet
Note: in order to be able to build off-line gradle build has to be reconfigured to use internal Nexus repositories.

## Building
### Workspace
Build jar: ./gradlew bootJar

Build image: podman build -t sb-test .
Run image:  docker run --rm -p 8080:8080 sb-test
Test image: curl http://localhost:8080 Expected result: "Greetings from Spring Boot!"

## Openshift deployment
Openshift implements Kubernetes APIs with some extensions. In both examples the configuration does not define a namespace. The application will be deployed to the current namespace.

### Openshift manifests
Similarly to k8s the application can be deployed using YAML manifests.
Application manifests are in openshift/ direcotory.

Deploy:
```
oc create -f pull-secret.yaml
oc create -f deployment.yaml
oc create -f service.yaml
oc create -f route.yaml
```
Get route: `oc get route <route-name>`
Use the route URL to connect to the app using the browser. Expected result: "Greetings from Spring Boot!"

### Helm chart
Helm chart is a package encapsulating k8s manifests and providing a mechanism to configure variable values at deploy time.

Install: `helm install MY_RELEASE helm/ocp-java-ubi8`