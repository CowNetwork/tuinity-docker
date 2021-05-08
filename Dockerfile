FROM adoptopenjdk/openjdk11:alpine-slim AS builder
WORKDIR /minecraft
RUN ./tuinity jar
RUN tuinity-paperclip.jar

FROM gcr.io/distroless/java:11
EXPOSE 25565
COPY --from=builder /minecraft/cache/patched*.jar /opt/spigot/spigot.jar
CMD -Dcom.mojang.eula.agree=true spigot.jar --nogui

