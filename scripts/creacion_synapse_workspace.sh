az group create --name $SynapseResourceGroup --location $location

az storage account create \
  --name $StorageAccountName \
  --resource-group $SynapseResourceGroup \
  --location $location \
  --sku Standard_LRS \
  --kind StorageV2 \
  --allow-blob-public-access false \
  --hns true

az ad signed-in-user show --query id -o tsv | az role assignment create --role "Storage Blob Data Contributor" --assignee @- --scope "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$SynapseResourceGroup/providers/Microsoft.Storage/storageAccounts/$StorageAccountName"

az storage container create \
  --name $filesystem \
  --account-name $StorageAccountName \
  --auth-mode login

az provider register --namespace Microsoft.Sql

az synapse workspace create \
  --name $SynapseWorkspaceName \
  --resource-group $SynapseResourceGroup \
  --storage-account $StorageAccountName \
  --file-system $filesystem \
  --sql-admin-login-user $SqlUser \
  --sql-admin-login-password $SqlPassword \
  --location northeurope

az synapse workspace firewall-rule create \
  --end-ip-address 255.255.255.255 \
  --start-ip-address 0.0.0.0 \
  --name "Allow All" \
  --resource-group $SynapseResourceGroup \
  --workspace-name $SynapseWorkspaceName

WorkspaceWeb=$(az synapse workspace show --name $SynapseWorkspaceName --resource-group $SynapseResourceGroup --query connectivityEndpoints.web -o tsv)
echo "Synapse Studio URL: $WorkspaceWeb"