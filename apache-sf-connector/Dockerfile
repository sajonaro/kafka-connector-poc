FROM confluentinc/cp-kafka-connect:5.1.1

# Create plugin directory
RUN mkdir -p /usr/share/java/plugins

COPY *.jar /usr/share/java/plugins/
#COPY bc-fips-1.0.1.jar /usr/share/java/plugins
#COPY bcpkix-fips-1.0.3.jar /usr/share/java/plugins
#COPY bcprov-jdk15on-1.69.jar /usr/share/java/plugins
#COPY avro-1.10.2.jar /usr/share/java/plugins

#CMD ["java","-classpath","/usr/share/java/plugins/bc-fips-1.0.1.jar:/usr/share/java/plugins/bcpkix-fips-1.0.3.jar:/usr/share/java/plugins/bcprov-jdk15on-1.69.jar:/usr/share/java/plugins/avro-1.10.2.jar:.","org.springframework.boot.loader.JarLauncher"]

