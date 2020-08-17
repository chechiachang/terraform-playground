Terraform
===

# Azure-cli

Install
```
brew update && brew install azure-cli
```

(Optional) [Get a azure free account](https://azure.microsoft.com/zh-tw/free/)

Initialize azure account
```
az login

az account list
SUBSCRIPTION_ID="12345678-1234-1234-1234-123456789012"
SUBSCRIPTION_ID=$(az account list | jq -rc '.[] | select( .name == "免費試用版") | .id')
az account set --subscription=${SUBSCRIPTION_ID}
```

[Register provider](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/error-register-resource-provider)
```
az provider list
az provider register --namespace Microsoft.Network
az provider register --namespace Microsoft.Compute
```

# Use terraform cloud

- Create new terraform workspace from [Terraform Cloud](https://app.terraform.io/)
  - Setting -> Execution Mode -> Local
- Or choose another [backend remote](https://www.terraform.io/docs/backends/types/remote.html)

Make new project
```
make DIR=my-project project
cd my-project
```

Edit & Plan
```
make plan
```

Preflight checklist
- No destroy when planning.
- Create user for SQL. (The user credentials shouldn't commit in this repository.)

apply
```
terraform apply
```
