# Restrições de Agendamento Atribuídas a Um Coordenador

## Resumo

Como professor, quero que o coordenador preencha as datas de feriados, para que não corrompam o planejamento.

## Sobre os Períodos Restritos:

São datas em que não haverá aulas, e portanto, o sistema, ao realizar a dstribuição, não deverá atribuir temas à elas.

### Perídos Restritivos Referentes ao Semestre de Um Curso:

- data de início da primeira semana de sprints.
- períodos de apresentação de Trabalhos de Graduação.

## Detalhamento do processo:

1. O coordenador atribui as disciplinas e cargas horárias à um professor.
2. O admin insere as datas de feriados nacionais, estaduais e municipais.
3. O coordenador bloqueia as datas restritivas que exigem interação manual.
4. O professor cadastra um tema com as devidas informações.
5. O sistema confirma a quantia de horas mínimas que uma disciplina possui.
6. O sistema realiza o cálculo de priorização dos temas.
7. O sistema distribui os temas em dias letivos, já considerando todas as datas restritivas.
8. O sistema após o primeiro batch de informação, confirma se todas as disciplinas atingiram a carga horária mínima. <br>
7.1. Se sim, termina a produção e envia o resultado ao professor. <br>
7.2. Se não, distribui o restante das aulas das disciplinas em sábados letivos, em ordem regressiva (fim ao começo do ano), a fim de preencher as aulas
faltantes.

## Critérios de Aceitação:
- Área de atuação do coordenador: **Perídos Restritivos Referentes ao Semestre de Um Curso**
- Certifique-se de que o coordenador consiga inserir uma data de início e uma data de término, para que o programa associe todas as datas intermediárias, iniciai e finais, como feriados.
- Certifique-se de que ao inserir uma data de início, a data de término copie o valor guardado, até que o coordenador altere-a ele mesmo.
- Certifique-se de adicionar a opção de um coordenador cancelar a decisão de uma ou mais datas restritivas, as quais escolheu.
- Certifique-se de que o coordenador não tenha acesso às datas restritivas determinadas por um professor ou admin.