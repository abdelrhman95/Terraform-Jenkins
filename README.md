Here is a README file for the infrastructure as a code project with Terraform:

# Infrastructure as Code with Terraform

This project demonstrates using Terraform to manage infrastructure as code and deploy resources to AWS.

## Features

- Create dev and prod workspaces for staging environments 
- Store environment variables in .tfvars files
- Modularize network resources in a shared module
- Deploy infrastructure to US East (N. Virginia) and EU Central (Frankfurt) regions
- Provision Bastion EC2 instances and output public IPs
- Build Jenkins server and pipeline for CI/CD
- Configure AWS Simple Email Service(SES) for email sending
- Create a Lambda function to send emails on infrastructure changes (state file)


## Usage

1. Configure AWS credentials 
2. Initialize Terraform workspaces
   - By default, you are on the default workspace
    ``` yaml
   terraform list workspace
     ```
    - Create `Dev` and `Prod` workspaces
      ```yaml
      terraform workspace new prod
      terraform workspace new Dev
      ```
   - Now select the workspace that you to apply your infra at it
     ```yaml
     terraform workspace select prod
     terraform workspace select Dev
     ```
3. Create `.tfvars` files for dev and prod environments and (e.g. prod.tfvars and dev.tfvars)
4. Create Network module 
   - resources, such as VPCs, subnets, route tables, and internet gateways.
   - create two files `variables.tf` and `outputs.tf`
   -  create a network.tf file in the parent directory that references the module
       ``` yaml
          module "network" {
          source = "../network"
          cidr = var.cidr
          public_1_CIDR = var.public_1_CIDR
          public_2_CIDR = var.public_2_CIDR
          private_1_CIDR = var.private_1_CIDR
          private_2_CIDR= var.private_2_CIDR
          region = var.region
       }
    ```
5. Run `terraform apply` with `-var-file` to deploy resources
   ```yaml
     terraform apply -var-file=dev.tfvars #for the "dev" environment
     terraform apply -var-file=prod.tfvars #for the "prod" environment
    ```
  
6. Build Jenkins server with Terraform installed 
12. Create pipeline to apply infrastructure based on env param
13. Update state file to trigger Lambda and email alert

## Repository Structure

    ├── main.tf - Terraform configuration for AWS providers and remote state
    ├── variables.tf - Define the input variables for your network module
    ├── dev.tfvars - Environment variables for dev
    ├── prod.tfvars - Environment variables for prod
    ├── network - Network module to create VPCs, subnets, routes, etc
    ├── servers - EC2 instances
    ├── outputs.tf - Define any outputs you want to expose from the network module
    ├── README.md

This covers the core infrastructure as code project requirements. The Jenkins pipeline and other automation can be added to make the project more robust.
