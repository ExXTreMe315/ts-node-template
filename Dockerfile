# Erste Stage: Build-Umgebung
FROM node:lts-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Zweite Stage: Produktionsumgebung
FROM node:slim AS production
WORKDIR /app
COPY --from=builder /app/dist ./

# Definiere den Befehl zum Starten deiner Anwendung
CMD [ "node", "index.js" ]