# Cocktails Shared Infrastructure

This directory contains the Terraform infrastructure code for managing shared Azure resources used by the Cocktails application.

## 🏗️ Infrastructure Components

### Core Resources
- **Resource Groups**: Dedicated resource groups for different environments
- **Key Vault**: Secure storage for secrets and certificates
- **Storage Account**: Blob storage for static content
- **Container Registry**: Shared Azure Container Registry for Docker images

### Networking
- **Virtual Network**: Network infrastructure for containerized applications
- **Subnets**: Dedicated subnets for different service tiers
- **Front Door CDN**: Content delivery network with custom domain support

### Security
- **Azure B2C**: User authentication and management
- **Key Vault Secrets**: Secure storage for application secrets
- **Network Security**: Subnet-level security rules

## 🛠️ Technology Stack

- **Infrastructure as Code**: Terraform
- **Cloud Provider**: Microsoft Azure
- **Container Registry**: Azure Container Registry (ACR)
- **CDN**: Azure Front Door
- **Storage**: Azure Blob Storage
- **Security**: Azure Key Vault, Azure B2C

## 📁 Project Structure

```
cocktails.sharedinfrastructure/
├── .github/                # GitHub Workflow definitions
├── terraform/             # Terraform configuration files
│   ├── environment_vars/   # Environment-specific variables
│   ├── datasources.tf     # Data source definitions
│   ├── keyvault.tf        # Key Vault configuration
│   ├── storageaccount.tf  # Storage account setup
│   └── variables.tf       # Variable definitions
└── README.md              # This file
```

## 🚀 Deployment

### Prerequisites
- Azure CLI
- Terraform CLI
- GitHub access
- Appropriate Azure permissions

### Environment Setup
1. Configure Azure credentials
2. Set up Terraform backend
3. Configure environment variables
4. Set up GitHub secrets for sensitive data

### Deployment Process
The infrastructure is deployed using GitHub Workflows:

1. **Plan Stage**: Validates and plans infrastructure changes
2. **Apply Stage**: Applies approved changes to the environment
3. **Tagging**: Creates Git tags for successful deployments

### Environment Variables
Environment-specific configurations are stored in `terraform/environment_vars/`:
- `prd.tfvars`: Production environment settings
- Additional environment files as needed

## 🔒 Security

- All secrets are stored in Azure Key Vault
- Network security rules are enforced at subnet level
- HTTPS is enforced for all public endpoints
- CORS policies are configured for allowed origins

## 📈 Monitoring

- Azure Monitor integration
- Resource health monitoring
- Cost tracking and optimization

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test the changes using Terraform plan
4. Submit a pull request
5. Wait for approval and automated deployment

## 📄 License

This project is proprietary software. All rights reserved. 