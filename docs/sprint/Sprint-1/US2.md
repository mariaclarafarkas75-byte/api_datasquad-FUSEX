# Criação digital da pré-guia
## Resumo
Como beneficiário, quero criar a pré-guia de forma digital informando a OCS e os procedimentos/exames a serem realizados, para que eu não precise ir pessoalmente ao FUSEX com o encaminhamento em mãos.
## Sobre a pré-guia:
A pré-guia é o documento criado pelo beneficiário dentro do sistema, com base em um encaminhamento médico já anexado, e que dará origem à Guia após aprovação do FUSEX. Ela contém os seguintes valores:
- A OCS escolhida
- Os procedimentos/exames a serem realizados
- O status da pré-guia (ex: Pendente, Em análise, Aprovada, Reprovada)
- A data de criação
- O encaminhamento médico ao qual está vinculada
- O beneficiário ao qual está vinculada
## Detalhamento do processo:
1. O beneficiário loga no sistema.
2. O sistema verifica se há um encaminhamento médico válido vinculado ao beneficiário, através de uma consulta REST.
3. O beneficiário seleciona a OCS entre as opções credenciadas disponíveis no sistema.
4. O beneficiário informa um ou mais procedimentos/exames a serem realizados.
5. O sistema salva a pré-guia no banco com status "Pendente", vinculada ao beneficiário e ao encaminhamento correspondente, através de uma requisição REST.
## Critérios de aceitação:
- Certifique-se que o banco de dados esteja populado com ao menos um usuário Beneficiário, um Encaminhamento válido e uma OCS cadastrada.
- Certifique-se de criar as Entidades JPA (`@Entity`) de cada tabela necessária na realização desta task do projeto, seguindo os princípios de Orientação a Objetos (encapsulamento de atributos, uso de getters/setters).
- Certifique-se de criar os Repositories (Spring Data JPA, `extends JpaRepository`) de cada tabela necessários na realização desta task do projeto.
- Certifique-se de que queries customizadas (métodos derivados ou `@Query`) fiquem **exclusivamente** nos Repositories, nunca no Controller ou na Service.
- Certifique-se de que consultas envolvendo `JOIN` (ex: pré-guia + encaminhamento + OCS) sejam implementadas no Repository da entidade principal da consulta, via relacionamento JPA (`@ManyToOne`/`@OneToOne`) ou `@Query` explícita.
- Certifique-se de que o Repository (ou a Service) impeça a criação da pré-guia caso não exista um Encaminhamento válido vinculado ao Beneficiário.
- Certifique-se de que a persistência da pré-guia seja feita através do Repository (Spring Data JPA), gerando o `INSERT` correspondente.
- Certifique-se de seguir a arquitetura em camadas do Spring Boot: Entity, Repository, Service e Controller (REST).
- Certifique-se de criar `@RestController`s somente para os endpoints que envolvam esta task.
- Certifique-se de implementar web services REST (ex: `POST /pre-guias`, `GET /pre-guias/{id}`) para criação e consulta da pré-guia.
- Certifique-se de que o cliente (front-end/consumidor) consuma os web services REST criados.
