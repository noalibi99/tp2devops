FROM nginx
COPY ./nginx.conf /usr/share/nginx/html/
EXPOSE 80