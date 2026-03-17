# 🎬 Movies API

Uma API REST robusta e escalável para gerenciamento de catálogos de filmes, desenvolvida com o ecossistema **Spring Boot**. Este projeto demonstra a aplicação de boas práticas de desenvolvimento, incluindo persistência de dados, arquitetura em camadas e documentação de endpoints.

---

## 🚀 Tecnologias Utilizadas

O projeto foi construído utilizando as tecnologias mais modernas do ecossistema Java:

| Tecnologia | Descrição |
| :--- | :--- |
| **Java 17** | Linguagem base com recursos modernos e LTS. |
| **Spring Boot 4.0.3** | Framework para agilidade no desenvolvimento e configuração. |
| **Spring Data JPA** | Abstração de persistência de dados e integração com ORM. |
| **H2 Database** | Banco de dados em memória para desenvolvimento e testes rápidos. |
| **Lombok** | Redução de código boilerplate (getters, setters, construtores). |
| **Maven** | Gerenciamento de dependências e build do projeto. |
| **SLF4J/Logback** | Sistema de logging estruturado para monitoramento da aplicação. |

---

## 🛠️ Funcionalidades Principais

- **CRUD Completo**: Gerenciamento total do ciclo de vida de um filme (Criar, Ler, Atualizar e Deletar).
- **Persistência de Dados**: Integração fluida com banco de dados relacional via JPA.
- **Logging Estruturado**: Monitoramento de operações críticas no console para facilitar o debug e auditoria.
- **Arquitetura em Camadas**: Separação clara de responsabilidades entre Controllers, Services e Repositories.

---

## 📍 Endpoints da API

A API expõe os seguintes endpoints sob a base `/movies`:

| Método | Endpoint | Descrição |
| :--- | :--- | :--- |
| `GET` | `/movies` | Lista todos os filmes cadastrados. |
| `GET` | `/movies/{id}` | Retorna os detalhes de um filme específico. |
| `POST` | `/movies` | Cadastra um novo filme no sistema. |
| `PUT` | `/movies/{id}` | Atualiza as informações de um filme existente. |
| `DELETE` | `/movies/{id}` | Remove um filme do catálogo. |

---

## 🏗️ Estrutura do Projeto

O projeto segue uma estrutura organizada para facilitar a manutenção:

- `controllers`: Camada de exposição dos endpoints REST.
- `services`: Camada de regras de negócio e orquestração.
- `models`: Definição das entidades de domínio e persistência.
- `repositories`: Interface de comunicação com o banco de dados.

---

## 🏃 Como Executar o Projeto

### Pré-requisitos
- Java 17 ou superior.
- Maven instalado (ou utilize o `mvnw` incluso).

### Passos para execução
1. Clone o repositório:
   ```bash
   git clone https://github.com/LucasViana130/Movies.git
   ```
2. Navegue até o diretório do projeto:
   ```bash
   cd Movies/movies
   ```
3. Execute a aplicação:
   ```bash
   ./mvnw spring-boot:run
   ```
4. A API estará disponível em `http://localhost:8080`.
5. O console do H2 pode ser acessado em `http://localhost:8080/h2-console` (verifique as credenciais no `application.properties`).

---

## 👨‍💻 Autor

Desenvolvido por **Lucas Viana**. Sinta-se à vontade para entrar em contato!

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)(https://linkedin.com/in/lucas-viana-262068367)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/LucasViana130)
