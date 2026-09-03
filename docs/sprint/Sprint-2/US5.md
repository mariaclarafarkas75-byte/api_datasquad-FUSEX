# Adição de Temas por um Professor

## Resumo

Como professor, quero informar os temas que preciso ensinar, para que a tabela seja montada usando esses assuntos.

## Sobre os temas:

### Para cada tema devem ser armazenados os valores:

- `id`: identificador
- `nome`: o nome do tema
- `disciplina`: o identificador da disciplina
- `opcional`: se é opcional ou não (`0` ou `1`)
- `dependencias`: os identificadores de outros temas
- `quantidade mínima`: o número mínimo de aulas de um tema
- `quantidade máxima`: o número máximo de aulas de um tema

#### Tabela:

| Campo             | Significado                                | Exemplo                                   | Propósito no Sistema                                                  |
| ----------------- | ------------------------------------------ | ----------------------------------------- | --------------------------------------------------------------------- |
| Nome              | Nome do tema                               | Introdução                                | Distribuir entre as aulas de um semestre                              |
| Disciplina        | A disciplina ao qual um tema está anexado. | Arquitetura e Modelagem de Banco de Dados | Identificar a disciplina de um tema, para a contagem da carga horária |
| Opcional          | Se um tema é opcional ou não               | Não                                       | Organizar a prioridade dos temas                                      |
| Dependencias      | Quais temas devem ser lecionados antes     | Introdução e Modelagem I                  | Organizar a prioridade dos temas                                      |
| Quantidade Mínima | Quantia mínima de aulas de um tema         | 1                                         | Atribuir a quantia correta de horas para a carga horária              |
| Quantidade Máxima | Quantia máxima de aulas de um tema         | 3                                         | Atribuir a quantia correta de horas para a carga horária              |

#### Exemplo:

| Nome         | Disciplina                                | Opcional | Dependencias | Quantidade Mínima | Quantidade Máxima |
| ------------ | ----------------------------------------- | -------- | ------------ | ----------------- | ----------------- |
| Introducao   | Arquitetura e Modelagem de Banco de Dados | Não      |              | 1                 | 1                 |
| Modelagem I  | Arquitetura e Modelagem de Banco de Dados | Não      | Introdução   | 1                 | 3                 |
| Modelagem II | Arquitetura e Modelagem de Banco de Dados | Não      | Modelagem I  | 1                 | 3                 |
| Mentoria     | Arquitetura e Modelagem de Banco de Dados | Sim      |              | 1                 | 1                 |

## Critérios de aceitação:

- Certifique-se que o professor consiga inserir o nome de um tema.
- Certifique-se que o professor consiga inserir a disciplina ao qual um tema pertence.
- Certifique-se que o professor consiga inserir a quantia mínima de aulas.
- Certifique-se que o professor consiga inserir a quantia máxima de aulas.
