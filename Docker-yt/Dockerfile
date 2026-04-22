# Use official Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install basic tools
RUN apt-get update && \
    apt-get install -y curl nano && \
    apt-get clean

# Default command
CMD ["bash"]