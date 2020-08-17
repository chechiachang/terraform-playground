Terraform SOP with Git workflow
===

整合 Git 工作流程的 terraform SOP

# CAUTION

!CAUTION! Incorrect terraform apply may destroy existing environments.

!注意! 不正確的操作 terraform 可能會刪除遠端環境，導致現有環境損壞

# SOP

1. 安裝 terraform
1. 取得 public cloud credentials

1. 編輯 tf 檔案
1. 計畫 make plan
1. 應用 terraform apply

### 第一次設定

安裝 terraform

```
wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_darwin_amd64.zip
unzip terraform_0.12.28_darwin_amd64.zip
sudo mv terraform /usr/local/bin

terraform version
Terraform v0.12.28
```

git clone 這個專案
```
git clone git@github.com:chechiachang/terraform-playground.git
```

取得 GCP 的 service-account (terraform-playground@service-account) key.json，放在正確路徑 gcp/credentials/key.json
```
cd terraform-playground
mkdir gcp/credentials
```

---

# 計畫變更

- 新增資源到雲端
- 更改雲端的設定
- 刪除雲端的資源 (請小心使用)

### 新增資源到雲端

使用 git 開新的 branch，例如在 my-project 新增一個 chechia-net-k8s-tw-01

branch 取名
```
git checkout -b create-new-chechia-net-k8s-tw-01
```

到 my-project 新增一個 chechia-net-k8s-tw-01，用快速指令 make
```
cd gcp/my-project
NAME=chechia-net make gke
```
目前支援的指令有 gke mysql postgresql redis service-account，自己選需要的

使用 git 檢查不一樣的地方（也就是新增的檔案）
```
git diff
```

更改其中參數，包括名稱，VPC，版本...等等，不確定的參數可以先留空白，會有預設值

初始化（有加新資源都要跑一次），有錯誤就是 terraform.tf 設定有問題，可以問 devops
```
terraform init
```

檢查 tf 檔案內容有無設定錯誤，有錯就是 tf 檔案寫錯，施主請找錯誤的檔案跟行數自行改正
```
terraform validate
```

本地試跑，檢視新產生出來的結果，看結果有沒有問題。有 403 錯誤就是 credentials/key.json 權限太低
```
terraform plan
```

因為這邊是新增東西，若有出現 `destroy` 提示，請`雙手離開鍵盤`，問一下其他人為什麼會本地資料跟 gcp 上不一樣

commit 上傳 gitlab，開 PR 給其他 DevOps / Ops 一起 review
```
git add .
git status # 檢查一下 commit 的內容
git commit -m "Create new chechia-net-k8s-tw" # git commit 加上註解說明做了什麼
git push
```

上 gitlab 開 merge request，指派一個 op 跟 一個 devops 幫你一起看有無問題，三個人都看過就 merge 到 master

拉最新的 master，更改的東西應該會出現在 master
```
git checkout master
git pull
```

要正式跑了，一樣先 plan 一次
```
cd gcp/my-project
make plan # make plan = terraform init + validate + plan
```

要正式跑了，這邊要 apply，一樣找一個 op 一起看著你做
```
terraform apply
```

若仔細看過沒有問題 (紅紅的或是很多不是自己的變更），就輸入 yes，雲端就會開始跑

有時候同時新增很多東西，跑到一半會出現 403 錯誤，一些資源做好了，一些資源還沒做，例如 mysql-instance 建好了，可是 mysql-database 跟 mysql-user 回覆 403 失敗，是因為有些資源有先後順序，要先 mysql-instance -> mysql-database，一起坐後面的會卡住。再 apply 一次把剩下的東西補完就好了，一樣 apply 之前要看清楚。
```
terraform apply
```

做完再花幾秒鐘，上去 GCP 檢查一下

### 更改雲端的設定

前面步驟跟新增類似，但我們這邊是改已經有的東西，所以不下 `NAME=chechia-net make gke`，注意改的東西有機率會影響到正在使用的人，所以自己注意一下

例如我想改 my-project 的 chechia-net-k8s-tw-01
```
git checkout -b update-chechia-net-k8s-tw-01
cd my-project
```

更改 `gcp/my-project/container_cluster.tf`，Google Kubernetes Engine 放在這裡
```
vim gcp/my-project/container_cluster.tf
```

或是更改 `gcp/my-project/container_node_pool.tf` ，Google Kubernetes Engine 的機器 node-pool 放在這裡
```
vim gcp/my-project/container_cluster.tf
```

改完一樣 git diff 檢查一下
```
git diff
git add .
git status
git commit -m "Update chechia-net-k8s-tw-01"
git push
```

發 merge request，找一個 op 跟 devops review，merge 到 master，然後拉最新的 master 下來跑 `terraform apply`，一樣看清楚再按 yes
```
git checkout master
git pull

cd my-project
terraform plan
terraform apply
```

他會開始跑改動，可以等他跑的同時，一邊上 GCP 看你改的狀況

至於什麼東西放在什麼 tf 檔案裡面，其實對 GCP 熟的話會知道命名都是跟 Google 一樣，不熟的話稍微找一下

- Kubernetes Engine
  - `container_cluster.tf`
  - `container_node_pool.tf`
- Compute Engine
  - `compute_engine.tf`
- MySQL
  - `sql_database_instance.tf`
  - `sql_database.tf`
  - `mysql_sql_database.tf`
- PostgreSQL
  - `sql_database_instance.tf`
  - `sql_database.tf`
  - `postgresql_sql_database.tf`
- Redis
  - `redis_instance.tf`

### 刪除雲端的資源 (請小心使用)

前面步驟跟更改一樣，但我們這邊是刪掉雲端有的東西。terraform 的邏輯是，本地 tf 檔案跟雲端比較，本地 tf 檔案多出來的東西就去遠端加上去，本地 tf 沒有的東西，就去遠端刪掉。

特別注意刪除的東西，有些東西是刪掉就救不回來的，特別多找幾個人一起看

例如我想刪掉 my-project 的 chechia-net-k8s-tw-01
```
git checkout -b delete-chechia-net-k8s-tw-01
cd my-project
```

更改 `gcp/my-project/container_cluster.tf`，找到 chechia-net-k8s-tw-01
```
vim gcp/my-project/container_cluster.tf

/chechia-net-k8s
```

找到這段 chechia-net-k8s-tw-01 ，整段砍掉，要看清楚段落，不要砍到其他東西
```
module "chechia-net-k8s-tw-01" {
  source = "../modules/container_cluster"

  ......

  gke_version            = "1.14.10-gke.36"
  initial_node_count     = 0
  master_ipv4_cidr_block = "192.168.1.0/28"
}
```

或是更改 `gcp/my-project/container_node_pool.tf` ，Google Kubernetes Engine 的機器 node-pool 放在這裡
```
vim gcp/my-project/container_node_pool.tf
```

改完一樣 git diff 檢查一下
```
git diff
git add .
git status
git commit -m "Delete chechia-net-k8s-tw-01"
git push
```

發 merge request，找一個 op 跟 devops review，merge 到 master，然後拉最新的 master 下來跑 `terraform apply`，因為是刪除所以很多紅紅的是正常，算清楚砍掉的東西，看清楚再按 yes
```
git checkout master
git pull

cd my-project
terraform plan
terraform apply
```
