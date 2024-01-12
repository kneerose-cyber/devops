# docker file
# get base image from docker hub
FROM openjdk:11

WORKDIR /app

#copy code to image for running in container
COPY Hello.java /app

#compile the code
RUN javac Hello.java 

# passing run commands as arguments
CMD ["java","Hello"]
