## ReadME

This Repository contains Terraform code to help NEAR developers setup an RPC-node with the mainnet chain using Terraform and Github Actions.

## Prerequisites
- Terraform installed (For Local testing)
- Assumes developer has previous experience with NEAR
- AWS Account with OIDC Role for github authentication

## Instruction
- Fork the repo.
- Update the OIDC_ROLEE_ARN value in the github actions secrets
- Clone the forked repo.
- Replace the AWS variables and parameters with values associated  with your aws account.
- Commit and Push Code back to Github to trigger github actions to setup Terraform Infrastructure, Build, Tag, push rpc-node image to Amazon Elastic Container Registry and deploy image to Amazon Elastic Container Service.