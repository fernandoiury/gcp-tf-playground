just a simple TF playground on Google Cloud
- creates some basic resources and gke

## Quick start

1. Configure vars,tf
```bash
vim terraform.tfvars
```

1. Configure and source env-file
```bash
vim env-file
source env-file
```

1. Run terraform
```bash
terraform plan && terraform apply
```

1. Configure and Deploy nginx-ingress controller
```bash
cd helm && bash helm.sh
```
