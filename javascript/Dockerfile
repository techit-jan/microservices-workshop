FROM node:20-alpine AS builder

WORKDIR /app

COPY . .

RUN npm install


FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

COPY --from=builder /app/node_modules ./node_modules
COPY . .

EXPOSE 8083

CMD ["node", "main.js"]