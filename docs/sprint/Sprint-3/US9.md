# US9 - Ajuste Manual do Cronograma de Aulas

## 1. Resumo (User Story)

**Como** professor,
**quero** poder ajustar manualmente alguma aula depois que a tabela estiver pronta, caso eu **queira** mudar algo.

---



## 2. Regras de Negócio e Funcionalidades

### 2.1. Pré-requisitos
Informações fundamentais para produção da _User Story_.

* Um ajuste só pode ser realizado, caso o professor informe o **Ano**, **Semestre do ano**, **Curso** e **Semestre do curso** previamente.
* Ajustes só devem ser realizados para o **ano atual**, e os semestres letivos dele.
Exemplo: Se informado o segundo semestre letivo do ano de 2025, quaisquer informações já cadastradas são inalteráveis (considerando inclusões), passível somente de visualização. Agora, caso o semestre informado for o segundo de 2026 (ano atual da publicação deste documento), as informações se tornam alteráveis.
* Para mais informações sobre quais informações são alteráveis, ou dúvidas, acesse o manual das regras de negócio da aplicação: #Duvidas  

### 2.2. Cancelamento de Aulas

Permite remover a ocorrência de aulas em datas específicas por motivos de força maior.

* **Escopo de Cancelamento:** O cancelamento deve ser granular. Deve-se informar a **data**, os **horários específicos** (em vez de turnos fechados) e a **justificativa**.
* **Isolamento por Curso/Turno:** O cancelamento em um curso ou horário anão deve afetar a grade de outros cursos do mesmo professor no mesmo dia.
* **Reversibilidade:** Deve ser possível desfazer um cancelamento (em caso de erro operacional), restaurando a aula ao estado anterior.
* **Visibilidade:** O sistema deve destacar visualmente no cronograma quais dias/horários foram cancelados.
* **Ação em Lote:** O usuário deve ter a opção de selecionar múltiplas linhas (aulas) e aplicar o cancelamento de uma só vez.

### 2.3. Alteração de Dados (Edição)

Permite modificar os detalhes pedagógicos e de status de uma aula sem alterar sua posição cronológica.

* **Campos Editáveis:** Disciplina, Tema, Tipo (Avaliação ou Aula Comum), Quantidade de Aulas e Status (Lecionado / Não Lecionado).
* **Persistência e Proteção:** Uma vez que os dados de uma aula sejam alterados manualmente, esses valores devem ser "travados" no banco de dados. O motor de geração automática do cronograma **não deve sobrescrever** esses ajustes manuais em reprocessamentos futuros.

---

## 3. Critérios de Aceite (Definition of Done)

1. **Seleção por Interface:** O usuário deve conseguir disparar as ações de "Editar" ou "Cancelar" diretamente ao selecionar uma ou mais linhas na tabela do cronograma.
2. **Validação de Dados:** O sistema só deve processar o cancelamento se os campos obrigatórios (Data, Horário e Motivo) estiverem preenchidos.
3. **Sincronização do Gerador:** Sempre que uma aula for alterada ou cancelada, a visão geral do cronograma e os cálculos de carga horária devem ser atualizados imediatamente.
4. **Integridade de Horários:** Se o professor cancelar apenas o horário $X$  de um turno que possui horários $X$, $Y$ e $Z$, as aulas nos horários $Y$ e $Z$ devem permanecer intactas e visíveis.

---

### Notas Técnicas

> **Observação sobre Conflitos:** Ao salvar alterações manuais, o sistema deve marcar o registro com uma *flag* (ex: `is_manual_adjustment: true`) para garantir que o algoritmo de geração automática ignore essas entradas em futuras execuções de otimização de datas.

---

## Dúvidas

Para sanar quaisquer dúvidas, acesso o manual das regras de negócio da aplicação: [Aqui](/docs/Manual_regras_negocio.md)
