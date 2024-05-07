# Use the official Nginx image from Docker Hub.
FROM nginx:latest

# Install Git (if not already included in the Nginx image)
RUN apt-get update && apt-get install git -y

RUN rm -fr /usr/share/nginx/html/*

# Clone the website repository into the Nginx HTML directory
RUN git clone https://github.com/ShayGuedj1/website-project1.git /usr/share/nginx/html

# Expose port 80 (default for Nginx).
EXPOSE 80
