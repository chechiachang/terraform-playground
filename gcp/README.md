Terraform
===

# Migration Progress

Moving every projects from separated GKEs to onepiece.

- myproject

# Usage

Create new terraform workspace from [Terraform Cloud](https://app.terraform.io/app/chechia/workspaces). Setting -> Execution Mode -> Local

Make new project
```
make DIR=myproject-oolong project

cd myproject-oolong

# Create resource
NAME=prod-oolong make gke mysql redis gcs

# Edit & Review
# - Put terraform workspace name to terraform.tf
# - Use valid cidr for service (gke, redis, ...)

# Plan
make plan
```

Checklist
- [] No destroy when planning.

---

# Deploy GKE

Check network VPC & available CIDR with Devops.

### Acquire service account credentials

Roles
- Project Viewer
- Compute Network Viewer
- Kubernetes Engine Admin
- Service Account User

### Import Existing Resources(If any)

```
vim terraform.auto.tfvars
terraform import google_compute_network.myproject myproject
```

### Local plan

```
terraform state pull
terraform plan
```

---

# Create resource SOP

### Import from existing remote resources with terraformer

Import

```
export GOOGLE_APPLICATION_CREDENTIALS="../credentials/credential.json"

terraformer import google \
  --resources=gke,instances,instanceTemplates,instanceGroups,instanceGroupManagers,autoscalers \
  --regions=asia-east1 \
  --projects=myproject
```

Copy generated tf contents to new tf files

### Edit tf files to desired state

- (Optional) Check with provider examples: [GCP/terraform-google-examples](https://github.com/GoogleCloudPlatform/terraform-google-examples)

### Terraform import existing remote resources

New resources might depends on existing resources. ex. Create new sql database depends on networks. Import states before apply new resources.
```
terraform import google_compute_network.myproject myproject

terraform import google_compute_subnetwork.myproject myproject

terraform import module.its-tekton-k8s-tw-01.google_container_cluster.primary projects/myproject/locations/asia-east1/clusters/its-tekton-k8s-tw-01
terraform import module.its-tekton-k8s-tw-01.google_container_node_pool.primary projects/myproject/locations/asia-east1/clusters/its-tekton-k8s-tw-01/nodePools/default

# terraform plan -no-color > out.plan
# terraform plan | grep -B 2 -A 2 '~\|replace\|destroy'
```

---

# GCP load balancer

[GCP Doc](https://cloud.google.com/load-balancing/docs/load-balancing-overview?hl=zh_TW)

### GCP Load Balancing

- internal
  - regional
    - pass-through: tcp / udp   -> internal TCP/UDP
    - proxy: http / https       -> internal HTTP(S)
- external
  - regional
    - pass-through: tcp / udp   -> tcp/udp network
  - global / effective regional
    - proxy
      - tcp                     -> TCP Proxy
      - ssl                     -> SSL Proxy
      - http / https            -> External HTTP(S)

### Terraform Resource

- forwarding_rule
  - forwarding_rule: tcp & http
  - global_forwarding_rule: only http

- backend_service
  - backend_service
    - health_check
    - http_health_check
    - https_health_check
  - region_backend_service
    - region_health_check
    - region_http_health_check
    - region_https_health_check

- target_pool
- target_tcp_proxy

- target_http_proxy
- target_https_proxy
- region_target_http_proxy
- region_target_https_proxy


```
backend_service
region_backend_service
```

```
terraform import module.regional_lb_1.google_compute_health_check.primary name
terraform import module.regional_lb_1.google_compute_backend_service.primary asia-east1/name
terraform import module.regional_lb_1.google_compute_region_backend_service.primary project/asia-east1/name
```
