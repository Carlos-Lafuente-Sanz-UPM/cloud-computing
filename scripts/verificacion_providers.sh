az provider show --namespace Microsoft.Sql --query "registrationState" -o tsv
az provider show --namespace Microsoft.DocumentDB --query "registrationState" -o tsv
az provider show --namespace Microsoft.StreamAnalytics --query "registrationState" -o tsv
az provider show --namespace Microsoft.Synapse --query "registrationState"