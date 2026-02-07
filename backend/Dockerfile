FROM node:18-slim

WORKDIR /usr/src/app

ENV NODE_ENV=production

# Install dependencies (only production deps)
COPY package*.json ./
RUN npm ci --only=production

# Copy app source
COPY . .

EXPOSE 3001

CMD ["node", "server.js"]
