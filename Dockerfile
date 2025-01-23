FROM openjdk:21
EXPOSE 8080
ADD build/libs/springShopping-latest.jar springShopping-latest.jar
ENTRYPOINT ["java","-jar","/springShopping-latest.jar"]