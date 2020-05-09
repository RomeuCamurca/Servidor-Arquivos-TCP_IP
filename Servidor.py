import socket
import thread
import sys
import os
import commands
import subprocess

HOST = ''                          # Endereco IP do Servidor
PORT = int(sys.argv[1])            # Porta que o Servidor esta

def conectado(con, cliente):
    while True:
        ope = con.recv(4096)
        var =ope.split(':')
        ope= var[0] #Pegando a operacao

        if ope == "list":
                ope = subprocess.check_output(["ls"])
                con.send('Arquivos remotos: ' + '\n' + ope)

        elif ope == "rm":
                arqr = var[1] #pegando o arquivo remoto
                os.remove(arqr)
                con.send('Removendo arquivo ' + arqr + ' do servidor.')


        elif ope =="get":
                arqr = var[1] #pegando o segundo elemento passado, "arquivo remoto"
                arquivo = open(arqr,'r')
                for linha in arquivo:
                        con.send(linha)
                arquivo.close()

        elif ope =="put":
                arqr = var[2] #pegando o terceiro elemento passado, "arquivo remoto"
                novo_arq = open(arqr,'w')
                con.send('ok')
                while 1:
                        recebe = con.recv(4096)
                        if not recebe:
                                break
                        novo_arq.write(recebe)
                novo_arq.close()

        con.close()
        thread.exit()

tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
orig = (HOST, PORT)
tcp.bind(orig) 
tcp.listen(1)


print 'Servidor FTP executando.'

while True:
         con, cliente = tcp.accept()
         thread.start_new_thread(conectado, tuple([con, cliente]))

tcp.close()
