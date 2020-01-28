# refer as 'builder' phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# the nginx target folder is taken from 'https://hub.docker.com/_/nginx' (nginx default 'static-html-directory'
COPY --from=builder /app/build /usr/share/nginx/html

# The default ngnix command will start it automatically
# After the copy of the files from the builder phase, it will be deleted automatically
