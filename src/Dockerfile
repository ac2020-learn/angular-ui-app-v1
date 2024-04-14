FROM node:12-slim
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g @angular/cli
RUN npm installCOPY . ./
RUN npm run build
EXPOSE 4200
CMD [ "node", "server.js" ]
