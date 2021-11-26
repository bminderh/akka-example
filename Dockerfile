FROM hseeberger/scala-sbt:17.0.1_1.5.5_2.13.7 as builder

COPY ./ ./

RUN sbt compile clean package

FROM openjdk:17-jdk-alpine3.14 as stage

COPY --from=builder /root/target/scala-2.13/*.jar /akka-http-quickstart-scala.jar
COPY --from=builder /root/.ivy2/cache/org.scala-lang/scala-library/jars/scala-library-2.13.7.jar /scala-library-2.13.7.jar

CMD ["java", "-cp", "akka-http-quickstart-scala.jar:scala-library-2.13.7.jar", "QuickstartApp"]