az storage blob upload \
  --account-name $StorageAccountName \
  --container-name $filesystem \
  --name user/products.csv \
  --file products.csv \
  --auth-mode login

az storage blob upload \
  --account-name $StorageAccountName \
  --container-name $filesystem \
  --name user/NYCTripSmall.parquet \
  --file NYCTripSmall.parquet \
  --auth-mode login