Here is a README file for the infrastructure as a code project with Terraform:

# Infrastructure as Code with Terraform

This project demonstrates using Terraform to manage infrastructure as code and deploy resources to AWS.

## Overview

- Create dev and prod workspaces with Terraform
- Store environment variables in .tfvars files
- Modularize network resources in a shared module
- Deploying across multiple regions US East (N. Virginia) and EU Central (Frankfurt) regions
- Printing EC2 data with local-exec
- Building a Jenkins image with Terraform
- Creating a Jenkins pipeline to deploy environments
- Sending email notifications via AWS Simple Email Service(SES) on state changes
- Lambda function to trigger emails

## Prerequisites
  - AWS account
  - Terraform CLI
  - Git and GitHub account
  - Docker to build Jenkins image


## Steps

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
  
3. Define .tfvars files for each env
   - `dev.tfvars`, `prod.tfvars` with env-specific values
4. Create Network module in `module\network`
   
5. Use `terraform apply` with `-var-file` to deploy dev and prod
   ```yaml
     terraform apply -var-file=dev.tfvars #for the "dev" environment
     terraform apply -var-file=prod.tfvars #for the "prod" environment
    ```
6. Use `local-exec` provisioner to print bastion IPs
      ```yaml
         provisioner "local-exec" {
          command = "echo ${self.public_ip} is the public IP of the Bastion Instance > inventory.txt" 
           }
     ```

7. Commit code to new GitHub repo
9. Build Jenkins server with Terraform installed
     - `Dockerfile` file `docker build -t jenkins-terraform:latest . `
10. Build image and create Jenkins container
   - run jenknins container
      ```yaml
      docker run -d -p 8080:8080 -p 50000:50000 --name my-jenkins jenkins-terraform:latest
     ```
   - open the container's shell
      ```yaml
      docker exec -it my-jenkins bash
      ```
  - Set jenkins admin password
       ```yaml
        cat /var/jenkins_home/secrets/initialAdminPassword
       ```
11. In jenkins you need to configure AWS credinals
   - Go to manage jenkins
   - Select Credentials
   - Press the global Hyperlink
   - Choose "Add Credentials"
   - Choose "Secret text" as the kind
   - enter your AWS Access Key ID and then name it
   - repeat the same steps for the AWS Secret Access Key

    
12. Create Jenkinsfile pipeline
     - Add the code in the `pipeline.groovy` file.
     - Accept parameter for env file
     - Run Terraform init, plan, apply
     - 
13. Verify SES in AWS console

14. Create Lambda function to send SES emails
   - Navigate to IAM and create a new role
   - Add the AmazonS3FullAccess and AmazonSESFullAccess permission policies to the role
   - Navigate to S3 and create a bucket with default configurations.

   - Navigate to Lambda and create a new function
      - choose python
      - select the created role

15. Configure trigger on state file changes to invoke Lambda
      - Add a trigger for S3 and choose the created S3 bucket from the Bucket dropdown menu.
      - add code to lambda function from `lambda-email.py` file

16. Make changes and verify emails are sent
       
  

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
