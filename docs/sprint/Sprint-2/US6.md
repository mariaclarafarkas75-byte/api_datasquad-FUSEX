# Specificações de um Tema - 1

## Resumo

Como professor, quero indicar se um tema precisa ser ensinado antes de outro, para evitar que os alunos vejam um assunto sem entender o anterior.

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

- Certifique-se que o professor consiga afirmar que um tema depende de outro.
- Certifique-se que o professor consiga inserir mais de uma dependência para um tema.
- Certifique-se que o Banco de Dados não armazene redundâncias.
1. Suponha o seguinte caso do cadastro de um tema C: <br>
   Se um tema B possui dependência no tema A, e o tema C possui dependência no tema B, então basta armazenar no banco de dados, que o tema C possui dependência no tema B, e não em A e B.
