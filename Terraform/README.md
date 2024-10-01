## 🤖 Terraform: IaC for Cloud Deployments 🚀 ☁️ 🐋

Terraform is an Infrastructure as Code (IaC) tool that allows you to define and provision cloud infrastructure across various providers. This project includes configurations for multiple cloud platforms.

### Digital Ocean Droplet Deployment
---
This section guides you through deploying a Digital Ocean droplet with Terraform, streamlining your cloud resource management.
🔧 **Features:**
- Simple, ready-to-go servers
- Automated droplet provisioning
- Scalable infrastructure setup
- Best practices for secure deployment

📝 **Prerequisites:**
- Digital Ocean API key
- Terraform installed on your local machine (it is preferred to have a dedicated server for this)
- Clone this repository to your local machine
- Navigate to the Terraform/DigitalOcean directory and edit the `main.tf` (VPS config variables), `digitalocean.auto.tfvars` (Digital Ocean API variable)
- Run `terraform init` to initialize the Terraform working directory
- Run `terraform apply` to create the Digital Ocean droplet

Terraform will ask again to confirm with a `yes` input and then the droplet will be created. It can take a couple of secs and to check you can run `doctl compute droplet list` to see the droplet

*[Troubleshooting](#troubleshooting)*

### Azure Resource Deployment
---
This section covers deploying resources on Microsoft Azure using Terraform.

🔧 **Features:**
- Automated Azure resource provisioning

📝 **Prerequisites:**
- Azure subscription
- Azure CLI installed and configured

*Detailed instructions for Azure deployment are a work in progress*
## Notes
### Security Considerations
- Always use SSH keys for authentication instead of passwords
- Limit access to your vps by configuring firewall rules
- Regularly update and patch your vps's operating system

### Troubleshooting
If you encounter issues:
1. Ensure your Digital Ocean API key is correct and has the necessary permissions
2. Check that Terraform is properly installed and up to date
3. Verify your network connection
    For more detailed errors, run `terraform apply -debug` for verbose output.

### Further Reading

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Digital Ocean Documentation](https://docs.digitalocean.com/reference/terraform/)
