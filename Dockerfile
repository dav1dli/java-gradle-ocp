FROM registry.access.redhat.com/ubi8/openjdk-11:1.10-1 as staging
ADD . $HOME
RUN mkdir -p ~/.gradle && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties && \
  sh ./gradlew bootJar && cp build/libs/spring-boot-0.0.1-SNAPSHOT.jar /tmp/app.jar

FROM registry.access.redhat.com/ubi8/openjdk-11-runtime:1.10-1
COPY --from=staging  /tmp/app.jar $HOME/app.jar
ENTRYPOINT ["java", "-jar"]
CMD ["app.jar"]
