FROM ubuntu
RUN apt update && apt install openjdk-8-jdk wget unzip -y
RUN wget https://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
RUN unzip apache-maven-3.6.3-bin.zip
RUN rm -rf apache-maven-3.6.3-bin.zip
RUN mv apache-maven-3.6.3 /opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH="$MAVEN_HOME/bin:$PATH"
