variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  sensitive   = true
}

variable "thumbprint" {
  description = "SHA1 Fingerprint"
  type        = string
  sensitive   = true
}

variable "github_iac_repo" {
  description = "Github repository, e.g. repo:{username}/{repo}:ref:refs/heads/{branch}"
  type        = string
  sensitive   = true
}

variable "github_app_repo" {
  description = "Github repository, e.g. repo:{username}/{repo}:ref:refs/heads/{branch}"
  type        = string
  sensitive   = true
}