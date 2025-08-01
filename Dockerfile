# # Stage 1: Build with Node
# FROM node:18-alpine AS builder

# WORKDIR /app

# # Copy dependencies and install
# COPY package*.json ./
# RUN npm install

# # Copy rest of the app and build
# COPY . .
# RUN npm run build

# # Stage 2: Serve with Nginx
# FROM nginx:alpine

# # Remove default Nginx static files
# RUN rm -rf /usr/share/nginx/html/*

# # Copy build output from builder stage
# COPY --from=builder /app/dist /usr/share/nginx/html

# # Optional: Custom routing config for React Router
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Expose port
# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]


# Stage 1: Build with Node
FROM node:18 AS builder

WORKDIR /app

# Copy dependencies and install
COPY package*.json ./
RUN npm install

# Copy app and build
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Clean default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Optional: Custom Nginx config for React Router
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
