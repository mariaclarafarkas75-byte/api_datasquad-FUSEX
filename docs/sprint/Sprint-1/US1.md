# Geração automática do cronograma de um professor.

## Resumo

Como professor, quero que a tabela do semestre seja montada automaticamente, para não precisar gastar horas organizando manualmente as aulas.

## Sobre a tabela do semestre:
 A tabela do semestre é um cronograma que diz quando, quantas e quais aulas um professor lecionará ao longo de um semestre de um curso, 
 e ela contém os seguintes valores:
 - A data da aula a lecionar.
 - O tema da disciplina
 - Uma observação com relação ao andamento do cronograma de Sprints
 - A quantidade de aulas lecionadas
 - O dia da semana que o tema foi lecionado.

## Detalhamento do processo:
1. Um professor loga no sistema
2. O professor seleciona o semestre e o curso.
3. O sistema recupera as informações do cronograma daquele professor no banco e as dispoõe ao usuário

## Critérios de aceitação:
- Certifique-se que o banco de dados esteja populado com ao menos um usuário Professor.
- Certifique-se de criar as Entidades de cada tabela necessária na realização desta task do projeto.
- Certifique-se de criar os DAOs de cada tabela necessários na realização desta task do projeto.
- Certifique-se de que queries SQL fiquem **exclusivamente** nos DAOs.
- Certifique-se de que SELECTs com JOIN sejam alocadas ao DAO da tabela principal do SELECT.
- Certifique-se de seguir o modelo MVC - Model, View e Controller.
- Certifique-se de criar Controllers somente para telas que envolvam esta task.
