FROM node:lts-alpine

WORKDIR /usr/src/app

ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY package*.json /usr/src/app/
RUN npm install --silent

CMD [ "npm", "start" ]