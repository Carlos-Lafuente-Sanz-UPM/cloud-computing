az account show --output table
az provider list --query "[?registrationState=='Registered'].namespace" --output table