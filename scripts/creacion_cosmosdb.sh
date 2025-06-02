COSMOS_ACCOUNT="cosmos-ogvd-labs"
COSMOS_DATABASE="iot-data"
COSMOS_CONTAINER="sensor-readings"

az provider register --namespace Microsoft.DocumentDB

az cosmosdb create \
  --name $COSMOS_ACCOUNT \
  --resource-group $SynapseResourceGroup \
  --locations regionName=northeurope \
  --default-consistency-level Session \
  --enable-free-tier true

az cosmosdb sql database create \
  --account-name $COSMOS_ACCOUNT \
  --resource-group $SynapseResourceGroup \
  --name $COSMOS_DATABASE

az cosmosdb sql container create \
  --account-name $COSMOS_ACCOUNT \
  --resource-group $SynapseResourceGroup \
  --database-name $COSMOS_DATABASE \
  --name $COSMOS_CONTAINER \
  --partition-key-path "/deviceId" \
  --throughput 400