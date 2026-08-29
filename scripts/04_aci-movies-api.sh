rm=rm9999
resourceGroup="rg-movies"
location="eastus"
acrName="movies$rm"
aciName="$rm-movies-api"
imageName="$rm-movies-api"
tag="v1"
keyVaultName="keyvault-movies-$rm"

az provider register --namespace Microsoft.ContainerInstance

az container create \
  --resource-group "$resourceGroup" \
  --name "$aciName" \
  --location "$location" \
  --image "$acrName.azurecr.io/$imageName:$tag" \
  --cpu 1 \
  --memory 1 \
  --os-type Linux \
  --dns-name-label "$rm-movies-api" \
  --ports 8080 \
  --registry-login-server "$acrName.azurecr.io" \
  --registry-username $(az keyvault secret show --vault-name "$keyVaultName" --name acr-username --query value -o tsv) \
  --registry-password $(az keyvault secret show --vault-name "$keyVaultName" --name acr-password --query value -o tsv) \
  --environment-variables \
    SPRING_DATASOURCE_URL=$(az keyvault secret show --name spring-datasource-url --vault-name "$keyVaultName" --query value -o tsv) \
    SPRING_DATASOURCE_USERNAME=$(az keyvault secret show --name spring-datasource-username --vault-name "$keyVaultName" --query value -o tsv) \
    SPRING_DATASOURCE_PASSWORD=$(az keyvault secret show --name spring-datasource-password --vault-name "$keyVaultName" --query value -o tsv) \
  --restart-policy Always
