# Movies API - Checkpoint DevOps Azure ACR/ACI

Projeto adaptado para o checkpoint de DevOps Tools & Cloud Computing.

O projeto original `Movies` e uma API Java/Spring Boot para CRUD de filmes. Para atender ao checkpoint, o banco H2 foi removido e a aplicacao foi configurada para usar MySQL em container na Azure.

## Requisitos atendidos

- App Java em container.
- Banco MySQL relacional em container.
- Dockerfile da aplicacao.
- Dockerfile do banco.
- Build local das imagens.
- Push das imagens para Azure Container Registry.
- Deploy em Azure Container Instances.
- Persistencia do banco via Azure Storage Account.
- Criacao dos recursos via Azure CLI.
- Container da aplicacao sem privilegio root/admin.
- Testes CRUD com evidencia via `SELECT` diretamente no banco.

## Estrutura

```text
Movies-main/
  Dockerfile.mysql
  database/
    ddl.sql
  json/
    get-movies.json
    post-movie.json
    put-movie.json
    delete-movie.json
  scripts/
    01_store-account.sh
    02_key-vault.sh
    03_aci-mysql.sh
    04_aci-movies-api.sh
  movies/
    Dockerfile
    pom.xml
    src/main/resources/application.properties
    src/main/java/br/com/fiap/movies
```

## Atencao

Troque `rm9999` pelo RM do representante do grupo em todos os comandos e scripts.

Execute os comandos em Git Bash, WSL ou Linux, seguindo o padrao usado em aula.

## Endpoints

| Metodo | Endpoint | Descricao |
| --- | --- | --- |
| GET | `/movies` | Lista todos os filmes |
| GET | `/movies/{id}` | Busca filme por id |
| POST | `/movies` | Cria filme |
| PUT | `/movies/{id}` | Atualiza filme |
| DELETE | `/movies/{id}` | Remove filme |

## Build local

Na raiz do projeto:

```bash
docker build -f Dockerfile.mysql -t rm9999-mysql-movies .
```

Na pasta `movies`:

```bash
cd movies
docker build -f Dockerfile -t rm9999-movies-api .
cd ..
```

Confira as imagens:

```bash
docker image ls
```

## Teste local com Docker

```bash
docker network create movies-net

docker run -d --name mysql-movies --network movies-net -p 3306:3306 rm9999-mysql-movies

docker run -d --name movies-api --network movies-net -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:mysql://mysql-movies:3306/db-movies \
  -e SPRING_DATASOURCE_USERNAME=user-movies \
  -e SPRING_DATASOURCE_PASSWORD=senha-movies \
  rm9999-movies-api
```

Teste:

```bash
curl -X GET http://localhost:8080/movies
```

## Login na Azure

```bash
az login
az account show
```

Se precisar escolher a assinatura:

```bash
az account list -o table
az account set --subscription "nome-ou-id-da-assinatura"
```

## Criar Resource Group e ACR

```bash
az group create --name rg-movies --location eastus

az provider register --namespace Microsoft.ContainerRegistry

az acr create \
  --resource-group rg-movies \
  --name moviesrm9999 \
  --sku Standard \
  --location eastus \
  --public-network-enabled true \
  --admin-enabled true
```

## Login no ACR

```bash
ADMIN_USERNAME=$(az acr credential show --name moviesrm9999 --resource-group rg-movies --query username --output tsv)
ADMIN_PASSWORD=$(az acr credential show --name moviesrm9999 --resource-group rg-movies --query passwords[0].value --output tsv)

az acr login --name moviesrm9999
```

Se necessario:

```bash
docker login moviesrm9999.azurecr.io -u $ADMIN_USERNAME -p $ADMIN_PASSWORD
```

## Tag e push para o ACR

```bash
docker tag rm9999-mysql-movies moviesrm9999.azurecr.io/rm9999-mysql-movies:v1
docker tag rm9999-movies-api moviesrm9999.azurecr.io/rm9999-movies-api:v1

docker push moviesrm9999.azurecr.io/rm9999-mysql-movies:v1
docker push moviesrm9999.azurecr.io/rm9999-movies-api:v1

az acr repository list --name moviesrm9999 --output table
```

## Deploy na Azure via scripts

Entre na pasta `scripts`:

```bash
cd scripts
```

Execute:

```bash
chmod +x 01_store-account.sh
./01_store-account.sh > 01_store-account.log

chmod +x 02_key-vault.sh
./02_key-vault.sh > 02_key-vault.log

chmod +x 03_aci-mysql.sh
./03_aci-mysql.sh > 03_aci-mysql.log

chmod +x 04_aci-movies-api.sh
./04_aci-movies-api.sh > 04_aci-movies-api.log
```

Volte para a raiz:

```bash
cd ..
```

## Conferir os containers

```bash
az container list --resource-group rg-movies --output table
```

Logs:

```bash
az container logs --resource-group rg-movies --name rm9999-mysql-movies
az container logs --resource-group rg-movies --name rm9999-movies-api
```

## Testes CRUD na Azure

Pegue o FQDN da API:

```bash
fqdnApi=$(az container show --resource-group rg-movies --name rm9999-movies-api --query ipAddress.fqdn --output tsv)
echo $fqdnApi
```

### GET

```bash
curl -X GET http://$fqdnApi:8080/movies
```

### POST

```bash
curl -X POST http://$fqdnApi:8080/movies \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Interestelar",
    "synopsis": "Um grupo de astronautas viaja por um buraco de minhoca.",
    "rating": 5,
    "releaseDate": "2014-11-06"
  }'
```

### SELECT apos POST

```bash
az container exec --resource-group rg-movies --name rm9999-mysql-movies --exec-command "mysql -uuser-movies -psenha-movies"
```

Dentro do MySQL:

```sql
USE `db-movies`;
SELECT * FROM movie;
```

### PUT

```bash
curl -X PUT http://$fqdnApi:8080/movies/1 \
  -H "Content-Type: application/json" \
  -d '{
    "id": 1,
    "title": "Interestelar - Alterado",
    "synopsis": "Filme alterado no teste de update.",
    "rating": 4,
    "releaseDate": "2014-11-06"
  }'
```

Prove no banco:

```sql
SELECT * FROM movie;
```

### DELETE

```bash
curl -X DELETE http://$fqdnApi:8080/movies/1
```

Prove no banco:

```sql
SELECT * FROM movie;
```

## Limpar ambiente local

```bash
docker rm -f movies-api mysql-movies
docker network rm movies-net
```

## Limpar recursos da Azure apos a correcao

Execute apenas depois que o professor corrigir:

```bash
az group delete --name rg-movies --yes --no-wait
```
