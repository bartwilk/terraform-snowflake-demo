# Demo Snowflake CI/CD pipeline with GitHub Actions and Google Cloud Storage backend.

Step 1

Install Terraform. Installation instructions available at:

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


Step 2

Create a project and bucker in Google Cloud Service

#bash

PROJECT_ID=your-project
BUCKET=your-tf-state-bucket
LOCATION=us-central1

gcloud config set project "$PROJECT_ID"
gsutil mb -l "$LOCATION" "
gsutil "gs://tf-state-bucket10001"

Step 3 

Initialize GCS by running gcloud init

