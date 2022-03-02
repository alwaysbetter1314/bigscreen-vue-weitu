FROM node:lts-alpine as build-stage
WORKDIR /app
COPY . /app

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)


# build app for production with minification
# 生产打包，对应脚本"build": "node build/build.js"
RUN npm run build

# production stage
#代理nginx，nginx直接访问
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
