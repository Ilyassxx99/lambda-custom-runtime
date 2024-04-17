# AWS Lambda Custom Runtime with Terraform

This Terraform project sets up the necessary AWS infrastructure to deploy and test an AWS Lambda function using a custom runtime, specifically a Docker-based Bash environment. It includes provisioning of an Amazon ECR repository, uploading a Docker image, and configuring a Lambda function to use this custom Docker image as its runtime.

## Prerequisites

Before you start, ensure you have the following prerequisites installed and configured:

- **AWS CLI** - Configured with appropriate access credentials.
- **Terraform** - Version 0.12.x or later.
- **Docker** - For building and pushing the Docker image to ECR.

## Project Structure

- `variables.tf` - Contains all the necessary variables.
- `main.tf` - Terraform configuration for creating AWS resources.
- `outputs.tf` - Defines the outputs of the Terraform deployment.
- `Dockerfile` - Dockerfile for creating the custom bash runtime.


## Support

For issues and feature requests, please file an issue or pull request in the repository.