# CD Pipeline deployment of devops-create-image-nest-api project

## Prerequisites

**AWS CLI**

- You need an AWS account
- You need to install AWS CLI
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

**AWS SSO**

```bash
aws sso configure --profile {$profileName}
aws sso login --profile {$profileName}
```

## Sensitive data

For the `thumbprint` run the command below

```bash
echo | openssl s_client -servername token.actions.githubusercontent.com -connect token.actions.githubusercontent.com:443 2>/dev/null | openssl x509 -fingerprint -noout | sed 's/SHA1 Fingerprint=//' | tr -d ':'
```

```bash
cp secret.tfvars.sample secret.tfvars
```

Edit `secret.tfvars` and add your Github repository

```hcl
aws_account_id  = "{AWS Account ID}"
thumbprint      = "{SHA1 Fingerprint}"
gh_iac_repo     = "repo:{username}/{repo}:ref:refs/heads/{branch}"
gh_app_repo     = "repo:{username}/{repo}:ref:refs/heads/{branch}"
```

Run the command to check if everything is ok

```bash
terraform plan -var-file=secret.tfvars
```

These steps are only for running Terraform locally.

We also need to store these variables in Github Secrets.
You can create them in the Github UI: 
`https://github.com/{user}/{repo}/settings/secrets/actions`
![alt text](assets/gh_secrets.png)

## Creating the role for the Terraform CLI on AWS

Now we need to apply the changes locally, and get the ARN of the role that we will use in the next step.

```bash
AWS_PROFILE={your_aws_profile} terraform apply -var-file="secret.tfvars"
```

Type `yes` to apply the changes.

Now we have deployed the App on App Runner, but, we still have work to do, to make the CD process automated.

## Deployment

```bash
terraform init
terraform plan
terraform apply
```