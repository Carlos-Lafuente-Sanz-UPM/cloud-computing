SA_JOB_NAME="sa-iot-ogvd"

az provider register --namespace Microsoft.StreamAnalytics

az stream-analytics job create \
  --resource-group $SynapseResourceGroup \
  --name $SA_JOB_NAME \
  --location northeurope