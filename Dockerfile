# ===== BUILD STAGE =====
FROM node:18 AS builder
WORKDIR /app

# Copy package files trước để tận dụng Docker cache
COPY package*.json ./

# Cài dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# ===== PRODUCTION STAGE =====
FROM node:18-slim

WORKDIR /app

# Copy từ builder stage
COPY --from=builder /app /app

EXPOSE 3000

CMD ["npm", "start"]
