FROM adoptopenjdk/openjdk11:debian-slim AS builder
WORKDIR /minecraft
COPY . /minecraft/
RUN apt update
RUN apt install -y git
RUN apt install -y maven
RUN git config --global user.email "machine@cow.network"
RUN git config --global user.name "udder-machine"
RUN git submodule update --init --recursive --depth 100
RUN ./Tuinity/tuinity jar
RUN java -jar Tuinity/tuinity-paperclip.jar

FROM gcr.io/distroless/java:11
WORKDIR /opt/spigot
EXPOSE 25565
COPY --from=builder /minecraft/cache/patched*.jar /opt/spigot/spigot.jar
ENV JAVA_TOOL_OPTIONS=-Dcom.mojang.eula.agree=true 
CMD ["spigot.jar", "--nogui"]

