# 📘 Manual do Usuário — SwiftPlan

### Sistema de Planejamento Acadêmico

* * *

## Sumário

1. [Visão Geral do Sistema](#1-visão-geral-do-sistema)
2. [Glossário](#2-glossário)
3. [Acesso ao Sistema](#3-acesso-ao-sistema)
4. [Seletor de Contexto Global](#4-seletor-de-contexto-global)
5. [Módulo do Administrador (Secretaria)](#5-módulo-do-administrador-secretaria)
   * 5.1 [Calendário Acadêmico](#51-calendário-acadêmico)
   * 5.2 [Datas Bloqueadas e Cancelamentos](#52-datas-bloqueadas-e-cancelamentos)
   * 5.3 [Cursos](#53-cursos)
   * 5.4 [Horários dos Cursos](#54-horários-dos-cursos)
   * 5.5 [Coordenadores](#55-coordenadores)
   * 5.6 [Gerenciamento de Administradores](#56-gerenciamento-de-administradores)
6. [Módulo do Coordenador](#6-módulo-do-coordenador)
   * 6.1 [Disciplinas](#61-disciplinas)
   * 6.2 [Professores](#62-professores)
   * 6.3 [Atribuição de Disciplinas a Professores](#63-atribuição-de-disciplinas-a-professores)
   * 6.4 [Estatísticas e Planejamentos dos Professores](#64-estatísticas-e-planejamentos-dos-professores)
7. [Módulo do Professor](#7-módulo-do-professor)
   * 7.1 [Temas](#71-temas)
   * 7.2 [Planejamento de Aulas](#72-planejamento-de-aulas)
   * 7.3 [Estatísticas](#73-estatísticas)
   * 7.4 [Carga Horária e Rotina](#74-carga-horária-e-rotina)
8. [Fluxos Principais de Uso](#8-fluxos-principais-de-uso)

* * *

## 1. Visão Geral do Sistema

O **SwiftPlan** é um sistema desktop de planejamento acadêmico desenvolvido para centralizar e automatizar a gestão de calendários, cursos, disciplinas e planejamentos de aula. Ele conecta três perfis de usuário — **Secretaria (Administrador)**, **Coordenador** e **Professor** — em um ambiente único e integrado.

### Perfis de Usuário

| Perfil                         | Responsabilidades principais                                                                        |
| ------------------------------ | --------------------------------------------------------------------------------------------------- |
| **Administrador (Secretaria)** | Configurar o calendário acadêmico, gerenciar cursos, horários, datas bloqueadas e cancelamentos     |
| **Coordenador**                | Gerenciar disciplinas, cadastrar professores e realizar atribuições de disciplinas                  |
| **Professor**                  | Cadastrar temas, visualizar o planejamento gerado automaticamente e registrar o andamento das aulas |

> **Importante:** Cada perfil acessa apenas as funcionalidades correspondentes às suas responsabilidades. O sistema redireciona automaticamente o usuário para o painel correto após o login.

* * *

## 2. Glossário

Antes de utilizar o sistema, familiarize-se com os termos utilizados ao longo desta documentação e nas telas do SwiftPlan.

| Termo                    | Definição                                                                                                                                    |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **Semestre Letivo**      | Período de 1º ou 2º semestre de um ano civil (ex: 1º Semestre de 2026). Definido pela Secretaria.                                            |
| **Semestre do Curso**    | Posição curricular do aluno no curso (ex: 1º ao 6º semestre do curso de Programação). Completamente independente do semestre do ano.         |
| **Sprint**               | Sub-período dentro de um semestre letivo. Cada semestre possui 3 sprints, cada uma com data de início, fim e data de Sprint Review.          |
| **Planejamento**         | Documento gerado automaticamente pelo sistema para a combinação: Ano + Semestre do Ano + Curso + Semestre do Curso + Professor + Disciplina. |
| **Tema**                 | Unidade de conteúdo equivalente a 1 aula dentro de um planejamento.                                                                          |
| **Carga Horária Mínima** | Número mínimo de aulas que uma disciplina exige no semestre do curso.                                                                        |
| **Data Bloqueada**       | Data em que nenhum curso pode ter aula (feriados, eventos institucionais ou cancelamentos pela Secretaria).                                  |
| **Horário Cancelado**    | Um ou mais horários específicos de uma data, cancelados pela Secretaria ou pelo Professor mediante justificativa.                            |

* * *

## 3. Acesso ao Sistema

### 3.1 Tela de Login

Ao abrir o SwiftPlan, você será apresentado à tela de login. Preencha os campos:

* **E-mail:** endereço de e-mail cadastrado no sistema.
* **Senha:** sua senha de acesso.

Pressione o botão **Entrar** ou tecle **Enter** para confirmar. O sistema identificará automaticamente o seu perfil e redirecionará para o painel correspondente.

### 3.2 Primeiro Acesso ao Sistema (somente para o ADM inicial)

Quando o sistema é utilizado pela primeira vez — sem nenhum administrador cadastrado — uma tela especial de **primeiro acesso** é exibida automaticamente. Nela, o responsável pela implantação deve preencher:

* **Nome**
* **E-mail**
* **Senha**

Após esse cadastro inicial, essa tela nunca mais aparecerá. Administradores adicionais podem ser criados dentro do próprio sistema por qualquer ADM existente.

* * *

## 4. Seletor de Contexto Global

Em todas as telas do sistema (exceto login), há um **seletor de contexto global fixo no topo da tela**. Ele determina o escopo de visualização e edição de toda a sessão.

### Campos do Seletor

| Campo                 | Comportamento                                                       |
| --------------------- | ------------------------------------------------------------------- |
| **Ano**               | Pré-selecionado com o ano atual. Pode ser alterado.                 |
| **Semestre do Ano**   | Pré-selecionado com o semestre atual (1º ou 2º). Pode ser alterado. |
| **Curso**             | Lista os cursos disponíveis, filtrados conforme o usuário logado.   |
| **Semestre do Curso** | Lista os semestres do curso selecionado (ex: 1 a 6).                |

### Modo Somente Leitura (Períodos Passados)

Ao selecionar um **Ano/Semestre anterior ao atual**, o sistema entra automaticamente em **modo somente leitura**. Nesse estado:

* Todos os botões de criar, editar e excluir ficam desabilitados.
* Um aviso é exibido no topo da tela: **"Você está visualizando um período passado — modo somente leitura"**.
* É possível consultar todos os dados históricos sem risco de alteração.

* * *

## 5. Módulo do Administrador (Secretaria)

O painel do Administrador concentra as configurações estruturais do sistema. Todas as ações realizadas por um ADM são registradas com seu nome para fins de rastreabilidade.

O painel apresenta acesso rápido às seguintes seções:

1. Calendário Acadêmico
2. Cursos e Horários
3. Coordenadores
4. Gerenciamento de ADMs
5. Datas Bloqueadas e Cancelamentos

* * *

### 5.1 Calendário Acadêmico

O calendário acadêmico define as datas estruturais de cada semestre letivo. Para cada combinação de **Ano + Semestre do Ano**, o ADM deve registrar:

| Informação                      | Descrição                                                                |
| ------------------------------- | ------------------------------------------------------------------------ |
| **Data de Início do Semestre**  | Data em que o semestre letivo começa.                                    |
| **Data de Fim do Semestre**     | Data em que o semestre letivo termina.                                   |
| **3 Sprints**                   | Cada sprint possui: data de início, data de fim e data da Sprint Review. |
| **Data da Apresentação de TCC** | Data reservada para apresentações de TCC.                                |
| **Data da Feira de Soluções**   | Data reservada para a Feira de Soluções.                                 |
| **Datas Bloqueadas**            | Feriados e demais bloqueios (detalhados na seção 5.2).                   |

> **Dica:** Utilize o calendário visual disponível na tela para navegar e preencher as datas com mais facilidade.

* * *

### 5.2 Datas Bloqueadas e Cancelamentos

#### Datas Bloqueadas (Feriados e Bloqueios Gerais)

Uma **data bloqueada** impede que qualquer curso tenha aula naquele dia. Para cadastrar uma data bloqueada, informe:

* **Data:** o dia a ser bloqueado.
* **Motivo:** descrição do motivo (ex: "Feriado Nacional — Tiradentes").

**Seleção em lote:** É possível clicar em múltiplas datas no calendário visual para selecioná-las de uma vez. Após selecionar todas as datas desejadas, informe um motivo único e clique em **"Bloquear Selecionadas"**. Para remover datas bloqueadas, selecione-as na lista e clique em **"Remover Selecionadas"**.

**Reutilização de feriados recorrentes:** Ao configurar um novo semestre, o sistema apresenta automaticamente as datas bloqueadas do mesmo semestre do ano anterior como sugestão. O ADM pode confirmar, remover ou adicionar novas datas antes de salvar — evitando a necessidade de recadastrar feriados fixos a cada ano.

#### Cancelamento de Dias e Horários

O ADM pode cancelar aulas de forma mais cirúrgica, com as seguintes opções:

| Tipo de Cancelamento                  | Impacto                                             |
| ------------------------------------- | --------------------------------------------------- |
| **Dia inteiro**                       | Nenhum curso tem aula naquele dia.                  |
| **Turno específico (manhã ou noite)** | Apenas os cursos do turno selecionado são afetados. |
| **Horários específicos de um turno**  | Apenas os horários marcados são cancelados.         |

Para cada cancelamento, o campo **Motivo** é obrigatório.

> **Atenção:** Se planejamentos de professores já tiverem sido gerados, o sistema atualizará automaticamente todos os slots afetados com o status **"Cancelado pela Secretaria"**, registrando o nome do ADM responsável e o motivo informado. O professor visualizará essa alteração na próxima vez que acessar o planejamento.

* * *

### 5.3 Cursos

#### Cadastro de Curso

Para cadastrar um novo curso, preencha os seguintes campos:

| Campo                       | Obrigatório | Observações                                                            |
| --------------------------- | ----------- | ---------------------------------------------------------------------- |
| **Nome do Curso**           | Sim         | Deve ser único no sistema.                                             |
| **Turno**                   | Sim         | Manhã ou Noite.                                                        |
| **Quantidade de Semestres** | Sim         | Ex: 6 semestres.                                                       |
| **Coordenador**             | Sim         | Selecionado da lista de coordenadores cadastrados. Apenas 1 por curso. |

**Regras importantes:**

* Dois cursos **não podem ter o mesmo nome**.
* Um coordenador **não pode estar vinculado a mais de um curso** simultaneamente.

#### Gerenciamento de Cursos

A listagem de cursos exibe: Nome, Turno, Quantidade de Semestres e Coordenador. Para cada curso é possível **Editar** ou **Excluir** (uma confirmação será solicitada antes da exclusão).

* * *

### 5.4 Horários dos Cursos

Cada curso possui uma grade de horários de aula para o semestre. O sistema suporta a definição de quantas aulas e intervalos forem necessários, com horário de início e fim para cada um.

**Exemplo de grade noturna:**

| Tipo      | Horário       |
| --------- | ------------- |
| Aula 1    | 18h00 – 18h30 |
| Aula 2    | 18h30 – 19h00 |
| Intervalo | 19h00 – 19h10 |
| Aula 3    | 19h10 – 20h25 |
| Aula 4    | 20h25 – 22h00 |
| Aula 5    | 22h00 – 23h00 |

#### Templates e Propagação Automática

* O sistema possui **templates base** para os turnos da manhã e da noite, configuráveis pelo ADM. Ao cadastrar o horário de um curso, o template do turno correspondente é carregado automaticamente como ponto de partida.
* **Propagação entre cursos:** Após configurar o horário de um curso, envia o template gerado para sobrepor o templete atual, assim todos os outros cursos daquele turno poderão usá-lo. O ADM pode sobrescrever individualmente quando necessário.
* **Herança entre semestres:** Ao iniciar a configuração de horários de um novo semestre letivo, o sistema carrega como base os horários do semestre anterior para cada curso.

* * *

### 5.5 Coordenadores

#### Cadastro de Coordenador

Para cadastrar um coordenador, preencha:

* **Nome**
* **E-mail** (será utilizado como login)
* **Senha** (definida pelo ADM no momento do cadastro)
* **Curso** (obrigatório — apenas cursos sem coordenador vigente aparecem na lista)

#### Gerenciamento de Coordenadores

A listagem exibe: Nome, E-mail e Curso vinculado. É possível **Editar** e **Excluir** coordenadores pela lista.

* * *

### 5.6 Gerenciamento de Administradores

* A listagem exibe todos os ADMs cadastrados: Nome e E-mail.
* É possível adicionar novos ADMs informando Nome, E-mail e Senha.
* É possível **Editar** e **Excluir** ADMs.

> **Restrição:** Um ADM **não pode excluir a própria conta** enquanto estiver logado.

* * *

## 6. Módulo do Coordenador

O painel do Coordenador é focado exclusivamente no **seu curso**. O campo "Curso" no seletor global é bloqueado automaticamente para o curso ao qual o coordenador está vinculado.

O painel apresenta as seguintes seções:

1. Disciplinas
2. Professores
3. Atribuições de Disciplinas
4. Estatísticas e Planejamentos dos Professores

* * *

### 6.1 Disciplinas

#### Cadastro de Disciplina

As disciplinas são cadastradas por **Semestre do Curso** (ex: 1º ao 6º semestre). Para cada disciplina, preencha:

| Campo                    | Descrição                                                       |
| ------------------------ | --------------------------------------------------------------- |
| **Nome**                 | Nome da disciplina (ex: "Álgebra Linear").                      |
| **Carga Horária Mínima** | Quantidade mínima de aulas exigidas no semestre (ex: 80 aulas). |
| **Semestre do Curso**    | A qual semestre do curso a disciplina pertence.                 |

#### Gerenciamento de Disciplinas

A listagem exibe: Nome, Semestre do Curso, Carga Horária Mínima e Professor Atribuído. É possível **Editar** e **Excluir** disciplinas.

> **Atenção sobre exclusão:** Disciplinas excluídas são removidas de forma lógica. Isso significa que elas continuam visíveis em períodos passados que as utilizaram, preservando o histórico acadêmico.

* * *

### 6.2 Professores

#### Cadastro de Professor

Para cadastrar um professor, informe:

* **Nome**
* **E-mail**
* **Senha**

> **Verificação de duplicata:** Antes de salvar, o sistema verifica automaticamente se já existe um usuário (professor ou coordenador) com aquele e-mail e exibe um aviso caso haja duplicidade.

#### O Coordenador como Professor

Um coordenador pode se atribuir como professor de uma ou mais disciplinas do seu curso. Nesse caso, **não é necessário criar um novo cadastro** — o coordenador usa a própria conta, que passa a acumular as permissões de professor. Na tela de atribuição de disciplinas, há uma opção de **"Atribuir a mim mesmo"** para facilitar esse processo.

* * *

### 6.3 Atribuição de Disciplinas a Professores

Nesta seção, o coordenador define qual professor leciona cada disciplina e em quais dias e horários.

**Regras:**

* Cada disciplina pode ter **apenas 1 professor** atribuído por semestre.
* Um professor pode lecionar em **múltiplos cursos**, desde que seus horários não conflitem.

**Para realizar uma atribuição, informe:**

1. **Professor** — selecionado da lista de professores cadastrados.
2. **Disciplina** — selecionada entre as disciplinas do curso.
3. **Dias da semana** — de segunda a sábado.
4. **Horários em cada dia** — ex: na segunda-feira: Aula 1 e Aula 3; na quarta-feira: Aula 2 e Aula 4.

> **Nota:** Os horários podem variar por dia da semana.

#### Validação de Conflito de Horários

O sistema verifica automaticamente se o professor já está alocado naquele dia e horário em outra disciplina ou curso. Em caso de conflito, o sistema exibirá exatamente quais horários estão ocupados e por qual disciplina — impedindo a confirmação da atribuição até que o conflito seja resolvido.

* * *

### 6.4 Estatísticas e Planejamentos dos Professores

O coordenador pode visualizar, dentro do contexto global selecionado:

* **Lista de professores** do curso com suas disciplinas atribuídas.
* **Estatísticas de cada professor** (mesmas informações disponíveis para o próprio professor — detalhadas na seção 7.3).
* **Planejamento gerado** de cada professor (somente leitura).

* * *

## 7. Módulo do Professor

O professor visualiza apenas as disciplinas às quais está atribuído. Se o professor também for coordenador, as funcionalidades de coordenação aparecem em seção separada no painel.

O painel do professor é composto pelas seções:

1. Temas
2. Planejamentos
3. Estatísticas
4. Carga Horária e Rotina (somente leitura)

* * *

### 7.1 Temas

Os **temas** são as unidades de conteúdo que o professor cadastra para cada disciplina. Cada tema corresponde a uma ou mais aulas no planejamento.

#### Cadastro de Tema

Para cada disciplina atribuída no contexto atual, preencha:

| Campo                    | Descrição                                                                                                   |
| ------------------------ | ----------------------------------------------------------------------------------------------------------- |
| **Disciplina**           | Disciplina à qual o tema pertence (selecionada entre as atribuídas ao professor).                           |
| **Nome do Tema**         | Nome descritivo do conteúdo (ex: "Introdução ao Java").                                                     |
| **É Avaliação?**         | Marque se esta aula corresponde a uma prova ou avaliação.                                                   |
| **Qtd. Mínima de Aulas** | Número mínimo de aulas necessárias para cobrir o tema.                                                      |
| **Qtd. Máxima de Aulas** | Número máximo de aulas que o tema pode ocupar.                                                              |
| **Prioridade**           | Ordem de importância em relação aos demais temas (1 = maior prioridade).                                    |
| **É Opcional?**          | Se marcado, o tema só será incluído no planejamento se houver aulas disponíveis após os temas obrigatórios. |
| **Dependências**         | Temas que devem ser ministrados **antes** deste. A ordem das dependências importa.                          |

#### Dependências entre Temas

O campo de **dependências** permite definir pré-requisitos entre temas. Por exemplo: se o Tema C depende de [Tema A, Tema B], isso indica que o Tema A deve ser lecionado antes do Tema B, que deve ser lecionado antes do Tema C.

> **Atenção:** O sistema detecta e alerta automaticamente sobre **dependências circulares** (ex: Tema A depende de B, e B depende de A). Esse tipo de configuração não é permitido.

#### Permissões de Edição

O professor pode editar ou excluir apenas temas do **ano e semestre letivo atuais**. Dados de períodos passados são somente leitura.

* * *

### 7.2 Planejamento de Aulas

#### O que é o Planejamento

O planejamento é gerado **automaticamente pelo sistema** — o professor não distribui as aulas manualmente. Basta garantir que os dados de entrada estejam corretos (temas cadastrados e horários atribuídos pelo coordenador) e o SwiftPlan fará toda a distribuição.

O planejamento é exclusivo para a combinação de: **Ano + Semestre do Ano + Curso + Semestre do Curso + Professor**.

#### Como o Planejamento é Gerado

O sistema utiliza as seguintes informações para montar o planejamento:

* Temas da disciplina (com mínimo/máximo de aulas, prioridade, opcionalidade e dependências).
* Dias e horários em que o professor leciona aquela disciplina.
* Período letivo do semestre (data de início até data de fim).
* Datas bloqueadas e cancelamentos registrados pela Secretaria.

**Lógica de distribuição:**

1. Os temas são ordenados por prioridade, respeitando as dependências.
2. Fins de semana, datas bloqueadas e datas canceladas são excluídos automaticamente.
3. Os temas são distribuídos nos slots disponíveis (de segunda a sexta-feira), respeitando os limites mínimo e máximo de aulas por tema.
4. Se os slots de segunda a sexta não forem suficientes para atingir a carga horária mínima, o sistema utilizará **sábados**, preenchendo-os de forma regressiva (do final do semestre para o início).
5. Temas opcionais só são incluídos se houver slots sobrando após todos os temas obrigatórios serem alocados.

#### Visualizando o Planejamento

O planejamento é exibido como uma **agenda organizada por data**, mostrando os horários e temas alocados para cada dia. Cada entrada exibe:

* **Data e dia da semana**
* **Horário** (ex: Aula 3 — 19h10 às 20h25)
* **Tema** alocado
* **Status** da aula (ícone e cor indicativos)

**Exemplo visual:**
    Segunda, 10/03/2026
      ├─ Aula 1 (18h00 – 18h30) | Tema: Introdução ao Java        | ✅ Ministrada
      ├─ Aula 3 (19h10 – 20h25) | Tema: Variáveis e Tipos         | ⏳ Não Ministrada
      └─ Aula 5 (22h00 – 23h00) | Tema: Estruturas de Controle    | ❌ Cancelada — Professor passou mal

    Quarta, 12/03/2026
      ...

#### Confirmação de Aulas

O sistema funciona com **confirmação automática**: um slot é marcado como **"Ministrada"** automaticamente quando o horário da aula já passou, e como **"Não Ministrada"** caso ainda não tenha ocorrido. O professor pode sobrescrever esse status manualmente quando necessário.

#### Cancelamento de Aulas pelo Professor

Para cancelar uma ou mais aulas:

1. Selecione os horários desejados na lista do planejamento (usando as caixas de seleção em cada linha).
2. Clique em **"Cancelar Selecionados"** na barra de ações.
3. Na janela que se abrirá, informe o **motivo do cancelamento** (campo obrigatório).
4. Confirme. O motivo será aplicado a todos os horários selecionados de uma vez.

#### Cancelamentos pela Secretaria

Quando a Secretaria cancela um horário ou data após o planejamento já ter sido gerado, o sistema atualiza automaticamente os slots impactados com o status **"Cancelado pela Secretaria"**, incluindo o nome do ADM responsável e o motivo.

> **Importante:** Cancelamentos feitos pela Secretaria **não podem ser alterados pelo professor** — apenas visualizados.

* * *

### 7.3 Estatísticas

As estatísticas são exibidas **por disciplina**, vinculadas ao contexto global selecionado. Assim que um planejamento é selecionado, os indicadores são atualizados automaticamente.

| Indicador                           | Descrição                                                                                          |
| ----------------------------------- | -------------------------------------------------------------------------------------------------- |
| **Total de Temas**                  | Quantidade total de temas cadastrados para a disciplina no período.                                |
| **Nomes dos Temas**                 | Listagem expansível com o nome de cada tema.                                                       |
| **Aulas Geradas por Tema**          | Quantas aulas foram alocadas a cada tema no planejamento.                                          |
| **Aulas Não Ministradas**           | Contagem de slots com status "Não Ministrada".                                                     |
| **Aulas Ministradas**               | Contagem de aulas confirmadas.                                                                     |
| **Aulas Canceladas**                | Total de cancelamentos, exibido separadamente por origem (Professor e Secretaria).                 |
| **Avaliações Restantes**            | Quantas avaliações ainda não foram ministradas.                                                    |
| **% de Conclusão da Carga Horária** | `(Aulas Ministradas ÷ Carga Horária Mínima) × 100`                                                 |
| **Sábados Utilizados**              | Indica se o sistema precisou usar sábados e quantos foram alocados.                                |
| **Temas Opcionais Incluídos**       | Lista de temas opcionais que entraram no planejamento.                                             |
| **Projeção de Conclusão**           | Estimativa — com base no ritmo atual — de se a carga horária será concluída até o fim do semestre. |

> **Nota:** As estatísticas não são editadas diretamente. Elas são calculadas automaticamente a partir dos dados do planejamento: alterar o status de uma aula ou adicionar/remover temas atualiza os indicadores em tempo real.

* * *

### 7.4 Carga Horária e Rotina

Esta seção apresenta, para cada disciplina no contexto selecionado, as informações de rotina do professor em modo **somente leitura**:

* **Dias da semana e horários** em que leciona.
* **Carga horária mínima** configurada pelo coordenador.
* **Total de aulas geradas** no planejamento.

* * *

## 8. Fluxos Principais de Uso

A seguir, os fluxos recomendados para cada perfil no início de um novo semestre letivo.

* * *

### Fluxo 1 — ADM configura o semestre

    1. Login com perfil de Administrador
    2. Selecionar Ano e Semestre no seletor global
    3. Preencher as datas letivas (início, fim, TCC, Feira de Soluções)
    4. Cadastrar as 3 Sprints do semestre
    5. Revisar e confirmar as datas bloqueadas (feriados do semestre anterior são sugeridos automaticamente)
    6. Configurar os horários dos cursos (templates são carregados automaticamente por turno)
    7. Semestre disponível para uso pelos demais perfis

* * *

### Fluxo 2 — Coordenador prepara as disciplinas

    1. Login com perfil de Coordenador
    2. Selecionar o contexto (Ano, Semestre do Ano, Semestre do Curso)
    3. Cadastrar as disciplinas por semestre do curso
    4. Cadastrar os professores (o sistema verifica duplicatas automaticamente)
    5. Atribuir disciplinas aos professores, definindo dias e horários de cada um
    6. Verificar se há conflitos de horário (o sistema aponta automaticamente)

* * *

### Fluxo 3 — Professor planeja e acompanha as aulas

    1. Login com perfil de Professor
    2. Selecionar o contexto (Ano, Semestre do Ano, Curso, Semestre do Curso)
    3. Cadastrar os temas da disciplina (com dependências, prioridades e flags de avaliação/opcional)
    4. O sistema gera o planejamento automaticamente com base nos temas e horários
    5. Acompanhar o planejamento ao longo do semestre (confirmar ou cancelar aulas conforme necessário)
    6. Monitorar o progresso nas Estatísticas em tempo real

* * *

### Fluxo 4 — ADM cancela horários após planejamentos gerados

    1. ADM acessa a seção "Datas Bloqueadas e Cancelamentos"
    2. Seleciona a data e os horários específicos a cancelar
    3. Informa o motivo (obrigatório)
    4. O sistema atualiza automaticamente todos os planejamentos impactados
    5. Os professores visualizam os slots com status "Cancelado pela Secretaria" na próxima abertura do planejamento

* * *

*Manual do Usuário — SwiftPlan | Versão 1.0*
