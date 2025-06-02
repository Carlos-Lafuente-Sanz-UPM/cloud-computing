az iot hub show --name $IOT_HUB_NAME --resource-group $SynapseResourceGroup --query "name" -o tsv
az cosmosdb show --name $COSMOS_ACCOUNT --resource-group $SynapseResourceGroup --query "name" -o tsv
az stream-analytics job show --name $SA_JOB_NAME --resource-group $SynapseResourceGroup --query "name" -o tsv

az resource list --resource-group $SynapseResourceGroup --output table