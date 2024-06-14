resource "aws_s3_bucket" "s3-test" {
  bucket = "devops-create-image-nest-iac-new-bucket"

  tags = {
    IaC = "True"
  }
}