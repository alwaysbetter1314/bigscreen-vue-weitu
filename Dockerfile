FROM node:lts-alpine as build-stage

# npm镜像，解决报错而引入
# RUN npm config set registry https://registry.npm.taobao.org
# RUN npm config set sass_binary_site=https://npm.taobao.org/mirrors/node-sass

# install simple http server for serving static content
# 全局http-server用于本地运行
#RUN npm install -g http-server

# make the 'app' folder the current working directory
WORKDIR /app

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# build app for production with minification
# 生产打包，对应脚本"build": "node build/build.js"
RUN npm run build

# production stage
#代理nginx，nginx直接访问
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
