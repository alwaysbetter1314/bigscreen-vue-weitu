FROM node:lts-alpine as build-stage
WORKDIR /app
COPY . /app

# install project dependencies
RUN npm install
RUN npm install serve -g

# build app for production with minification
RUN npm run build

EXPOSE 80
CMD ["serve", "-s", "/app/dist"]

# # production stage
# #代理nginx，nginx直接访问
# FROM nginx:stable-alpine as production-stage
# COPY --from=build-stage /app/dist /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
