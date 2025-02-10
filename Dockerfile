# Step 1: Set up the build environment for the client
FROM node:18 AS build

WORKDIR /app

# Copy package.json and package-lock.json for the client
COPY client/package*.json ./client/

# Install client dependencies
WORKDIR /app/client
RUN npm install --omit=dev

# Copy the client source files
COPY client/ ./

# Build the client app (Vite React)
RUN npm run build && echo "Build complete!" || echo "Build failed!"

# Debug: List the contents of the /app/client directory after the build
RUN echo "Listing contents of /app/client after build:" && ls -R /app/client

# Step 2: Set up the server environment
FROM node:18 AS production

WORKDIR /app

# Copy package.json and package-lock.json for the server
COPY server/package*.json ./server/

# Install server dependencies
WORKDIR /app/server
RUN npm install --omit=dev

# Copy the server source files, including the bin directory
COPY server/ ./

# Copy the built client files from the build stage
COPY --from=build /app/client/dist /app/server/public

#list public elements
RUN echo "Listing contents of /app/public:" && ls -R /app/server/public

# Expose the port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
