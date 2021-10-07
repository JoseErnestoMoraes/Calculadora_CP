%{
#include <stdio.h>
#include <stdlib.h>  
%}

FINAL "$fim"
INICIO "$inicio"

ESCRITA "printar"
LEITURA "escanear"

IGNORE [\ \n\t]
INVALIDO .

NUM_FLOAT [0-­9]+\.?[0-9]*
NUM_INT [0-­9]+

ALFABETO [a-zA-Z]+
VARIAVEL {ALFABETO}("_"|{NUM_INT}|{ALFABETO})*

SQRT "RAIZ"

%%
    
[-+()=/*^] {
    return *yytext;
}

{FINAL} {
    return FINAL;
}

{INICIO} {
    return INICIO;
}

{ESCRITA} {
    return ESCRITA;
}

{LEITURA} {
    return LEITURA;
}

{SQRT} {
    return SQRT;
}

{VARIAVEL} {
    yylval.inter = *yytext - 'a';
    return VARIAVEL;
}

{NUM_INT} {
    yylval.real = atof(yytext);
    return NUM_INT;
}

{IGNORE} {
	;
}
{INVALIDO} {
	;
}

[\ \n\t]* {;}

%%