# Trabalho-FINAL-TCP_IP
<h2> Trabalho de Programação </h2>

<h2> Objetivo </h2>
Desenvolver um servidor de arquivos e o cliente correspondente, usando o protocolo TCP.

<h2> Requisitos </h2>

* Feito em Python

* Executa no Ubuntu Linux

* O servidor suporta a transferência simultânea de arquivos de mais de um cliente.

<h2> Descrição do funcionamento do servidor </h2>
<h3> Operações Suportadas </h3>
O servidor deve ser executado na pasta que será disponibilizada pela rede. O cliente poderá então enviar comandos para:

* Listar o diretório (list): nenhum argumento, apenas retorna a lista de arquivos do servidor.

* Inserir arquivo (put): o cliente enviará um arquivo que deve ser salvo no servidor. Além do conteúdo 
do arquivo, o cliente precisa informar o nome que o arquivo terá na pasta do servidor, que pode ser diferente 
do nome que o arquivo tinha na máquina do cliente.

* Recuperar arquivo (get): o cliente requisitará um arquivo para o servidor.

* Remover arquivo (rm): o cliente informará um arquivo para ser removido da pasta do servidor.

<h2> Exemplo de execução do Servidor </h2>
Considere um sistema Linux. Os comandos abaixo indicam como o servidor deve ser executado. Estou supondo um servidor
em Python.

`usuario@servidor:~$ cd pastacompartilhada`

`usuario@servidor:~/pastacompartilhada$ ls`

`servidor.py arquivo01.txt arquivo02.txt arquivo03.txt`

`usuario@servidor:~/pastacompartilhada$ ./servidor.py 33000`

`Servidor FTP executando.`

A partir desse momento, o servidor estará aceitando conexões na porta 33000 e os arquivos da pasta compartilhada
estarão disponíveis para o cliente.

<h2> Descrição do funcionamento do cliente </h2>
O cliente deve suportar as operações do servidor. O usuário irá informar qual opção deseja executar através
de parâmetros na linha de comando, além de informar o IP e a Porta:

`./cliente.py <IP> <PORTA> list`
  listar os arquivos do servidor.
  
`./cliente.py <IP> <PORTA> get <ARQUIVOREMOTO> <ARQUIVOLOCAL>` 
  copia <ARQUIVOREMOTO> do servidor para o arquivo <ARQUIVOLOCAL>.
  
`./cliente.py <IP> <PORTA> put <ARQUIVOLOCAL> <ARQUIVOREMOTO>` 
  copia <ARQUIVOLOCAL> para <ARQUIVOREMOTO> no servidor.
  
`./cliente.py <IP> <PORTA> rm <ARQUIVOREMOTO>` 
  remove <ARQUIVOREMOTO> do servidor.

<h2> Exemplo de execução do Cliente </h2>
Considere um sistema Linux. Os comandos abaixo indicam como o cliente interaje com o
servidor, supondo que o servidor foi iniciado como no exemplo anterior. Considere que o
servidor tem IP 10.0.0.2.

`usuario@cliente:~$ ls`

`cliente.py ubuntu.iso`

`usuario@cliente:~$ ./cliente.py 10.0.0.2 33000 list`

`Arquivos remotos: servidor.py arquivo01.txt arquivo02.txt arquivo03.txt`

`usuario@cliente:~$ ./cliente.py 10.0.0.2 33000 put ubuntu.iso ubuntuserver.iso`

`Enviando arquivo: ubuntu.iso`

`Envio completo. Salvo no servidor como ubuntu-server.iso.`

`usuario@cliente:~$ ./cliente.py 10.0.0.2 33000 list`

`Arquivos remotos: servidor.py arquivo01.txt arquivo02.txt arquivo03.txt ubuntu.iso`

`usuario@cliente:~$ ./cliente.py 10.0.0.2 33000 get arquivo01.txt teste.txt`

`Recuperando arquivo: arquivo01.txt`

`arquivo01.txt salvo em teste.txt`

`usuario@cliente:~$ ls`

`cliente.py ubuntu.iso teste.txt`

`usuario@cliente:~$ ./cliente.py 10.0.0.2 33000 rm ubuntu-server.iso`

`Removendo arquivo ubuntu-server.iso do servidor.`

`usuario@cliente:~$ ./cliente.py 10.0.0.2 33000 list`

`Arquivos remotos: servidor.py arquivo01.txt arquivo02.txt arquivo03.txt`

