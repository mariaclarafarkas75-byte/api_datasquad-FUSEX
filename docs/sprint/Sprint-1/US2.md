# Criação digital da pré-guia
## Resumo
Como beneficiário, quero criar a pré-guia de forma digital informando a OCS e os procedimentos/exames a serem realizados, para que eu não precise ir pessoalmente ao FUSEX com o encaminhamento em mãos.
## Sobre a pré-guia:
A pré-guia é o documento criado pelo beneficiário dentro do sistema, com base em um encaminhamento médico já anexado, e que dará origem à Guia após aprovação do FUSEX. Ela contém os seguintes valores:
- A OCS escolhida
- Os procedimentos/exames a serem realizados
- O status da pré-guia (ex: Pendente, Em análise, Aprovada, Reprovada)
- A data de criação
- O encaminhamento médico ao qual está vinculada
- O beneficiário ao qual está vinculada
## Detalhamento do processo:
1. O beneficiário loga no sistema.
2. O sistema verifica se há um encaminhamento médico válido vinculado ao beneficiário, através de uma consulta REST.
3. O beneficiário seleciona a OCS entre as opções credenciadas disponíveis no sistema.
4. O beneficiário informa um ou mais procedimentos/exames a serem realizados.
5. O sistema salva a pré-guia no banco com status "Pendente", vinculada ao beneficiário e ao encaminhamento correspondente, através de uma requisição REST.
## Critérios de aceitação:
- Certifique-se que não seja possível criar uma pré-guia sem um encaminhamento médico válido vinculado ao beneficiário.
- Certifique-se que pré-guia exiga a seleção de uma OCS credenciada dentre as disponíveis no sistema.
- Certifique-se que a pré-guia exiga ao menos um procedimento/exame informado antes de ser enviada.
- Certifique-se que a pré-guia criada fique vinculada ao beneficiário logado e ao encaminhamento correspondente.
