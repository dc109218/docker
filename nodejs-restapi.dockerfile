# FROM node:alpine
FROM node:14.17.5-alpine
RUN mkdir -p /app
RUN chmod -R 755 /app
WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 19785
CMD ["npm","start"]