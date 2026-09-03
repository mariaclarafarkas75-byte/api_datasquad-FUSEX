# 📘 Manual de Instalação — SwiftPlan

> Siga cada etapa na ordem indicada. Este manual foi escrito para computadores com **Windows** recém-formatado.

---

## Sumário

1. [Instalar o Java](#1-instalar-o-java)
2. [Instalar o MySQL](#2-instalar-o-mysql)
3. [Criar o banco de dados](#3-criar-o-banco-de-dados)
4. [Configurar o arquivo db.properties](#4-configurar-o-arquivo-dbproperties)
5. [Executar o sistema](#5-executar-o-sistema)
6. [Solução de problemas](#6-solução-de-problemas)

---

## 1. Instalar o Java

O sistema requer o **Java 25 ou superior**.

### 1.1 Baixar o instalador

Acesse: [https://www.oracle.com/java/technologies/downloads/#java25](https://www.oracle.com/java/technologies/javase/jdk25-archive-downloads.html)

Vá para seção **Java SE Development Kit 25.0.2** → selecione Windows x64 Installer e clique no link

### 1.2 Instalar

1. Execute o arquivo baixado com duplo clique
2. Clique em **Next** em todas as telas
3. Clique em **Close** ao finalizar

### 1.3 Verificar a instalação

1. Pressione `Windows + R`, digite `cmd` e pressione `Enter`
2. No terminal que abrir, digite:

```
java --version
```

O resultado esperado é algo como:

```
java version "25.0.2"
```

Se aparecer esse resultado, o Java está instalado corretamente. Caso contrário, reinicie o computador e tente novamente.

---

## 2. Instalar o MySQL

### 2.1 Baixar o instalador

Acesse: https://dev.mysql.com/downloads/installer/

Clique no botão **Download** do arquivo maior (ex: `mysql-installer-community-8.0.xx.msi`).

Na próxima tela clique em **No thanks, just start my download**.

### 2.2 Instalar

1. Execute o arquivo `.msi` baixado com duplo clique
2. Se aparecer uma tela do **UAC** (Controle de Conta de Usuário), clique em **Sim**
3. Na tela **Choosing a Setup Type**, selecione **Developer Default** e clique em **Next**
4. Clique em **Next** e depois em **Execute** — aguarde o download e instalação dos componentes
5. Clique em **Next** até chegar na tela **Accounts and Roles**

### 2.3 Definir a senha do root

Na tela **Accounts and Roles**:

- Em **MySQL Root Password**, digite uma senha forte e **anote ela** — você precisará dela depois
- Em **Repeat Password**, repita a senha
- Clique em **Next**

> ⚠️ **Não esqueça essa senha.** Ela será usada para configurar o sistema.

### 2.4 Finalizar a instalação

1. Continue clicando em **Next** nas telas seguintes
2. Clique em **Execute** quando solicitado para aplicar as configurações
3. Clique em **Finish** ao finalizar

### 2.5 Verificar a instalação

1. Pressione `Windows + R`, digite `cmd` e pressione `Enter`
2. Digite:

```
mysql -u root -p
```

3. Digite a senha definida no passo 2.3 e pressione `Enter`
4. Se aparecer `mysql>`, o MySQL está funcionando corretamente
5. Digite `exit` e pressione `Enter` para sair

---

## 3. Criar o banco de dados

### 3.1 Abrir o MySQL Workbench

1. Pesquise **MySQL Workbench** no menu Iniciar e abra
2. Clique em **Local instance MySQL80** (ou similar)
3. Digite a senha do root definida anteriormente e clique em **OK**

### 3.2 Criar o banco

1. No menu superior, clique em **File** → **New Query Tab**

2. Cole todo o texto disponibilizado em [Banco de dados](/docs/banco-dados/schema_swiftplanv2.3.sql):

3. Clique no botão **⚡ (Execute)** ou pressione `Ctrl + Enter`

4. Na parte inferior deve aparecer uma mensagem de sucesso

---

## 4. Configurar o arquivo db.properties

Dentro da pasta que você baixou e descompactou, há um arquivo chamado `db.properties`. Abra-o com o **Bloco de Notas**:

1. Clique com o botão direito sobre o arquivo
2. Selecione **Abrir com** → **Bloco de Notas**

O conteúdo do arquivo é:

```properties
db.url=jdbc:mysql://localhost:3306/
db.name=swiftplan
db.user=root
db.password=SUA_SENHA_AQUI
```

Substitua `SUA_SENHA_AQUI` pela senha que você definiu no passo 2.3. Exemplo:

```properties
db.name = swiftplan
db.user = root
db.url = jdbc:mysql://localhost:3306/
db.password = minhasenha123
```

Salve o arquivo com `Ctrl + S` e feche o Bloco de Notas.

> ⚠️ O arquivo `db.properties` deve sempre ficar na **mesma pasta** que o arquivo `.jar`.

---

## 5. Executar o sistema

### Estrutura esperada da pasta

Antes de executar, confirme que sua pasta está assim:

```
swiftplan/
├── swiftplan-v1.0.jar
├── db.properties
└── rodar.bat
```

### Executar com duplo clique

Dê **duplo clique** no arquivo `rodar.bat`.

Uma janela preta abrirá brevemente e em seguida o sistema será iniciado.

### Executar pelo terminal (alternativo)

1. Abra a pasta do sistema no **Explorador de Arquivos**
2. Clique na barra de endereço do explorador, digite `cmd` e pressione `Enter`
3. No terminal, digite:

```
java -jar demo3-v1.0.jar
```

---

## 6. Solução de problemas

### "java não é reconhecido como um comando"

O Java não foi instalado corretamente ou o computador não foi reiniciado após a instalação. Reinicie o computador e tente novamente. Se o problema persistir, repita o [passo 1](#1-instalar-o-java).

### "Erro ao conectar ao banco"

Verifique os seguintes pontos:

- O serviço do MySQL está rodando: pressione `Windows + R`, digite `services.msc`, procure por **MySQL80** e confirme que o status é **Em execução**
- A senha no `db.properties` está correta
- O nome do banco no `db.properties` é exatamente `swiftplan`
- O arquivo `db.properties` está na mesma pasta que o `.jar`

### A tela não abre mas o terminal fecha rápido

Execute pelo terminal (passo 5, opção alternativa) para ver a mensagem de erro completa antes de a janela fechar.

### "Access denied for user root"

A senha no `db.properties` está incorreta. Revise o [passo 4](#4-configurar-o-arquivo-dbproperties).

---

> Em caso de dúvidas, abra uma **Issue** no repositório do projeto.
