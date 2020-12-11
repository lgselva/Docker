# Angular Docker build process
FROM node:12.19.1-alpine3.10 as build
WORKDIR /usr/src/app
COPY package.json .
RUN npm install 
ENV PATH=./node_modules/@angular/cli/bin:$PATH
COPY . .
RUN ng build --configuration production

# multistage
FROM nginx:1.17.9-alpine
COPY --from=build /usr/src/app/dist/my-app /usr/share/nginx/html