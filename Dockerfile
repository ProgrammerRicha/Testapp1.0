# Stage 1: Build stage
FROM node AS builder

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=root

RUN mkdir -p /testapp
WORKDIR /testapp

COPY . .

# Optional: Install dependencies if needed
RUN npm install --only=production

# Stage 2: Runtime stage
FROM node

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=root

RUN mkdir -p /testapp
WORKDIR /testapp

COPY --from=builder /testapp .

CMD ["node", "/testapp/server.js"]
