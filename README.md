# Quickly scale up RPC Node deployments via Terraform

## About

### Why (is this needed):

- With the communication between users and the network relying solely on deployed RPC node infrastructure having the ability to quickly horizontally scale your RPC nodes to handle the required throughput capacity.

### Who (would this benefit):

- DAPP Developers
- Network Metric Aggregators
- Users in terms of more reliable transaction processing
- SAAS Providers

### How (does this achieve a solution):

- It enables the engineers to have to worry less about being bottle-necked & more about accomplishing their goal

## Prerequisites

- AWS Knowledge
    - [Terraform](https://www.terraform.io/)

## File Tree

```
.
├── autoscaling.tf
├── data.tf
├── Dockerfile
├── ecr.tf
├── ecs_service.tf
├── ecs_task_definition..tf
├── ecs.tf
├── elb.tf
├── endpoints.tf
├── iam.tf
├── key_pair.tf
├── launch_templates.tf
├── main.tf
├── outputs.tf
├── params
│   └── us-east-1
│       └── dev
│           ├── backend.config
│           └── variables.tfvars
├── provider.tf
├── r53.tf
├── README.md
├── secrets_manager.tf
├── security_groups.tf
├── task-definitions
│   └── rpc_node.json
├── tls_private_key.tf
├── userdata
│   └── ecs_user_data.sh               // Includes the `ECS_CLUSTER` variable definition in `/etc/ecs/ecs.config`
├── variables.tf                       // Defines the shared variables used in the service
└── vpc.tf                             // Defines the network settings
```

## Setup

1. Fork the repo located [here](https://github.com/NearPrime/rpc-near).
2. Clone the repo by using the following command

```
git clone git@github.com:(your_github_username)/rpc-near.git
```

1. Modify the following files:
    1. `params/us-east-1/dev/variables.tfvars`
2. Run the following commands in your shell to deploy the Terraform service
    
    ```
    terraform init -var-file="./params/us-east-1/dev/variables.tfvars" -backend-config="./params/us-east-1/dev/backend.config && \
    terraform plan -var-file="./params/us-east-1/dev/variables.tfvars" && \
    terraform apply -var-file="./params/us-east-1/dev/variables.tfvars"
    ```
