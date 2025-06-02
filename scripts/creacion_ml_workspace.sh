ML_WORKSPACE="ml-workspace-ogvd"

az extension add -n ml

az ml workspace create \
  --name $ML_WORKSPACE \
  --resource-group $SynapseResourceGroup \
  --location northeurope