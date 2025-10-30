
# 🚀 Snowflake CI/CD with Terraform, GitHub Actions & Google Cloud Storage

This repository demonstrates a **CI/CD pipeline** for **Snowflake** using **Terraform** and **GitHub Actions**, with **Google Cloud Storage (GCS)** as the Terraform **remote state backend**.

- Fully Google Cloud–based backend.
- Production & Staging workflows powered by GitHub Actions.
- Secure auth via Private Key under GitHub Actions.

---

## ⚡️ Quick Start (Local Run)

## 1. Clone the repository
```
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

## 2. Install Terraform. Installation instructions available at:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## 3. Create a project and bucket in Google Cloud Service and configure authentication. Authentication instructions available at:
https://docs.cloud.google.com/sdk/gcloud/reference/auth/application-default/login

## 4. If needed, review additional documentation on configuring GitHub Actions with Google Cloud Storage:
https://github.com/google-github-actions/upload-cloud-storage

## 5. Create a TF_DEMO_READER custom role in Snowflake:
```
create role TF_DEMO_READER;
grant role TF_DEMO_READER to user MY_ROLE;
```

## 6. Authenticate Snowflake via Private Key (key-pair) screts uploaded to Github Actions. Instructions available at:
https://docs.snowflake.com/en/user-guide/key-pair-auth#configuring-key-pair-authentication

**SNOWFLAKE_PRIVATE_KEY**: This is your private key you use to authenticate to Snowflake via key-pair authentication.

## 7. Run Terraform:
```
terraform -chdir=./prod fmt -recursive
terraform -chdir=./prod validate
terraform -chdir=./prod plan
terraform -chdir=./prod apply -auto-approve
```

---
## Create the GCS bucket (one‑time; pick your project & region):
```
PROJECT_ID="<enter your project ID>"
BUCKET="<enter your bucket ID>"
LOCATION="<enter your region>"
```
```
gcloud storage buckets create gs://$BUCKET --project $PROJECT_ID --location $LOCATION --uniform-bucket-level-access
```

#### Enable versioning for safe rollbacks of state (Strongly recommended):
```
gsutil versioning set on gs://$BUCKET
```

#### Create a service account and grant it bucket‑level access:
```
SA_NAME="<enter SA name>>"
SA_EMAIL="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
```
```
gcloud iam service-accounts create $SA_NAME --project $PROJECT_ID
```

#### Grant object admin on the state bucket (read/write, including .tflock objects):
```
gcloud storage buckets add-iam-policy-binding gs://$BUCKET \
  --member="serviceAccount:${SA_EMAIL}" \
  --role="roles/storage.objectAdmin"
```

#### Create and download a key, then load it into GitHub Secrets:
```
gcloud iam service-accounts keys create gcp-sa.json \
  --iam-account $SA_EMAIL \
  --project $PROJECT_ID
```