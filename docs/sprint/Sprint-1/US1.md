# Anexação do encaminhamento médico digitalizado
## Resumo
Como beneficiário, quero anexar o encaminhamento médico digitalizado ao meu cadastro, para que ele sirva de base na criação da pré-guia.
## Sobre o encaminhamento médico:
O encaminhamento médico é o documento emitido pelo médico e entregue ao beneficiário, servindo de base obrigatória para a criação da pré-guia. Dentro do sistema, ele deve ser armazenado digitalmente e conter os seguintes valores:
- O arquivo digitalizado (PDF ou imagem)
- A data de envio/upload
- O beneficiário ao qual está vinculado
- O status de vínculo (se já foi utilizado em alguma pré-guia ou não)
## Detalhamento do processo:
1. O beneficiário loga no sistema.
2. O beneficiário acessa a área de cadastro/encaminhamento.
3. O beneficiário faz upload do arquivo digitalizado, através de uma requisição REST.
4. O sistema valida o formato e tamanho do arquivo.
5. O sistema salva o encaminhamento no banco, vinculando-o ao beneficiário logado.
## Critérios de aceitação:
- Certifique-se que o banco de dados esteja populado com ao menos um usuário Beneficiário.
- Certifique-se de criar as Entidades JPA (`@Entity`) de cada tabela necessária na realização desta task do projeto, seguindo os princípios de Orientação a Objetos (encapsulamento de atributos, uso de getters/setters).
- Certifique-se de criar os Repositories (Spring Data JPA, `extends JpaRepository`) de cada tabela necessários na realização desta task do projeto.
- Certifique-se de que queries customizadas (métodos derivados ou `@Query`) fiquem **exclusivamente** nos Repositories, nunca no Controller ou na Service.
- Certifique-se de que o Repository (ou a Service) valide o vínculo do Encaminhamento com o Beneficiário antes de persistir o registro.
- Certifique-se de seguir a arquitetura em camadas do Spring Boot: Entity, Repository, Service e Controller (REST).
- Certifique-se de criar `@RestController`s somente para os endpoints que envolvam esta task.
- Certifique-se de que o Controller rejeite arquivos com formato ou tamanho fora do permitido antes de acionar a Service/Repository.
- Certifique-se de implementar um web service REST (ex: `POST /encaminhamentos`) para realizar o upload do encaminhamento.
- Certifique-se de que o cliente (front-end/consumidor) consuma o web service REST criado para efetuar o upload.
