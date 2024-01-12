# get base image
FROM node:12.2.0-alpine

WORKDIR /app

#copy code to imaage for running in container

COPY . /app

#compile the code
RUN npm install

# passing run commands as arguments
CMD ["node","app.js"]
