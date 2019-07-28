FROM node:10-alpine
# Create app directory
WORKDIR /usr/src/app

COPY . .

ADD ca.crt .
# ADD client.crt .
ADD server.crt .
ADD server.key .
RUN apk add --no-cache --virtual .build-deps make gcc g++ python \
 && npm install --production --silent \
 && apk del .build-deps
RUN npm install -g openssl
RUN npm install
EXPOSE 8000
CMD [ "node", "server.js" ]