# Stage 1: Clone the repository and build the project
FROM node:18-alpine as builder

# Set the working directory in the container
WORKDIR /app

# Install git
RUN apk add --no-cache git python3 make g++

# Clone the repository
RUN git clone https://github.com/different-ai/file-organizer-2000.git .

# Navigate to the web directory
WORKDIR /app/web

# Install the project dependencies
RUN npm install && npm install -g pnpm 

# Build the project for self-hosting
RUN npm run build:self-host

# Stage 2: Create the final image
FROM node:18-alpine

# Install dependecies
RUN npm install -g pnpm && apk add --no-cache bash

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory in the container
WORKDIR /app

# Copy the built files from the builder stage
COPY --from=builder /app /app

# Change ownership of the app directory
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["sh", "-c", "cd /app/web && npm run start"]