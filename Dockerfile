# Use the official lightweight Node.js 18 image.
# https://hub.docker.com/_/node
FROM node:19-alpine as build

# Create and change to the app directory.
WORKDIR /app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY ./package*.json ./

RUN npm install -g @angular/cli

# Install dependencies.
# If you add a package-lock.json speed your build by switching to 'npm ci'.
# RUN npm ci --only=production
# RUN npm install --production
  RUN npm install

# RUN ls -l
 
# Copy local code to the container image.
COPY . ./

# RUN ls -l

RUN npm run build

# RUN ls -l

FROM nginx:1.23.0-alpine
EXPOSE 8080

#RUN ls -l /etc/nginx

#COPY --from=build /app/nginx.conf /tmp
#RUN ls -l tmp

COPY --from=build /app/nginx.conf /etc/nginx/nginx.conf
#RUN ls -l 
COPY --from=build /app/dist/angular-ui-app /usr/share/nginx/html
#RUN ls -l
#RUN cat nginx.conf
#RUN cat /etc/nginx/nginx.conf
#RUN ls -l /usr/share/nginx/html

# Run the web service on container startup.
# CMD ["node", "index.js"]
