# Built from the default nginx image, which is built on debian.
# The way to run the built image is: docker run -d -p 80:80 nginx:neosynth
FROM nginx:latest

# Nginx does not ship with the extra modules that most distros include by default
RUN apt-get update && apt-get install -y nginx-extras && rm -rf /var/lib/apt/lists/*

# Delete all the default configs so we can replace them with our own
RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/default

# Copy our nginx config file over with our site settings
COPY site/nginx.conf /etc/nginx/conf.d/default.conf

# Copy the actual site contents over
ADD site/html /usr/share/nginx/html

# Run the datefix command
COPY tools/datefix.sh /datefix.sh
RUN bash /datefix.sh && rm /datefix.sh
