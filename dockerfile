FROM node:16.13.0 AS build

# Create and set the working directory on the container
# then copy over the package.json and package-lock.json
WORKDIR /frontend
COPY package*.json ./

# Install the node packages before copying the files
RUN npm install


COPY . .

# build your app
RUN npm run build

# production environment
FROM nginx:1.17.4-alpine
COPY --from=build /frontend/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
# change the left path with yours, below the file content
COPY --from=build /frontend/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
