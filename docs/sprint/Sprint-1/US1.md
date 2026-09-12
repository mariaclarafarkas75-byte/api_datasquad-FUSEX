# Anexação do encaminhamento médico digitalizado
## Resumo
Como beneficiário, quero anexar o encaminhamento médico digitalizado ao meu cadastro, para que ele sirva de base na criação da pré-guia.
## Sobre o encaminhamento médico:
O encaminhamento médico é o documento emitido pelo médico e entregue ao beneficiário, servindo de base obrigatória para a criação da pré-guia. Dentro do sistema, ele deve ser armazenado digitalmente e conter os seguintes valores:
- O arquivo digitalizado (PDF ou imagem)
- A data de envio/upload
- O beneficiário ao qual está vinculado
- O status de vínculo (se já foi utilizado em alguma pré-guia ou não)
## Detalhamento do processo:
1. O beneficiário loga no sistema.
2. O beneficiário acessa a área de cadastro/encaminhamento.
3. O beneficiário faz upload do arquivo digitalizado, através de uma requisição REST.
4. O sistema valida o formato e tamanho do arquivo.
5. O sistema salva o encaminhamento no banco, vinculando-o ao beneficiário logado.
## Critérios de aceitação:
- Certifique-se que o beneficiário consegue anexar um arquivo válido e legível.
- Certifique-se que o sistema rejeita arquivos fora do formato/tamanho permitido.

