# Use official Nginx image as the base image
FROM nginx:latest


COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 (default HTTP port)
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
