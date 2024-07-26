# Use an official Node.js runtime as a parent image
FROM node:20.15.1

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY . .

# Install the dependencies
RUN npm install

# Copy the rest of the application files to the working directory


# Expose port 4200
EXPOSE 4200

# Serve the application
CMD ["npm", "run", "start"]

