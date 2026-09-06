# API 2026 - DATASQUAD: NEXUS

Faculdade de Tecnologia de São José dos Campos - Professor Jessen Vidal

# 

<p align="center">      <img src="docs/img/logo_datasquad.png" alt="logo do Data Squad" width="200">      <h2 align="center"> Data Squad </h2></p>

<p align="center">  | <a href ="#desafio"> Desafio</a>  |  <a href ="#solucao"> Solução</a>  |     <a href ="#backlog"> Backlog do Produto</a>|     <a href ="#sprintbacklog"> Sprint Backlog </a>  |  <a href ="#sprint"> Cronograma de Sprints</a>  |  <a href ="#tecnologias">Tecnologias</a> |  <a href ="#link">Link para Documentação</a>  |   <a href ="#equipe"> Equipe</a> |</p>

> Status do Projeto: A iniciar...

## Desafio <a id="desafio"></a>

A comunicação e o trâmite documental entre a UG FUSEX (Exército) e as OCS/PSA (clínicas, hospitais e profissionais da área de saúde) ainda depende, em grande parte, de processos manuais e desconexos, desde a emissão do pedido médico até o faturamento. Essa fragmentação eleva o risco de erros de preenchimento, retrabalho e inconsistências no faturamento, além de dificultar o rastreamento de todo o processo.

## Solução <a id="solucao"></a>

Para enfrentar esse cenário, propomos o desenvolvimento de uma aplicação que digitaliza e centraliza o fluxo documental entre beneficiários, FUSEX e OCS/PSA. O sistema permite que o beneficiário crie a pré-guia de forma digital a partir do encaminhamento médico, elimina a necessidade de deslocamento físico até o FUSEX, e possibilita que a guia seja emitida, assinada digitalmente e enviada eletronicamente à OCS escolhida.

Na etapa de faturamento, a aplicação padroniza o recebimento dos espelhos enviados pela OCS e automatiza o processo de lisura e glosa, comparando os valores da guia, do espelho e do contrato — reduzindo o retrabalho manual e a chance de erro humano. O funcionário do FUSEX mantém a possibilidade de revisar e intervir no resultado antes da conclusão do processo, garantindo controle humano sobre casos excepcionais sem abrir mão da agilidade da automação. Com isso, todo o trâmite passa a ser rastreável de ponta a ponta, desde a criação da pré-guia até a liquidação da fatura.

* * *

## Backlog do Produto <a id="backlog"></a>

| Rank | Prioridade | User Story                                                                                                                                                                                                                   | Estimativa | Sprint |
| ---- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ------ |
| 1    | Alta       | Como beneficiário, quero anexar o encaminhamento médico digitalizado ao meu cadastro, para que ele sirva de base na criação da pré-guia.                                                                                |            | 1      |
| 2    | Alta       | Como beneficiário, quero criar a pré-guia de forma digital informando a OCS e os procedimentos/exames a serem realizados, para que eu não precise ir pessoalmente ao FUSEX com o encaminhamento em mãos.                                                                                                               |            | 1      |
| 3    | Alta      | Como beneficiário, quero enviar a pré-guia preenchida para o setor de guias do FUSEX, para que ela seja analisada por um funcionário.                                                                        |            |        |
| 4    | Media      | Como funcionário do FUSEX, quero visualizar a lista de pré-guias pendentes de análise, para que eu possa organizá-las e analisá-las por ordem de chegada.                                                                                                                 |            |        |
| 5    | Media      | Como funcionário do FUSEX, quero visualizar os detalhes de uma pré-guia (encaminhamento, OCS escolhida, procedimentos), para que eu possa decidir se ela está apta a seguir no processo.                                                                                                           |            |        |
| 6    | Media      | Como beneficiário, quero acompanhar o status da minha pré-guia (pendente, em análise, aprovada, reprovada), para que eu saiba em que etapa do processo ela está.                                                                            |            |        |
| 7    | Alta      | Como usuário do aplicativo, quero realizar meu cadastro e assinatura digital utilizando meu documento pessoal (RG), para que eu possa acessar o sistema sem burocracias desnecessárias.                                                                                                          |            |        |
| 8    | Alta      | Como usuário do aplicativo (beneficiário ou funcionário do FUSEX), quero acessar o sistema com meu perfil específico, para que eu tenha acesso apenas às funcionalidades relacionadas ao meu papel.                                                                                                                              |            |        |
| 9    | Media      | Como funcionário do FUSEX, quero que a OCS envie o espelho em um formato padronizado, para que os dados possam ser lidos e comparados automaticamente pelo sistema.                                                                                                   |            |        |
| 10   | Media      | Como funcionário do FUSEX, quero que o sistema compare automaticamente o valor da guia com o valor do espelho e do contrato, para que eu não precise fazer essa conferência manualmente item por item.                                                                                            |            |        |
| 11   | Media      | Como funcionário do FUSEX, quero que o sistema aponte automaticamente as guias com divergência de valores entre espelho e contrato, para que eu saiba exatamente onde preciso intervir.                                                                                                |            |        |
| 12   | Alta      | Como funcionário do FUSEX, quero revisar o resultado consolidado da lisura/glosa de todas as guias da fatura antes de protocolar o mapa, para que eu possa corrigir eventuais erros enquanto ainda é possível alterá-los. |            |        |
| 13   | Media      | Como funcionário do FUSEX, quero visualizar o histórico de alterações feitas em uma lisura (automáticas e manuais), para que haja rastreabilidade de quem interveio e por quê.                                                                                                                         |            |        |
| 14   | Alta      | Como funcionário do FUSEX, quero protocolar a sessão de geração do mapa após confirmar a revisão final, para que os valores da lisura sejam bloqueados e o processo siga para liquidação.                                                                                                                         |            |        |

* * *

## Sprint Backlog 📅 <a id="sprintbacklog"></a>

<details>
  <summary><b>Sprint 1</b></summary>

### **Sprint 1: Execução e Planejamento**

* **Capacidade Estimada da Equipe:**
* **Meta da Sprint:** User Story de rank 1.
* **Metas Extras:** User Story de rank 2.

| Id                                                                              | rank | Prioridade | User Story                                                                                                                                    | Estimativa | Sprint |
| ------------------------------------------------------------------------------- | ---- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ------ |
| [Anexação do encaminhamento médico digitalizado](docs/sprint/Sprint-1/US1.md) | 1    | Alta       | Como beneficiário, quero anexar o encaminhamento médico digitalizado ao meu cadastro, para que ele sirva de base na criação da pré-guia. |            | 1      |
| [Criação digital da pré-guia](docs/sprint/Sprint-1/US2.md)                      | 2    | Alta       | Como beneficiário, quero criar a pré-guia de forma digital informando a OCS e os procedimentos/exames a serem realizados, para que eu não precise ir pessoalmente ao FUSEX com o encaminhamento em mãos.                                |            | 1      |

### Definition of Ready (DoR)

Para uma User Sory estar apta ao início de um Sprint, os critérios a seguir devem ser concluídos:

- Itens mandatórios já identificados.
- Tem uma clara separação de **instruções, descrição e exemplos**.
- **Critérios de aceitação e regras de negócio** definidos.
- **Prioridade** já definida.
- O **esforço** já definido pela equipe.

### Definition of Done (DoD)

Para uma User Story ser considerada **completa**, os seguintes critérios devem ser concluídos:

- O código está escrito, testado e limpo (seguindo os padrões da equipe).

- A funcionalidade deve estar integrada à branch **develop** do repositório [BD_2S_backend](https://github.com/rubensvnc/BD_2S_backend).

- Os **critérios de aceitação** de uma **User Story** foram completos.

- The interface complies with **usability principles**, providing clear and consistent navigation for the end user.

- A interface leva em consideração a facilidade de uso ao usuário, sempre exigindo o mínimo de interações possível.

- A funcionalidade foi **testada** e **aprovada** pelo **Product Owner (PO)**.

</details>

<br>

* * *

## Cronograma de Sprints <a id="sprint"></a>

Sprint | Previsão | Status|
|------|--------|------|
|Sprint 01 | 07/09/2026 | Não iniciado |
|Sprint 02| 05/10/2026| Não iniciado |
|Sprint 03| 02/11/2026 | Não iniciado |

* * *

## Tecnologias <a id="tecnologias"></a>

<h4 align="center">
        <a href="https://www.java.com/"><img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white"></a>
        <a href="https://www.jetbrains.com/idea/"><img src="https://img.shields.io/badge/IntelliJ_IDEA-000000?style=for-the-badge&logo=intellijidea&logoColor=white"></a>
        <a href="https://spring.io/"><img src="https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white"></a>
        <a href="https://maven.apache.org/"><img src="https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white"></a>
        <a href="https://www.atlassian.com/software/jira"><img src="https://img.shields.io/badge/Jira-0052CC?style=for-the-badge&logo=jira&logoColor=white"></a>
        <a href="https://github.com/about"><img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"></a>
</h4>

* * *

## Link para as documentações <a id="link"></a>

* [Manual de Instalação](docs/manual/instalacao.md)
* [Manual do Usuário](docs/manual/usuario.md)

* * *

# Equipe

| Função        | Nome                                    | Github                                                                                                                                              |
| ------------- | --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| Product Owner | Wanderson Ricardo dos Santos            | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Wander717)               |
| Scrum Master  | Maria Clara Prado Farkas                | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/mariaclarafarkas75-byte) |
| Team Member   | Breno Souza de Andrade                  | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/brenobsa)                |
| Team Member   | Matheus Henrique Ambrósio do Nascimento | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Froguie)                 |
| Team Member   | Guilhermina Moreira D'Onofrio           | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/guismdonofrio)           |
| Team Member   | Rubens Ferreira Venancio                | [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/rubensvnc/)              |