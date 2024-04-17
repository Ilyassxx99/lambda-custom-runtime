variable "tags" {
  description = "A map of tags to apply to all resources that support tagging. Commonly includes tags such as 'Environment', 'Project', and 'Owner'."
  type        = map(string)
}

variable "custom_bash_function_name" {
  description = "The name of the custom bash function. This name is used to identify the function within AWS Lambda or other contexts where it is deployed."
  type        = string
}

variable "docker_image_custom_bash_uri" {
  description = "The URI of the Docker image for the custom bash function, stored in a Docker registry such as Amazon ECR. This URI is used to pull the image for deployments."
  type        = string
}

variable "custom_bash_ecr_repository_name" {
  description = "The name of the Amazon ECR repository where the custom bash Docker image is stored. This name is used to reference the repository in AWS operations."
  type        = string
}

variable "region" {
  description = "The AWS region in which the resources will be deployed. This is used to configure the AWS provider and all regional AWS services."
  type        = string
}

variable "current_account_number" {
  description = "The AWS account number of the current account. This is used for setting up permissions, referencing the account in IAM policies, or other AWS resources that require the account number."
  type        = string
}

variable "lambda_image_arch" {
  description = "The architecture for the AWS Lambda function's Docker image, such as 'x86_64' or 'arm64'. This specifies the computing architecture on which the Lambda function will run."
  type        = string
}

variable "lambda_image_custom_bash_version" {
  description = "The version tag of the custom bash Docker image used in the Lambda function. This allows for version control and management of deployments."
  type        = string
}
