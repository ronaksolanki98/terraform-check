#!/usr/bin/env bash

set -euo pipefail

: "${TF_BACKEND_RESOURCE_GROUP:?TF_BACKEND_RESOURCE_GROUP is required}"
: "${TF_BACKEND_STORAGE_ACCOUNT:?TF_BACKEND_STORAGE_ACCOUNT is required}"
: "${TF_BACKEND_CONTAINER:?TF_BACKEND_CONTAINER is required}"
: "${AZURE_LOCATION:?AZURE_LOCATION is required}"

az group create \
  --name "${TF_BACKEND_RESOURCE_GROUP}" \
  --location "${AZURE_LOCATION}" \
  --output none

az storage account create \
  --name "${TF_BACKEND_STORAGE_ACCOUNT}" \
  --resource-group "${TF_BACKEND_RESOURCE_GROUP}" \
  --location "${AZURE_LOCATION}" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --https-only true \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --allow-shared-key-access false \
  --require-infrastructure-encryption true \
  --output none

az storage container create \
  --name "${TF_BACKEND_CONTAINER}" \
  --account-name "${TF_BACKEND_STORAGE_ACCOUNT}" \
  --auth-mode login \
  --output none

az storage account blob-service-properties update \
  --account-name "${TF_BACKEND_STORAGE_ACCOUNT}" \
  --enable-versioning true \
  --enable-change-feed true \
  --enable-delete-retention true \
  --delete-retention-days 14 \
  --enable-container-delete-retention true \
  --container-delete-retention-days 14 \
  --auth-mode login \
  --output none
