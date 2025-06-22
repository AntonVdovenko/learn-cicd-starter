#!/bin/bash

# Setup script for GitHub Actions to work with Google Artifact Registry
# Run this script to create the necessary service account and permissions

echo "Setting up GitHub Actions for Google Artifact Registry..."

# Create service account for GitHub Actions
gcloud iam service-accounts create github-actions-sa \
    --display-name="GitHub Actions Service Account" \
    --description="Service account for GitHub Actions to push to Artifact Registry"

# Grant Artifact Registry permissions
gcloud projects add-iam-policy-binding notely-463610 \
    --member="serviceAccount:github-actions-sa@notely-463610.iam.gserviceaccount.com" \
    --role="roles/artifactregistry.writer"

# Grant Cloud Build permissions (if needed for future use)
gcloud projects add-iam-policy-binding notely-463610 \
    --member="serviceAccount:github-actions-sa@notely-463610.iam.gserviceaccount.com" \
    --role="roles/cloudbuild.builds.builder"

# Create and download the service account key
gcloud iam service-accounts keys create github-actions-key.json \
    --iam-account=github-actions-sa@notely-463610.iam.gserviceaccount.com

echo "Service account created successfully!"
echo "Please add the contents of github-actions-key.json as a GitHub secret named GCP_SA_KEY"
echo "You can find this in your GitHub repository: Settings > Secrets and variables > Actions" 