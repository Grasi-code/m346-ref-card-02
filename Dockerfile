# Base image
FROM node:16 as build

# Copy package.json and install dependencies
COPY . .
RUN npm install
RUN npm run build

# Serve the build with a static server
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
