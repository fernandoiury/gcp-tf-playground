just a simple TF playground on Google Cloud
- creates some basic resources and gke

## Quick start

- Configure vars,tf
```bash
vim terraform.tfvars
```

- Configure and source env-file
```bash
vim env-file
source env-file
```

- Run terraform
```bash
terraform plan && terraform apply
```

- Configure and Deploy nginx-ingress controller
```bash
cd helm && bash helm.sh
```
