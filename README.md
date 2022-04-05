# RPC Node Deployment Pipeline from PrimeLab!

### Quickly scale up RPC Node deployments via Terraform
 
 
**Contributors:**  
[PrimeLab Core Tools](https://primelab.io/)
[PrimeLab Blockchain Team](https://primelab.io/)

**GitHub:**  [RPC-Deployer](https://github.com/NearPrime/rpc-near)

PrimeLab is excited to release the first iteration of our automated RPC Node Utility for NEAR Protocol! This utility enables developers and NEAR project stakeholders to quickly deploy and manage their own RPC node on the NEAR Mainnet!

**Why (is this needed)**

-   Many projects in the NEAR Ecosystem require their own RPC nodes. The options currently available are not automated and require repetitive & laborious tasks to deploy and maintain.

**Who (would this benefit)**

-   DAPP Developers
-   Network Metric Aggregators
-   SAAS Providers 
-   Any project in the NEAR Ecosystem. :)

**How (does this achieve a solution):**

- The RPC Deployment Utility allows engineers to worry less about bottlenecks and focus more on the applications they're building. 

**Tech:**
- The RPC Node utility uses Terraform, Github Actions, AWS Cloud Provider to orchestrate the configuration and deployment of the RPC Node.     

## Prerequisites

- AWS Knowledge
    - [Terraform](https://www.terraform.io/)
        - [Terraform CLI](https://www.terraform.io/cli)

## File Tree

```
.
├── autoscaling.tf                      // Autoscaling definition for container instances
├── data.tf                             // Terraform definition for already existing resources
├── Dockerfile                          // RPC node Dockerfile definition, fetches tagged version of nearcore, builds utilizing make, and downloads config.s
├── ecr.tf                              // RPC node image repository definition
├── ecs_service.tf                      // RPC node container service definition
├── ecs_task_definition..tf             // Task definition for ECS 
├── ecs.tf                              // ECS module definition
├── elb.tf                              // Network load balancer definition for rpc endpoint
├── endpoints.tf                        // Endpoints points for rpc definition
├── iam.tf                              // AWS IAM roles definition for Services
├── key_pair.tf                         // EC2 Key Pair definition
├── launch_templates.tf                 // Launch Templates for the ec2 Instance
├── main.tf                             // Terraform Backend Config
├── outputs.tf                          // Terraform outputs for aws infrastructure created 
├── params
│   └── us-east-1
│       └── dev
│           ├── backend.config         // Includes connection configuration variables (**Modify this file**)
│           └── variables.tfvars       // Includes additional network variable definition (**Modify this file**)
├── provider.tf                        // Provider definition for aws infrastructure 
├── r53.tf                             // AWS route 53 definition
├── README.md
├── secrets_manager.tf                 // Defines the secret key and version
├── security_groups.tf                 // Defines the allowed and disallowed connections to the network
├── task-definitions
│   └── rpc_node.json                  // Defines the properties of the RPC node container
├── tls_private_key.tf                 // Defines the private key for tls termination
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

4. Run the following commands in your shell to view the Terraform plan service locally
    
    ```
    terraform init -var-file="./params/us-east-1/dev/variables.tfvars" -backend-config="./params/us-east-1/dev/backend.config && \
    terraform plan -var-file="./params/us-east-1/dev/variables.tfvars"    
    ```

5. Commit and push modification to forked repo to trigger ci/cd build with Github actions

6. Wait for a couple hours for Infrastructure to come up and image tagged, built, deployed to amazon ECS

<h3> DISCLAIMER </h3>

-   The means of authentication to AWS from Github is with the use of Open ID Connect.
-   Update the OIDC_ROLE_ARN value in the secrets setting of the forked github repo.