rm=rm9999
resourceGroup="rg-movies"
location="eastus"
acrName="movies$rm"
keyVaultName="keyvault-movies-$rm"

MYSQL_ROOT_PASSWORD=senha-movies
MYSQL_DATABASE=db-movies
MYSQL_USER=user-movies
MYSQL_PASSWORD=senha-movies
SPRING_DATASOURCE_URL=jdbc:mysql://$rm-mysql-movies.eastus.azurecontainer.io:3306/db-movies
SPRING_DATASOURCE_USERNAME=user-movies
SPRING_DATASOURCE_PASSWORD=senha-movies

az provider register --namespace Microsoft.KeyVault

if ! az keyvault show --name "$keyVaultName" --resource-group "$resourceGroup" &>/dev/null; then
  az keyvault create --name "$keyVaultName" --resource-group "$resourceGroup" --location "$location"
fi

az role assignment create \
  --assignee $(az account show --query user.name -o tsv) \
  --role "Key Vault Administrator" \
  --scope /subscriptions/$(az account show --query id -o tsv)/resourceGroups/$resourceGroup/providers/Microsoft.KeyVault/vaults/$keyVaultName

sleep 15

az keyvault secret set --vault-name "$keyVaultName" --name mysql-root-password --value "$MYSQL_ROOT_PASSWORD"
az keyvault secret set --vault-name "$keyVaultName" --name mysql-database --value "$MYSQL_DATABASE"
az keyvault secret set --vault-name "$keyVaultName" --name mysql-user --value "$MYSQL_USER"
az keyvault secret set --vault-name "$keyVaultName" --name mysql-password --value "$MYSQL_PASSWORD"
az keyvault secret set --vault-name "$keyVaultName" --name spring-datasource-url --value "$SPRING_DATASOURCE_URL"
az keyvault secret set --vault-name "$keyVaultName" --name spring-datasource-username --value "$SPRING_DATASOURCE_USERNAME"
az keyvault secret set --vault-name "$keyVaultName" --name spring-datasource-password --value "$SPRING_DATASOURCE_PASSWORD"
az keyvault secret set --vault-name "$keyVaultName" --name acr-username --value "$(az acr credential show --name "$acrName" --resource-group "$resourceGroup" --query username -o tsv)"
az keyvault secret set --vault-name "$keyVaultName" --name acr-password --value "$(az acr credential show --name "$acrName" --resource-group "$resourceGroup" --query passwords[0].value -o tsv)"
