Terraform Playground
===

Infrastructure as code with terraform, with some wrapped shortcuts.

# Usage

- Choose public cloud provider. ex.  `cd gcp`
- Provide credentials for public cloud. Check docs in subdirectory.
  - [Amazon Web Service](aws/README.md)
  - [Microsoft Azure](azure/README.md)
  - [Google Cloud Platform](gcp/README.md)

- Create project directory with `DIR=my-new-project make project`
- Update terraform project setting `cd my-new-project; vim terraform.tf`
- `terraform init`
- Update desired resources to terraform files
- `terraform plan`
- `terraform apply`

# SOP

1. 安裝 terraform
1. 取得 public cloud credentials

1. 編輯 tf 檔案
1. 計畫 make plan
1. 應用 terraform apply

初次導入團隊可以參考 [Git flow SOP](SOP.md)
