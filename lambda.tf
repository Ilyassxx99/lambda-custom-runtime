##### Docker Image Lambda Function ##### 
resource "aws_lambda_function" "custom_bash_function" {
  function_name = var.custom_bash_function_name
  description   = "custom bash runtime function"
  timeout       = 30 // seconds
  image_uri     = "${local.lambda_image_uri}:${local.lambda_image_tag}"
  package_type  = "Image"
  role          = aws_iam_role.lambda_custom_bash_execution_role.arn
  memory_size   = 2048

  tags = var.tags

  depends_on = [ time_sleep.wait_10_seconds ]
}


locals {
  lambda_image_repo = "${var.current_account_number}.dkr.ecr.${var.region}.amazonaws.com"
  lambda_image_uri = "${local.lambda_image_repo}/${var.custom_bash_ecr_repository_name}"
  lambda_image_tag            = substr(local.custom_bash_docker_dir_sha1, 0, 10)
  custom_bash_docker_dir_sha1 = sha1(join("", sort([for f in fileset(path.module, "custom-bash-docker/**") : filesha1(format("%s/%s", path.module, f))])))

}


resource "null_resource" "create_image" {
  provisioner "local-exec" {
    command = <<-EOT
      cd ${path.module}/custom-bash-docker && docker build . \
        --tag ${var.docker_image_custom_bash_uri} \
        --platform linux/${var.lambda_image_arch}
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.current_account_number}.dkr.ecr.${var.region}.amazonaws.com
      docker tag ${var.docker_image_custom_bash_uri} ${local.lambda_image_uri}:${local.lambda_image_tag}
      docker tag ${var.docker_image_custom_bash_uri} ${local.lambda_image_uri}:latest
      docker push ${local.lambda_image_uri}:${local.lambda_image_tag}
      docker push ${local.lambda_image_uri}:latest
    EOT
  }

  triggers = {
    update = local.custom_bash_docker_dir_sha1
  }
}


resource "time_sleep" "wait_10_seconds" {
  depends_on = [null_resource.create_image]

  create_duration = "10s"
}



resource "aws_ecr_repository" "ecr" {
  name = var.custom_bash_ecr_repository_name
  tags = var.tags
  force_delete = true
}


# Define IAM role for Lambda execution
resource "aws_iam_role" "lambda_custom_bash_execution_role" {
  name = "${var.custom_bash_function_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = "*",
        },
      },
    ],
  })
  tags = var.tags
}

# Attach basic Lambda execution policy to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_select-lab-account_execution_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_custom_bash_execution_role.name
}