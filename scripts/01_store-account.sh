rm=rm9999
resourceGroup="rg-movies"
location="eastus"
storageAccountName="volumemoviesdata$rm"
file_share_name="mysql-movies-volume"

az provider register --namespace Microsoft.Storage

if ! az group show --name "$resourceGroup" &>/dev/null; then
  az group create --name "$resourceGroup" --location "$location"
fi

if ! az storage account show --name "$storageAccountName" --resource-group "$resourceGroup" &>/dev/null; then
  az storage account create \
    --resource-group "$resourceGroup" \
    --name "$storageAccountName" \
    --location "$location" \
    --sku Standard_LRS
fi

connection_string=$(az storage account show-connection-string \
  --name "$storageAccountName" \
  --resource-group "$resourceGroup" \
  --query connectionString \
  --output tsv)

if ! az storage share exists --name "$file_share_name" --account-name "$storageAccountName" --connection-string "$connection_string" | grep true; then
  az storage share create \
    --name "$file_share_name" \
    --account-name "$storageAccountName" \
    --connection-string "$connection_string"
fi
