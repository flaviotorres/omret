#!/usr/bin/env bash
# Arquivo original em: https://www.ime.usp.br/~pf/dicios/br-sem-acentos.txt 
# ... to deixando no git pra evitar downloads na usp e de repente bloquearem 
DICIONARIO="https://github.com/flaviotorres/omret/blob/main/br-sem-acentos.txt?raw=true"
FILE=br-sem-acentos-5-letras.txt

# testo se o arquivo existe pela primeira vez, eu poderia baixar o arquivo com 5 palavras diretamente mas como a ideia e' se divertir, deixo a regex aqui:

if test -f "$FILE"; then
	echo -n ""
	# arquivo existe
else
	echo "arquivo $FILE nao existe, baixando do github..."
	wget $DICIONARIO -O /tmp/br-sem-acentos.txt
	egrep -i "^[^a-z]*[a-z]{5}[^a-z]*$" /tmp/br-sem-acentos.txt > ${FILE}
fi 


# palavras pra tirar (use regex) 
TIRAR=$1
# palavras pra considerar (sim, use regex aqui)
CONSIDERAR=$2

# exemplo: palavras.sh "i|t|e|o|n|u|l|c|m|h|p" ".ar.a$" 
# no exemplo acima, ele remove as letras "i OU t OU e OU ..." e considera na sequencia ".ar.a$" -- mais sobre regex: https://aurelio.net/regex/ 
egrep -v $TIRAR ${FILE} | egrep $CONSIDERAR
