FROM nginx:alpine
COPY app/index.html /usr/share/nginx/html/index.html
LABEL maintainer="gb <ваш.email@example.com>"
LABEL description="Простой образ для демонстрации работы с Docker Hub"
EXPOSE 80