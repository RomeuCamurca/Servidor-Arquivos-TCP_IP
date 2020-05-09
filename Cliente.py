import sys
import socket

HOST = sys.argv[1]
PORT = int(sys.argv[2])

tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
dest = (HOST, PORT)
tcp.connect(dest)

ope = sys.argv[3]

if ope == "list":
        tcp.send(ope)
        recebe = tcp.recv(1024)
        print recebe

elif ope == "rm":
        arqr = sys.argv[4]
        tcp.send(ope + ":" + arqr)
        recebe = tcp.recv(1024)
        print recebe

elif ope == "get":
        arqr = sys.argv[4] #arquivo remoto
        arql = sys.argv[5] #arquivo local
        tcp.send(ope + ":" + arqr)
        novo_arq = open(arql, 'w')
        print "Recuperando arquivo " + arqr
        while 1:
                recebe = tcp.recv(1024)
                if not recebe:
                        break
                novo_arq.write(recebe) 
        novo_arq.close()
        print arqr + " salvo em: "+ arql


elif ope == "put":
        arql = sys.argv[4] #arquivo local
        arqr = sys.argv[5] #arquivo remoto
        tcp.send(ope + ":" + arql + ":" + arqr)
        rec=tcp.recv(1024)
        if rec == 'ok':
                print "enviando arquivo: " + arql
                arquivo = open(arql,'r')
                for linha in arquivo:
                        tcp.send(linha)
                arquivo.close()
        print "Envio completo. Salvo no servidor como "+ arqr

tcp.close()
