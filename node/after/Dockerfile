# DHI 移行後 (Node.js 24)
# syntax=docker/dockerfile:1
FROM dhi.io/node:24-alpine3.21-dev AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --omit=dev || true
COPY . .
RUN npm run build

FROM dhi.io/node:24-alpine3.21
WORKDIR /app
COPY --from=builder --chown=node:node /usr/src/app/package*.json ./
COPY --from=builder --chown=node:node /usr/src/app/dist ./dist
USER node
EXPOSE 8080
CMD ["node", "dist/index.js"]
