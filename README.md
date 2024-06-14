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

## Create a Github Action Variable for the Terraform CLI Version
You can create them in the Github UI: 
`https://github.com/{user}/{repo}/settings/variables/actions`
![alt text](assets/tf_version.png)

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
aws_region      = "{AWS Region}"
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

Now we can commit the changes to the repository, and check the logs for the pipeline.
For this example, nothing will be changed, since we have already applied the changes locally.
But If you add a new resource, like a new S3 bucket, you will see the changes in the pipeline, and they will be created in the AWS account.
