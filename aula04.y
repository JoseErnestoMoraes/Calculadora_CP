%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>

    float var[26];

    int yylex();
    void yyerror (char *s){
    printf("%s\n", s);
}

%}
%union {
    float real;
    int inter;
}

%token <real>NUM_INT
%token <inter>VARIAVEL

%token FINAL
%token INICIO

%token ESCRITA
%token LEITURA

%token SQRT

%left '+' '-'
%left '*' '/'
%right '^'
%left ')'
%right '('

%type <real>exp
%type <real>valor

%%

prog: INICIO cod FINAL 
    ;

cod: cod cmdos
    |
    ;

cmdos: ESCRITA '(' exp ')'{
        printf ("%.2f\n",$3);
    }
    | LEITURA '(' VARIAVEL ')' {
        scanf("%f",&var[$3]);
    }
    | VARIAVEL '=' exp {
       var[$1] = $3;
    }
    ;

exp: exp '+' exp {
    $$ = $1 + $3;
    //printf ("%.2f + %.2f = %.2f\n",$1,$3,$$);
    }
    | exp '-' exp {
        $$ = $1 - $3;
        //printf ("%.2f - %.2f = %.2f\n",$1,$3,$$);
        }
    | exp '*' exp {
        $$ = $1 * $3;
        //printf ("%.2f * %.2f = %.2f\n",$1,$3,$$);
        }
    | exp '/' exp {
        $$ = $1 / $3;
        //printf ("%.2f / %.2f = %.2f\n", $1, $3, $$);
    }
    | exp '^' exp {
        $$ = pow($1, $3);
        //printf ("%.2f ^ %.2f = %.2f\n", $1, $3, $$);
    }
    | SQRT '(' exp ')' {
        $$ = sqrt($3);
        //printf ("raiz quadrada de %.2f = %.2f\n", $3, $$);
    }
    | '(' exp ')' {
        $$ = $2;
    }
    | valor {
        $$ = $1;
    }
    | VARIAVEL {
        $$ = var[$1];
    }
    ;

valor: NUM_INT {
    $$ = $1;
    }
;
%%

#include "lex.yy.c"
int main(){
    yyin=fopen("meu_cod.d","r");
    yyparse();
    yylex();
    fclose(yyin);
return 0;
}