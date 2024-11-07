<!-- BEGIN_TF_DOCS -->
# How to use this module
```hcl
# main.tf
module "repository" {
  source              = "../../"
  description         = var.description
  environment_secrets = var.environment_secrets
  environment_variables = {
    "TERRAFORM" = "true"
  }
  dependabot_environment = var.dependabot_environment
  #checkov:skip=CKV_GIT_1:"Ensure GitHub repository is Private"
  visibility                       = var.visibility
  archive_on_destroy               = var.archive_on_destroy
  context                          = module.this.context
  status_checks_contexts           = var.status_checks_contexts
  required_pull_request_reviews    = var.required_pull_request_reviews
  required_deployment_environments = var.required_deployment_environments
  commit_author_email_pattern      = var.commit_author_email_pattern
  collaborators_users              = [{ username = "mnsanfilippo", permission = "admin" }]
}
```
```hcl
# terraform.tfvars
description = "This is a test repository"
environment = "sandbox"
label_order = ["namespace", "stage", "name", "environment"]
name        = "repository"
namespace   = "flufi"
stage       = "module"


required_deployment_environments = ["sandbox"]
archive_on_destroy               = "false"
visibility                       = "public"
status_checks_contexts           = ["terratest"]
commit_author_email_pattern      = "@flufi.io"

dependabot_environment = "sandbox"
required_pull_request_reviews = {
  dismissal_apps                    = ["codiumai-pr-agent-pro"]
  dismissal_users                   = ["mnsanfilippo"]
  dismiss_stale_reviews             = true
  require_code_owner_reviews        = true
  required_approving_review_count   = 1
  require_last_push_approval        = true
  required_review_thread_resolution = true
  bypass_pull_request_allowances = {
    users = ["mnsanfilippo"]
    apps  = ["codiumai-pr-agent-pro"]
  }
}
```
# SOPS Encryption/Decryption Script

This script helps encrypt or decrypt environment-specific secret files using [SOPS (Secrets OPerationS)](https://github.com/mozilla/sops).
It uses AWS Key Management Service (KMS) for key management, so you need AWS credentials with appropriate permissions for the KMS key used in SOPS.

## Requirements

### AWS Environment Variables

To use this script, you need AWS credentials with access to the KMS key configured in your SOPS configuration.
Set up the following environment variables:

- `AWS_ACCESS_KEY_ID` – AWS access key ID with permissions to use the KMS key.
- `AWS_SECRET_ACCESS_KEY` – AWS secret access key.
- `AWS_DEFAULT_REGION` – The AWS region where the KMS key is located.

## Usage
The script accepts one or two arguments:

```shell
./secrets.sh [-e|-d] [optional: sandbox|development|staging|production]
```

### Examples

1.	Encrypt all environments: `./secrets.sh -e`


2.	Decrypt only the staging environment: `./secrets.sh -d staging`



### Script Details

1.	Encryption (-e):
•	Checks if the encrypted file (secrets.{environment}.tfvars.enc.json) already exists. If it does, the script skips encryption.
•	If encryption is successful, the original secrets.{environment}.tfvars.json file is deleted, and the encrypted file is staged with git add.
2.	Decryption (-d):
•	Checks if the decrypted file (secrets.{environment}.tfvars.json) already exists. If it does, the script skips decryption.
•	If decryption is successful, the encrypted file is deleted to prevent storing both encrypted and decrypted files.
# MIT License

## Copyright (c) [2024] Flufi LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included insa
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
<!-- END_TF_DOCS -->
