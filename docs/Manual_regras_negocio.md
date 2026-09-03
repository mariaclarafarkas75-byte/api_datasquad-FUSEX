📋 Especificação Técnica do Sistema de Planejamento Acadêmico

* * *

1. Visão Geral

* * *

**Nome sugerido do sistema:** SwiftPlan

**Stack obrigatória:**

* Linguagem: Java (versão 17+ recomendada)
* Interface: JavaFX (versão 21+ recomendada)
* Banco de dados: MySQL

**Objetivo:** Centralizar o gerenciamento de calendários acadêmicos, cursos, disciplinas e planejamentos de aula, integrando Secretaria, Coordenadores e Professores em um único sistema desktop.

* * *

2. Princípio de UX Central

* * *

> **O sistema deve minimizar ao máximo o número de cliques e interações necessárias.** Sempre que possível, use preenchimento automático, herança de dados de períodos anteriores, propagação de configurações entre entidades similares e confirmação em lote.

* * *

3. Contexto de Domínio — Glossário Obrigatório

* * *

Antes de iniciar qualquer tela, o desenvolvedor deve internalizar os seguintes conceitos, pois eles se repetem em todo o sistema:

| Termo                        | Definição                                                                                                                                                                                                                                                                                             |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Semestre Letivo (do Ano)** | Período de 1º ou 2º semestre de um ano civil (ex: 1º Sem. 2026). Definido pela Secretaria.                                                                                                                                                                                                            |
| **Semestre do Curso**        | Posição curricular do aluno no curso (ex: 1º ao 6º semestre do curso de Programação). Completamente independente do semestre do ano.                                                                                                                                                                  |
| **Sprint**                   | Sub-período dentro de um semestre letivo. Cada semestre possui 3 sprints, cada uma com data de início, fim e data de Sprint Review.                                                                                                                                                                   |
| **Planejamento**             | Documento gerado automaticamente pelo sistema, exclusivo para a combinação: Ano + Semestre do Ano + Curso + Semestre do Curso + Professor + Disciplina.                                                                                                                                               |
| **Tema**                     | Unidade de conteúdo que equivale a 1 aula dentro de um planejamento.                                                                                                                                                                                                                                  |
| **Carga Horária Semestral**  | Número mínimo de aulas que uma disciplina exige no semestre do curso.                                                                                                                                                                                                                                 |
| **Data Bloqueada**           | Data em que nenhum curso pode ter aula (feriados, eventos, cancelamentos pela Secretaria).                                                                                                                                                                                                            |
| **Horário Cancelado**        | Um ou mais horários específicos de uma data, cancelados pela Secretaria ou pelo Professor com justificativa.                                                                                                                                                                                          |
| **Soft-Delete**              | Exclusões são lógicas (soft-delete): dados excluídos continuam visíveis em períodos passados que os usaram. Exemplo: Se no 1º semestre de 2026 a disciplina álgebra for excluída da grade curricular, os semestres de anos anteriores ainda devem utilizá-la, já que naquele tempo ela ainda existia. |

* * *

4. Contexto Global de Navegação — Seletor Persistente

* * *

### 4.1 Descrição

Em **todas** as telas do sistema (exceto login e configurações iniciais), deve existir um **seletor de contexto global fixo**, preferencialmente posicionado no topo da tela, que define o escopo de visualização e edição para toda a sessão atual.

### 4.2 Campos do Seletor Global

| Campo                 | Tipo                               | Comportamento                                                                   |
| --------------------- | ---------------------------------- | ------------------------------------------------------------------------------- |
| **Ano**               | ComboBox                           | Pré-selecionado com o ano atual. Editável.                                      |
| **Semestre do Ano**   | ToggleButton ou ComboBox (1º / 2º) | Pré-selecionado com o semestre atual (inferido pela data do sistema). Editável. |
| **Curso**             | ComboBox                           | Lista os cursos disponíveis. Filtra conforme o usuário logado.                  |
| **Semestre do Curso** | ComboBox                           | Lista os semestres do curso selecionado (ex: 1 a 8).                            |

### 4.3 Comportamento de Períodos Passados

* Se o usuário selecionar um Ano/Semestre do Ano **anterior ao atual**, o sistema inteiro entra em **modo leitura (read-only)**.
* Todas as ações de criar, editar e excluir devem ser **desabilitadas visualmente** (botões em estado `disabled`, campos com `setEditable(false)`, cor de fundo diferenciada — ex: cinza claro ou tom amarelado de "arquivo").
* Um **banner/label fixo** deve indicar claramente: `"Você está visualizando um período passado — modo somente leitura"`.

### 4.4 Implementação JavaFX sugerida

* Use um `HBox` ou `ToolBar` fixo no topo da `BorderPane` principal.
* Utilize `ComboBox<>` com listeners (`setOnAction`) que disparam a atualização de todas as telas abertas via um **padrão Observer** ou **binding de propriedade reativa** (`ObjectProperty<ContextoGlobal>`).
* O `ContextoGlobal` pode ser um objeto singleton acessível por todas as controllers.
* Para o modo read-only, considere usar um `BooleanBinding` derivado do contexto global e vinculá-lo ao `disableProperty()` de todos os controles de edição via `.bind()`.

* * *

5. Autenticação e Perfis de Usuário

* * *

### 5.1 Tela de Login

* Campos: **E-mail** e **Senha**.
* O sistema identifica automaticamente o perfil (ADM, Coordenador ou Professor) pelo e-mail e redireciona para o painel correspondente.
* **JavaFX sugerido:** `TextField` para e-mail, `PasswordField` para senha, `Button` de login. Suporte a `Enter` como atalho de confirmação via `setOnKeyPressed`.

### 5.2 Perfis

| Perfil                         | Criado por                                     | Capacidades resumidas                                  |
| ------------------------------ | ---------------------------------------------- | ------------------------------------------------------ |
| **Administrador (Secretaria)** | Cadastro inicial no sistema (ver Observação 1) | Configurar calendário, cursos, horários, coordenadores |
| **Coordenador**                | ADM                                            | Gerenciar disciplinas, professores, atribuições        |
| **Professor**                  | Coordenador                                    | Gerenciar temas, visualizar e confirmar planejamentos  |

### 5.3 Cadastro Inicial de ADM

Como o sistema precisa de pelo menos um ADM para funcionar, deve existir uma **tela de primeiro acesso**, exibida automaticamente quando o banco de dados não possui nenhum ADM cadastrado. Ela solicita: Nome, E-mail e Senha. Após o cadastro do primeiro ADM, essa tela nunca mais aparece. ADMs adicionais podem ser cadastrados dentro do próprio sistema por qualquer ADM existente (tela de gerenciamento de ADMs).

* * *

6. Módulo do Administrador (Secretaria)

* * *

### 6.1 Painel Principal do ADM

O painel deve apresentar acesso rápido às seções:

1. Calendário Acadêmico
2. Cursos e Horários
3. Coordenadores
4. Gerenciamento de ADMs
5. Datas Bloqueadas e Cancelamentos

Todas as ações realizadas por um ADM devem ser **logadas com o nome do ADM responsável** (armazenado em banco). Qualquer ADM pode visualizar e editar dados inseridos por outros ADMs.

* * *

### 6.2 Calendário Acadêmico

#### 6.2.1 Dados por Semestre Letivo

Para cada combinação de **Ano + Semestre do Ano**, o ADM deve registrar:

| Dado                              | Quantidade | Observações                                                   |
| --------------------------------- | ---------- | ------------------------------------------------------------- |
| Data de Início do Semestre Letivo | 1          | —                                                             |
| Data de Fim do Semestre Letivo    | 1          | —                                                             |
| Sprints                           | 3          | Cada sprint tem: data início, data fim, data da Sprint Review |
| Data da Apresentação de TCC       | 1          | —                                                             |
| Data da Feira de Soluções         | 1          | —                                                             |
| Feriados / Datas Bloqueadas       | N          | Ver seção 6.3                                                 |

#### 6.2.2 JavaFX sugerido para o Calendário

* Use um `GridPane` ou componente de calendário customizado (existem bibliotecas open-source compatíveis com JavaFX, como `CalendarFX`, mas se restrito ao puro JavaFX, monte um `GridPane` de 7 colunas representando os dias da semana).
* As datas de Sprint podem ser inseridas via `DatePicker` com validação de intervalo.
* As 3 sprints podem ser exibidas como 3 linhas de um `TableView` editável, com colunas: Sprint, Data Início, Data Fim, Data Sprint Review.
* Para o preenchimento de múltiplas datas bloqueadas, ver seção 6.3.

* * *

### 6.3 Datas Bloqueadas e Cancelamentos

#### 6.3.1 Datas Bloqueadas (Feriados e bloqueios gerais)

* Uma data bloqueada impede que **qualquer curso** tenha aula naquele dia.
* O ADM deve informar: **Data** e **Motivo**.
* Feriados nacionais/estaduais recorrentes devem ser **reutilizáveis**: ao abrir um semestre em um novo ano, o sistema apresenta as datas bloqueadas daquele semestre para o ano anterior como **sugestão pré-carregada**, permitindo ao ADM confirmar, remover ou adicionar novas antes de salvar. Exemplo: feriados do 1º Sem/2025 viram base do 1º Sem/2026)

**JavaFX sugerido para bloqueio em lote:**

* Um componente de calendário visual onde o ADM **clica em múltiplas datas** para selecioná-las (toggle: clique seleciona, clique novamente desseleciona). Datas selecionadas ficam destacadas visualmente.
* Após a seleção múltipla, um único campo de texto `TextField` de motivo e um botão **"Bloquear Selecionadas"** aplica o motivo a todas de uma vez.
* Use `ListView<LocalDate>` para exibir as datas já bloqueadas, com botão de remover em cada linha ou seleção múltipla + botão "Remover Selecionadas".

#### 6.3.2 Cancelamento de Dias Inteiros ou Horários Específicos

O ADM pode cancelar:

* **Um dia inteiro:** nenhum curso tem aula naquele dia.
* **Um turno específico** (manhã ou noite): apenas os cursos daquele turno são afetados.
* **Um ou mais horários específicos** de um turno em uma data.

Para cada cancelamento, o ADM deve informar o **motivo** (texto livre obrigatório).

**Impacto em planejamentos já gerados:** Se um planejamento de professor já foi gerado e um horário cancelado pelo ADM coincide com um horário do planejamento, o sistema deve **automaticamente marcar aquele horário do planejamento como "Cancelado pelo ADM"**, registrando o nome do ADM e o motivo descrito.

**JavaFX sugerido:**

* `DatePicker` para selecionar a data.
* `ToggleGroup` com `RadioButton` para escolher: "Dia inteiro", "Apenas manhã", "Apenas noite", "Horários específicos".
* Se "Horários específicos": exibir `CheckBox` para cada horário disponível naquele turno/data.
* `TextArea` para o motivo.
* Suporte a múltiplas datas: lista de `DatePicker` dinâmica ou seleção em calendário visual (igual à seção 6.3.1).

* * *

### 6.4 Cursos

#### 6.4.1 Cadastro de Curso

Campos obrigatórios:

* **Nome do curso** (único no sistema — validar unicidade antes de salvar).
* **Turno** (Manhã / Noite) — usar `ComboBox` ou `ToggleButton`.
* **Quantidade de semestres** do curso (ex: 6 semestres).
* **Coordenador** (selecionado de uma lista de coordenadores cadastrados) — apenas 1 coordenador por curso.

**Regras de validação:**

* Dois cursos não podem ter o mesmo nome.
* Um coordenador não pode ser vinculado a mais de um curso.

#### 6.4.2 Gerenciamento de Cursos

* Listar todos os cursos em um `TableView` com colunas: Nome, Turno, Semestres, Coordenador.
* Botões de ação por linha: **Editar** e **Excluir** (com confirmação via `Alert` do tipo `CONFIRMATION`).

* * *

### 6.5 Horários dos Cursos

#### 6.5.1 Estrutura de Horários

Cada curso possui uma grade de horários de aulas para o semestre. Exemplo real fornecido pelo cliente:

> Curso noturno: das 18h00 às 23h00, com 5 aulas:
> 
> * Aula 1: 18h00 – 18h30
> * Aula 2: 18h30 – 19h00
> * Intervalo: 19h00 – 19h10
> * Aula 3: 19h10 – 20h25
> * Aula 4: 20h25 – 22h00
> * Aula 5: 22h00 – 23h00

O sistema deve suportar a definição de **N aulas e M intervalos** por curso, com horário de início e fim para cada um.

#### 6.5.2 Templates Base

* O sistema possui **templates base** para turno da manhã e turno da noite (configuráveis pelo ADM, não hard-coded).
* Ao cadastrar o horário de um curso, o template do turno correspondente é **pré-carregado**, podendo ser modificado livremente.
* **Propagação entre cursos do mesmo turno:** Se o ADM configurar o horário de um curso noturno, todos os outros cursos noturnos **que ainda não tiveram seus horários configurados naquele semestre** herdam automaticamente a configuração do último curso alterado. O ADM ainda pode sobrescrever individualmente.
* **Herança entre anos:** Ao iniciar a configuração de horários de um novo semestre letivo, o sistema carrega como base os horários do semestre letivo anterior para cada curso.

#### 6.5.3 JavaFX sugerido para Horários

* Um `TableView` editável com colunas: Tipo (Aula/Intervalo), Número, Hora Início, Hora Fim.
* Linhas adicionáveis dinamicamente via botão **"+ Adicionar Linha"**.
* Campos de horário via `TextField` com `TextFormatter` para validação no formato `HH:mm`.
* Botão **"Aplicar Template"** que carrega o template padrão do turno.
* Botão **"Propagar para Cursos do Mesmo Turno"** (aplica a todos os cursos do mesmo turno que ainda não foram configurados no período selecionado).

* * *

### 6.6 Coordenadores

#### 6.6.1 Cadastro de Coordenador

Campos:

* **Nome**
* **E-mail** (será o login)
* **Senha** (criar pelo ADM)
* **Curso** (associação obrigatória — apenas cursos sem coordenador vigente aparecem na lista, a menos que seja edição)

#### 6.6.2 Gerenciamento

`TableView` com: Nome, E-mail, Curso vinculado, ações de Editar e Excluir.

* * *

### 6.7 Gerenciamento de ADMs

* Listagem de todos os ADMs em `TableView`: Nome, E-mail.
* Botão para adicionar novo ADM (Nome, E-mail, Senha).
* Editar e excluir (não é possível excluir o próprio ADM logado).

* * *

7. Módulo do Coordenador

* * *

### 7.1 Painel Principal do Coordenador

O coordenador vê apenas dados do **seu curso**. O seletor global filtra automaticamente o curso para o qual ele é responsável (campo Curso bloqueado com seu curso).

Seções do painel:

1. Disciplinas
2. Professores
3. Atribuições de Disciplinas
4. Estatísticas e Planejamentos dos Professores

* * *

### 7.2 Disciplinas

#### 7.2.1 Cadastro de Disciplina

Para cada **Semestre do Curso** (ex: 1º ao 6º semestre do curso), o coordenador cadastra disciplinas com:

* **Nome** da disciplina
* **Carga Horária Mínima** (quantidade mínima de aulas por semestre do ano — ex: 80 aulas)
* **Semestre do Curso** ao qual pertence

#### 7.2.2 Gerenciamento

`TableView` com: Nome, Semestre do Curso, Carga Horária Mínima, Professor Atribuído. Ações: Editar, Excluir.

* * *

### 7.3 Professores

#### 7.3.1 Cadastro de Professor

Campos:

* **Nome**
* **E-mail**
* **Senha**

**Verificação de duplicata:** Antes de cadastrar, o sistema deve verificar se já existe um usuário (professor ou coordenador) com aquele e-mail e exibir um aviso claro ao coordenador.

#### 7.3.2 Coordenador como Professor

Um coordenador pode se atribuir como professor de uma disciplina. O sistema deve reconhecer esse caso e não criar um novo usuário — o coordenador usa sua própria conta com as permissões de professor **adicionadas** ao seu perfil. Na tela de atribuição, deve haver uma opção visível: **"Atribuir a mim mesmo"**.

* * *

### 7.4 Atribuição de Disciplinas a Professores

#### 7.4.1 Regras

* Cada disciplina pode ter **apenas 1 professor** atribuído.
* Um professor pode lecionar em **múltiplos cursos**, desde que seus horários não conflitem.
* O coordenador define para a atribuição:
  * **Professor**
  * **Disciplina**
  * **Dias da semana** (segunda a sábado) em que o professor leciona essa disciplina
  * **Horários** em cada dia (ex: na segunda: Aula 1 e Aula 3; na quarta: Aula 2 e Aula 4)
  * Observação: os horários podem variar por dia da semana

#### 7.4.2 Validação de Conflito de Horários

O sistema deve verificar se o professor já está alocado naquele dia e horário em outra disciplina/curso antes de permitir a atribuição. Em caso de conflito, exibir exatamente quais horários estão ocupados e por qual disciplina/curso.

#### 7.4.3 JavaFX sugerido para Atribuição

* `ComboBox` para selecionar Professor e Disciplina.
* Uma grade semanal (segunda a sábado) representada por um `GridPane`:
  * Linhas: horários de aula do curso (Aula 1, Aula 2, Aula 3...)
  * Colunas: dias da semana (Seg, Ter, Qua, Qui, Sex, Sáb)
  * Cada célula: `CheckBox` — marcar significa que o professor leciona naquele dia/horário
  * Células com conflito: exibidas em cor de destaque (ex: vermelho) com `Tooltip` explicando o conflito
* Botão **"Salvar Atribuição"** — só habilitado se não houver conflitos.

* * *

### 7.5 Visualização de Estatísticas e Planejamentos dos Professores

O coordenador pode, dentro do contexto global selecionado (Ano, Semestre do Ano, Curso, Semestre do Curso), ver:

* Lista de professores do curso e suas disciplinas atribuídas.
* As estatísticas de cada professor (mesmas exibidas para o professor, descritas na seção 9).
* O planejamento gerado de cada professor (modo leitura).

**JavaFX sugerido:** `TabPane` onde cada aba representa um professor, ou `TreeView` expandível por professor → disciplinas → planejamento/estatísticas.

* * *

8. Módulo do Professor

* * *

### 8.1 Painel Principal do Professor

O professor vê apenas as disciplinas às quais está atribuído. Se for também coordenador, as funcionalidades do coordenador aparecem em seção separada (ex: aba "Coordenação" no painel).

Seções:

1. Temas
2. Planejamentos
3. Estatísticas
4. Carga Horária e Rotina (somente leitura)

* * *

### 8.2 Temas

#### 8.2.1 Cadastro de Tema

Para cada disciplina atribuída ao professor no contexto global atual, o professor cadastra temas:

| Campo                    | Tipo                                   | Descrição                                                                      |
| ------------------------ | -------------------------------------- | ------------------------------------------------------------------------------ |
| **Disciplina**           | ComboBox                               | Selecionado dentre as disciplinas do professor no contexto atual               |
| **Nome do Tema**         | TextField                              | Nome descritivo do conteúdo                                                    |
| **É Avaliação?**         | CheckBox / ToggleButton                | Indica se esta "aula" é uma prova/avaliação                                    |
| **Qtd. Mínima de Aulas** | Spinner/TextField numérico             | Mínimo de aulas para cobrir o tema                                             |
| **Qtd. Máxima de Aulas** | Spinner/TextField numérico             | Máximo de aulas para cobrir o tema                                             |
| **Prioridade**           | Spinner numérico ou DragList           | Ordem de prioridade do tema em relação aos demais (1 = maior prioridade)       |
| **É Opcional?**          | CheckBox                               | Se marcado, o tema só é incluído se houver aulas sobrando após os obrigatórios |
| **Dependências**         | ListView com seleção múltipla ordenada | Temas que devem ser lecionados antes deste (a ordem das dependências importa)  |

#### 8.2.2 Dependências entre Temas

* O sistema deve detectar e alertar **dependências circulares** (ex: Tema A depende de B, e B depende de A).
* A **ordem** das dependências importa: se o Tema C depende de [Tema A, Tema B], significa que Tema A deve ser lecionado antes de Tema B, que deve ser lecionado antes de Tema C.
* **JavaFX sugerido para dependências:** Um `ListView` à esquerda com todos os temas disponíveis da disciplina (exceto o próprio) e um `ListView` à direita representando as dependências ordenadas. O professor usa botões de `↑` `↓` para reordenar e `→` `←` para adicionar/remover dependências. Alternativamente, um componente de `drag-and-drop` entre as duas listas usando `setOnDragDetected` e `setOnDragDropped`.

#### 8.2.3 Permissões de Edição

* O professor pode editar/excluir apenas temas do **ano e semestre do ano atuais**.
* Dados de períodos passados são somente leitura (reforçado pelo seletor global, seção 4).

* * *

### 8.3 Geração de Planejamento

#### 8.3.1 O que é um Planejamento

Um planejamento é gerado **automaticamente pelo sistema** — o professor não distribui manualmente as aulas. O professor apenas garante que os dados de entrada estejam corretos (temas, atribuições de horários), e o sistema faz a distribuição.

O planejamento é exclusivo para a combinação:

> **Ano + Semestre do Ano + Curso + Semestre do Curso + Professor**

#### 8.3.2 Algoritmo de Geração (descrever ao desenvolvedor back-end, mas o front deve refletir o resultado)

1. **Entrada:** Temas da disciplina (com min/max de aulas, prioridade, opcionalidade e dependências), dias e horários em que o professor leciona aquela disciplina, período letivo do semestre (data início a data fim), datas bloqueadas e cancelamentos do ADM.

2. **Processo:** a. Ordenar temas por prioridade (e respeitar dependências — um tema dependente nunca pode aparecer antes de suas dependências).b. Excluir do calendário: fins de semana (sábados e domingos, por padrão), datas bloqueadas pela Secretaria, datas canceladas.c. Para cada data válida, alocar os horários definidos para a disciplina naquele dia da semana.d. Distribuir os temas nos slots de aula disponíveis (1 tema = 1 aula), respeitando quantidade mínima e máxima de aulas por tema.e. Continuar até a carga horária mínima da disciplina ser satisfeita.f. **Se os horários de segunda a sexta esgotarem e a carga horária ainda não for satisfeita:** usar os sábados, tratando-os como dias normais (com os mesmos horários base do turno). A distribuição dos sábados deve ser feita de forma **regressiva** (do final do semestre letivo para o início).g. Temas opcionais só são incluídos se houver slots sobrando após os obrigatórios serem todos alocados.

3. **Resultado:** Lista de entradas no formato: Data + Horário (ex: "Aula 3") + Tema alocado + Status inicial (Não Ministrada).

#### 8.3.3 Visualização do Planejamento

O professor visualiza o planejamento no contexto global selecionado. O layout sugerido é uma **lista agrupada por data**, estilo agenda: Segunda, 10/03/2026 ├─ Aula 1 (18h00 – 18h30) | Tema: Introdução ao Java | Status: ✅ Ministrada ├─ Aula 3 (19h10 – 20h25) | Tema: Variáveis e Tipos | Status: ⏳ Não ministrada └─ Aula 5 (22h00 – 23h00) | Tema: Estruturas de Controle | Status: ❌ Cancelada (Professor passou mal) Quarta, 12/03/2026 ...

**JavaFX sugerido:**

* `TreeView<>` onde a raiz é o planejamento, primeiro nível são as datas, segundo nível são os horários.
* Ou `ListView` com células customizadas (`ListCell`) agrupadas por data usando separadores (`Separator`).
* Cada linha de horário possui: label de horário, label de tema, indicador de status (ícone/cor), e botão de ação contextual.

#### 8.3.4 Confirmação de Aulas e Cancelamentos

**Confirmação:** O padrão do sistema é **automático**: o sistema compara horário atual com horário do slot e marca como "Ministrada" se já passou, e "Não Ministrada" caso contrário. Professor pode sobrescrever manualmente.

**Cancelamento pelo Professor:**

* O professor seleciona um ou mais horários e clica em **"Cancelar Selecionados"**.
* Um `Dialog` (ou painel lateral) aparece solicitando o **motivo do cancelamento**.
* O motivo é aplicado a todos os horários selecionados de uma vez.

**JavaFX sugerido para cancelamento em lote:**

* `CheckBox` em cada linha da lista de planejamento.
* Barra de ações flutuante que aparece ao selecionar ao menos 1 item: botões "Marcar como Ministrada" e "Cancelar Selecionados".
* Ao clicar em "Cancelar Selecionados", um `Dialog` customizado aparece com `TextArea` para o motivo e botões Confirmar/Cancelar.

**Cancelamento pelo ADM (propagação automática):**

* Quando um ADM cancela um horário ou data após planejamentos já gerados, o sistema deve atualizar automaticamente todos os planejamentos impactados.
* O slot recebe status **"Cancelado pela Secretaria"**, com o nome do ADM e o motivo registrado.
* O professor **não pode alterar** cancelamentos feitos pela Secretaria, apenas visualizá-los.

* * *

9. Estatísticas

* * *

### 9.1 Escopo

As estatísticas são exibidas **por disciplina**, dentro do contexto global selecionado (Ano + Semestre do Ano + Curso + Semestre do Curso). Assim que o professor (ou coordenador) seleciona um contexto e um planejamento específico, as estatísticas aparecem imediatamente vinculadas.

### 9.2 Dados Exibidos

| Indicador                                  | Descrição                                                                                                              |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| **Total de Temas**                         | Quantidade total de temas cadastrados para a disciplina no período                                                     |
| **Nomes dos Temas**                        | Listagem expandível com nome de cada tema                                                                              |
| **Aulas Geradas por Tema**                 | Quantas aulas foram alocadas a cada tema no planejamento                                                               |
| **Aulas Não Ministradas**                  | Contagem de slots com status "Não Ministrada"                                                                          |
| **Aulas Ministradas**                      | Contagem de slots confirmados                                                                                          |
| **Aulas Canceladas**                       | Total de cancelamentos (pelo professor + pela Secretaria, exibido separadamente)                                       |
| **Avaliações Restantes**                   | Quantas avaliações (temas marcados como "É Avaliação") ainda não foram ministradas                                     |
| **% de Conclusão da Carga Horária**        | `(Aulas Ministradas / Carga Horária Mínima) × 100`                                                                     |
| **Sábados utilizados** _(sugerido)_        | Indica se o algoritmo precisou usar sábados e quantos                                                                  |
| **Temas Opcionais incluídos** _(sugerido)_ | Lista de temas opcionais que entraram no planejamento                                                                  |
| **Projeção de conclusão** _(sugerido)_     | Com base no ritmo atual (aulas ministradas por semana), estimar se a carga horária será cumprida até o fim do semestre |

### 9.3 Regra de Edição Indireta

O professor **não edita as estatísticas diretamente**. Os valores são sempre derivados dos dados subjacentes:

* Mudar o status de uma aula → atualiza contadores de ministradas/não ministradas/canceladas.
* Adicionar/remover temas → dispara nova geração de planejamento → atualiza aulas por tema.

**JavaFX sugerido:**

* `ProgressBar` vinculado à porcentagem de conclusão.
* `Label` com os números em tempo real via `IntegerBinding` ou `SimpleIntegerProperty` observáveis.
* Painel lateral ou aba dedicada exibida simultaneamente ao planejamento.
* Gráfico de pizza ou barras (`PieChart` ou `BarChart` do JavaFX) para visualização proporcional de status das aulas.

* * *

10. Carga Horária e Rotina (Professor — Somente Leitura)

* * *

O professor tem acesso a uma tela que exibe, para cada disciplina no contexto selecionado:

* Os dias da semana e horários em que leciona.
* A carga horária mínima configurada pelo coordenador.
* O total de aulas geradas no planejamento.

**JavaFX sugerido:** Tabela simples (`TableView`) ou grade visual semanal (igual ao usado na atribuição, mas somente leitura com `setEditable(false)`).

* * *

11. Banco de Dados — Entidades Principais (referência para o front-end)

* * *

O front-end deve ser capaz de consumir/exibir as seguintes entidades. A modelagem exata é responsabilidade do desenvolvedor back-end, mas o front deve estar ciente de suas relações: ADM (id, nome, email, senha_hash) Curso (id, nome, turno, qtd_semestres, coordenador_id) Coordenador (id, nome, email, senha_hash, curso_id) Professor (id, nome, email, senha_hash) SemestreLetivo (id, ano, numero_semestre[1|2], data_inicio, data_fim, data_tcc, data_feira) Sprint (id, semestre_letivo_id, numero[1|2|3], data_inicio, data_fim, data_review) DataBloqueada (id, data, motivo, adm_id, semestre_letivo_id, recorrente[bool]) HorarioCurso (id, curso_id, semestre_letivo_id, tipo[aula|intervalo], numero_ordem, hora_inicio, hora_fim) Disciplina (id, nome, semestre_curso[1..N], carga_horaria_minima, curso_id) AtribuicaoProfessor (id, disciplina_id, professor_id, semestre_letivo_id) AtribuicaoHorario (id, atribuicao_id, dia_semana[1..6], horario_curso_id) Tema (id, disciplina_id, nome, eh_avaliacao, qtd_min_aulas, qtd_max_aulas, prioridade, eh_opcional, semestre_letivo_id) DependenciaTema (id, tema_id, tema_dependencia_id, ordem) Planejamento (id, atribuicao_professor_id, semestre_letivo_id, gerado_em) SlotPlanejamento (id, planejamento_id, data, horario_curso_id, tema_id, status[nao_ministrada|ministrada|cancelada_professor|cancelada_adm], motivo_cancelamento, cancelado_por_adm_id) CancelamentoADM (id, adm_id, data, horario_curso_id[nullable], turno[nullable], dia_inteiro[bool], motivo, semestre_letivo_id)

* * *

12. Padrões de Interface Globais

* * *

| Padrão                           | Especificação                                                                             |
| -------------------------------- | ----------------------------------------------------------------------------------------- |
| **Confirmações destrutivas**     | Toda ação de excluir deve abrir um `Alert.CONFIRMATION` com nome do item sendo excluído   |
| **Feedback de sucesso**          | Usar `Tooltip` temporário ou `Label` de status visível por 3 segundos após salvar         |
| **Campos obrigatórios**          | Borda vermelha (`-fx-border-color: red`) e mensagem abaixo do campo quando não preenchido |
| **Loading**                      | Operações de geração de planejamento devem exibir `ProgressIndicator` enquanto processam  |
| **Modo read-only**               | Banner amarelo no topo + todos os controles com `setDisable(true)`                        |
| **Identificador de ADM em logs** | Todo dado inserido/alterado/excluído por ADM deve exibir na UI o nome do ADM responsável  |

* * *

13. Fluxos Críticos Resumidos

* * *

    [FLUXO 1 — ADM configura o semestre]
    Login ADM → Selecionar Ano/Semestre → Preencher datas letivas
    → Cadastrar 3 Sprints → Adicionar datas bloqueadas (reutilizando anteriores)
    → Configurar horários dos cursos → Publicar semestre
    
    [FLUXO 2 — Coordenador prepara a disciplina]
    Login Coordenador → Selecionar contexto → Cadastrar disciplinas por semestre do curso
    → Cadastrar professores (verificar duplicatas) → Atribuir disciplinas + horários/dias
    → Verificar conflitos automaticamente
    
    [FLUXO 3 — Professor planeja e acompanha]
    Login Professor → Selecionar contexto → Cadastrar temas (com dependências e prioridades)
    → Sistema gera planejamento automaticamente → Professor confirma/cancela aulas
    → Estatísticas atualizam em tempo real
    
    [FLUXO 4 — ADM cancela horário após planejamentos gerados]
    ADM cancela horário X da data Y com motivo M
    → Sistema busca todos SlotPlanejamento com data=Y e horario=X
    → Atualiza status para "cancelada_adm", motivo=M, cancelado_por_adm_id=ADM
    → Professor vê a alteração na próxima vez que abrir o planejamento

* * *

> **Nota para o desenvolvedor front-end:** Todos os formulários devem evitar o uso de múltiplas telas/janelas para tarefas que podem ser resolvidas em painéis laterais (`SplitPane`), diálogos modais (`Dialog`) ou expansão de seções (`TitledPane` com `setExpanded`). O princípio de mínimo de cliques deve guiar cada decisão de layout. Sempre que possível, prefira edição **inline** em `TableView` (`TableView.setEditable(true)` com `TextFieldTableCell`) à abertura de uma nova janela de edição.
