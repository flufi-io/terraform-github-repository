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
