RPC Node Deployment Pipeline from PrimeLab!
Quickly scale up RPC Node deployments via Terraform
Contributors:
PrimeLab Core Tools
PrimeLab Blockchain Team

GitHub: RPC-Deployer 4

PrimeLab is excited to release the first iteration of our automated RPC Node Utility for NEAR Protocol! This utility enables developers and NEAR project stakeholders to quickly deploy and manage their own RPC node on the NEAR Mainnet!

Why (is this needed)

Many projects in the NEAR Ecosystem require their own RPC nodes. The options currently available are not automated and require repetitive & laborious tasks to deploy and maintain.
Who (would this benefit)

DAPP Developers
Network Metric Aggregators
SAAS Providers
Any project in the NEAR Ecosystem. :slight_smile:
How (does this achieve a solution):

The RPC Deployment Utility allows engineers to worry less about bottlenecks and focus more on the applications they’re building.
Tech:

The RPC Node utility uses Terraform, Packer, and Ansible to orchestrate the configuration and deployment of the RPC Node.

## Prerequisites

- AWS Knowledge
    - [Terraform](https://www.terraform.io/)
        - [Terraform CLI](https://www.terraform.io/cli)

## File Tree

```
.
├── autoscaling.tf
├── data.tf
├── Dockerfile                          // RPC node Dockerfile definition, fetches tagged version of nearcore, builds utilizing make, and downloads config.s
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
│           ├── backend.config         // Includes connection configuration variables (**Modify this file**)
│           └── variables.tfvars       // Includes additional network variable definition (**Modify this file**)
├── provider.tf
├── r53.tf
├── README.md
├── secrets_manager.tf
├── security_groups.tf
├── task-definitions
│   └── rpc_node.json                  // Defines the properties of the RPC node container
├── tls_private_key.tf
├── userdata
│   └── ecs_user_data.sh               // Includes the `ECS_CLUSTER` variable definition in `/etc/ecs/ecs.config`
├── variables.tf                       // Defines the shared variables used in the service
└── vpc.tf                             // Defines the network settings
```

## Setup

1. Fork the repository located [here](https://github.com/NearPrime/rpc-near).
2. Clone the repository by using the following command
    
    ```
    git clone git@github.com:(your_github_username)/rpc-near.git
    ```
    
3. Modify the following files:
    1. `params/us-east-1/dev/variables.tfvars`
    2. `params/us-east-1/dev/backend.config`
4. Run the following commands in your shell to deploy the Terraform service
    
    ```
    terraform init -var-file="./params/us-east-1/dev/variables.tfvars" -backend-config="./params/us-east-1/dev/backend.config && \
    terraform plan -var-file="./params/us-east-1/dev/variables.tfvars" && \
    terraform apply -var-file="./params/us-east-1/dev/variables.tfvars"
    ```
