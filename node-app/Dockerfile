FROM node:22.14-alpine
WORKDIR /app
COPY package*.json .
RUN npm install --omit=dev
COPY . .
EXPOSE 5000
CMD [ "npm", "start" ]