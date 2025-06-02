IOT_HUB_NAME="iothub-ogvd-labs"
IOT_DEVICE_NAME="sensor-demo-01"

az iot hub create \
  --name $IOT_HUB_NAME \
  --resource-group $SynapseResourceGroup \
  --location northeurope \
  --sku F1 \
  --partition-count 2

az extension add --name azure-iot

az iot hub device-identity create \
  --hub-name $IOT_HUB_NAME \
  --device-id $IOT_DEVICE_NAME

CONNECTION_STRING=$(az iot hub device-identity connection-string show \
  --hub-name $IOT_HUB_NAME \
  --device-id $IOT_DEVICE_NAME \
  --query connectionString -o tsv)

echo "Connection String: $CONNECTION_STRING"