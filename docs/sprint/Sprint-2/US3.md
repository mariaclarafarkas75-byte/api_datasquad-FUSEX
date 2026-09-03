# Restrições de Agendamento para Organização do Sistema

## Resumo

Como professor, desejo que o sistema impeça o agendamento de avaliações em períodos restritos, para garantir que o planejamento ocorra sem conflitos.

## Sobre os Períodos Restritos:

São datas em que não haverá aulas, e portanto, o sistema, ao realizar a dstribuição, não deverá atribuir temas à elas.

### Períodos Restritivos à toda Fatec - São José dos Campos:

- Os seguintes dias da semana: Domingos e Sábados (a princípio).
- Feriados nacionais.
- Feriados estaduais.
- Feriados municipais.
- Períodos entre o ínicio e fim de um semestre letivo.
- Emendas de feriados.
- Períodos referentes ao Baja.

### Períodos Restritivos à Um Professor:

- cancelamento de alguma data, por conta de imprevistos (falta de energia, ausência do docente, etc).

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
8. O sistema após o primeiro batch de informação, confirma se todas as disciplinas atingiram a carga horária mínima. <br>8.1. Se sim, termina a produção e envia o resultado ao professor. <br>8.2. Se não, distribui o restante das aulas das disciplinas em sábados letivos, em ordem regressiva (fim ao começo do ano), a fim de preencher as aulas faltantes.

## Critérios de aceitação:
- Certifique-se de que um tema não seja inserido em um período restrito.
- Períodos restritos que se apliquem a todos os professores, e possuam datas imutáveis, devem ser removidos automaticamente de todos os planejamentos.
- Períodos restritivos específicos à um professor, devem ser inseridos manualmente por o professor afetado.
- Períodos restritivos que concernam toda a instituição Fatec - São José dos Campos, devem ser inseridos por um admin.
- Períodos restritivos que concernam um semestre de um curso, devem ser inseridos por o coordenador responsável àquele curso.