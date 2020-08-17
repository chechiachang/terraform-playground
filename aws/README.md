Terraform
===

# Usage

Make new project
```
make DIR=myproject project

cd myproject

# Create resource
NAME=staging-myproject make gke mysql redis gcs
```

### Edit & Review

- Put terraform workspace name to terraform.tf
- Use valid cidr for service (gke, redis, ...)

### Plan

```
make plan
```

# Terraformer

```
make terraformer format
```

---

# Resources Import

### IAM

```
terraformer import aws --resources=iam --regions=ap-northeast-1

USER=terraform
GROUP=infra-admin

terraform import aws_iam_user.${USER} ${USER}
terraform import aws_iam_group.${GROUP} ${GROUP}

aws iam list-attached-group-policies --group-name ${GROUP}

POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"
terraform import aws_iam_group_policy_attachment.infra-admin_AdministratorAccess ${GROUP}/${POLICY_ARN}

aws iam list-groups-for-user --user-name ${USER}
terraform import aws_iam_user_group_membership.terraform-infra-admin ${USER}/${GROUP}
```

### VPC

```
terraform import aws_vpc.default vpc-c8fde9af

aws ec2 describe-dhcp-options
terraform import aws_vpc_dhcp_options.default dopt-75a59712
terraform import aws_vpc_dhcp_options_association.default_default vpc-c8fde9af-dopt-75a59712

terraform import aws_subnet.default-c subnet-226b6879
terraform import aws_subnet.default-a subnet-7bdd0c33
terraform import aws_subnet.default-d subnet-c0d50deb
```
