📋 Especificação Técnica do Sistema FUSEX

* * *

1. Visão Geral

* * *

**Nome sugerido do sistema:** Nexus

**Stack obrigatória:**

* Linguagem: Java (versão 17+ recomendada)
* Java Spring Boot
* Banco de dados: MySQL

**Objetivo:** Facilitar o fluxo de trabalho do FUSEX, eliminando burocracias repetitivas e probabilidade de erros humanos durante o processo (dupla cobrança de guias, assinaturas ausentes ou faltantes, erros de lisuras, etc). Também será necessário automatizar o processo de rastreabilidade (lisuras e glosas).

* * *

2. Princípio de UX Central

* * *

> **O sistema deve minimizar ao máximo o número de cliques e interações necessárias.** Sempre que possível, use preenchimento automático, herança de dados de períodos anteriores, propagação de configurações entre entidades similares e confirmação em lote.

**Responsividade:** interface adaptável para celular (beneficiários) e desktop (funcionários do FUSEX).

**Feedback:** toda ação que dispara requisição deve indicar loading, sucesso ou erro de forma clara.

**Formulários:** validação no front-end antes do envio; pré-preenchimento de dados já conhecidos do usuário.

**Ações críticas:** operações irreversíveis (ex: protocolar o Mapa) exigem confirmação explícita, mesmo custando um clique extra.

* * *

3. Contexto de Domínio — Glossário Obrigatório

* * *

Antes de iniciar o desenvolvimento da aplicação, o desenvolvedor deve internalizar os seguintes conceitos, pois eles se repetem em todo o sistema:

| Termo | Definição |
| ------------------------------ |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **FUSEX**                      | Sigla para **Fundo de Saúde do Exército**, um sistema de assistência médico-hospitalar destinado aos **beneficiários** do exército |
| **Beneficiário**               | São os militares do Exército (da ativa, reserva ou reformados) e a pensionistas, que atuam como titulares. O direito se estende aos seus dependentes diretos legalmente cadastrados, como cônjuges e filhos menores ou estudantes. |
| **Encaminhamento médico**      | Documento criado pelo médico e entregue posteriormente ao beneficiário, **essencial** para a criação da Pré-Guia. |
| **Pré-Guia de Encaminhamento** | Documento criado (já dentro da aplicação) pelo beneficiário, constando a **OCS** e os procedimentos/exames médicos a serem realizados. **Necessário ter o encaminhamento médico para criá-la.**                                   |
| **Guia de Encaminhamento**     | Documento gerado pelo FUSEX, contendo: a **OCS** escolhida, os procedimentos, número, assinatura do médico e do chefe do FUSEX, etc. **Necessário ter a Pré-Guia aprovada pelo FUSEX para ser gerado.**                           |
| **OCS**                        | Representa toda a **rede credenciada, conveniada ou contratada de caráter privado ou público** (que não pertence ao Exército) utilizada para prestar assistência médica aos beneficiários do FUSEX. |
| **Espelho**                    | Documento gerado pela OCS após a realização do(s) exame(s) do beneficiário, constando todos os gastos referentes ao(s) exame(s). **Cada guia possui um espelho**. |
| **Fatura**                     | Documento gerado pela OCS dentro de um período (geralmente de 1 mês). É a somatória de todas as guias que já foram utilizadas e que a OCS devolveu ao FUSEX (ou seja: guias que já possuem **espelho**). |
| **Lisura**                     | Procedimento que faz parte da **rastreabilidade**, para conferir se todos os valores estão em conformidade. **Não há como realizar a lisura de uma guia sem possuir o espelho**. |
| **Glosa**                      | Procedimento que faz parte da lisura, caso seja encontrado **divergências** de valores entre o **espelho** e os valores descritos no **contrato** firmado entre a OCS e o FUSEX. |
| **Mapa**                       | É a auditoria final de todas as guias, feito após o processo de lisura/glosa dentro do FUSEX. É o último processo antes da **liquidação**. |
| **Liquidação**                 | Processo final, onde o exército realiza o pagamento da fatura. |

* * *

4. Regras de Negócio

* * *

### 4.1 Encaminhamento e Pré-Guia

| Código | Regra | Observação |
|--------|-------|------------|
| RN01 | Não é possível criar uma Pré-Guia sem um Encaminhamento médico válido vinculado ao beneficiário. | Validação obrigatória antes da criação da Pré-Guia. |
| RN02 | O Encaminhamento é aceito de qualquer médico credenciado ao FUSEX, não sendo necessário ser de uma OCS específica. | Não restringir o cadastro do Encaminhamento a uma OCS pré-definida. |
| RN03 | A Pré-Guia deve conter obrigatoriamente a OCS escolhida e ao menos um procedimento/exame. | Bloquear envio da Pré-Guia se algum desses campos estiver vazio. |

### 4.2 Guia

| Código | Regra | Observação |
|--------|-------|------------|
| RN04 | A Guia só pode ser gerada a partir de uma Pré-Guia aprovada pelo FUSEX. | Nunca permitir geração direta de Guia sem Pré-Guia aprovada. |
| RN05 | A Guia possui validade de 60 dias a partir da emissão. | Sistema deve calcular e sinalizar a expiração automaticamente. |
| RN06 | A Guia deve conter a assinatura digital do beneficiário antes da realização do procedimento na OCS. | Assinatura é pré-requisito para a Guia ser considerada utilizável. |

### 4.3 Espelho e Fatura

| Código | Regra | Observação |
|--------|-------|------------|
| RN07 | Toda Guia utilizada deve gerar exatamente um Espelho correspondente. | Relação 1:1 entre Guia e Espelho. |
| RN08 | O Espelho só pode ser criado após a efetiva utilização da Guia pelo beneficiário na OCS. | Bloquear criação do Espelho para Guias ainda não utilizadas. |
| RN09 | A Fatura é a somatória de todas as Guias com Espelho recebidas dentro de um mesmo período (geralmente mensal). | Período configurável, mas mensal por padrão. |
| RN10 | O Espelho deve ser recebido em formato padronizado, para permitir leitura e comparação automatizada. | Pré-requisito técnico para as regras de Lisura (seção 4.4). |

### 4.4 Lisura e Glosa

| Código | Regra | Observação |
|--------|-------|------------|
| RN11 | Não é possível realizar a lisura de uma Guia sem o Espelho correspondente. | Depende diretamente de RN07 e RN08. |
| RN12 | A lisura deve comparar automaticamente o valor da Guia com o valor do Espelho, e o valor do Espelho com o valor do contrato firmado com a OCS. | Processo automatizado, sem intervenção manual nesta etapa. |
| RN13 | Caso haja divergência entre o valor do Espelho e o valor do contrato, deve ser gerada uma Glosa, corrigindo a diferença. | Glosa é consequência direta de uma divergência identificada em RN12. |
| RN14 | O funcionário do FUSEX pode intervir manualmente no resultado da lisura/glosa antes da conclusão do processo (revisão final, pré-mapa). | Última oportunidade de correção antes do protocolo do Mapa (RN15). |

### 4.5 Mapa e Liquidação

| Código | Regra | Observação |
|--------|-------|------------|
| RN15 | Após o protocolo do Mapa (auditoria final), os valores da lisura não podem mais ser alterados. | Regra de bloqueio definitivo — validar no backend, não apenas na interface. |
| RN16 | A Liquidação (pagamento da fatura) só pode ocorrer após o protocolo do Mapa. | Garante que nenhuma fatura seja paga antes da auditoria final. |