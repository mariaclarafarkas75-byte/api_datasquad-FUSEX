# Restrições de Agendamento Atribuídas a Um Professor

## Resumo

Como professor, quero poder ajustar manualmente alguma aula depois que a tabela estiver pronta, caso eu queira mudar algo.

## Sobre os Períodos Restritos:

São datas em que não haverá aulas, e portanto, o sistema, ao realizar a dstribuição, não deverá atribuir temas à elas.

### Períodos Restritivos à Um Professor:

- cancelamento de alguma data, por conta de imprevistos (falta de energia, ausência do docente, etc).

## Detalhamento do processo:

1. O coordenador atribui as disciplinas e cargas horárias à um professor.
2. O admin insere as datas de feriados nacionais, estaduais e municipais.
3. O coordenador bloqueia as datas restritivas que exigem interação manual.
4. O professor cadastra um tema com as devidas informações.
5. O sistema confirma a quantia de horas mínimas que uma disciplina possui.
6. O sistema realiza o cálculo de priorização dos temas.
7. O sistema distribui os temas em dias letivos, já considerando todas as datas restritivas.
8. O sistema após o primeiro batch de informação, confirma se todas as disciplinas atingiram a carga horária mínima. <br>8.1. Se sim, termina a produção e envia o resultado ao professor. <br>8.2. Se não, distribui o restante das aulas das disciplinas em sábados letivos, em ordem regressiva (fim ao começo do ano), a fim de preencher as aulas faltantes.

## Critérios de aceitação:
- O professor não pode ter acesso à datas restritivas de outros usuários.
- Demande o mínimo de interações do professor.
- O cancelamento deve ser inserido ao banco de dados.
- Ao cancelar uma aula, o sistema deve reprogramar todo o planejamento. 
