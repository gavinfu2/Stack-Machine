%{
   #include "stackMachine.tab.h"
   void yyerror(const char *);
%}
%%
[0-9]+ {
   yylval.ival = atoi(yytext);
   return NUMBER;
}
"add" {return ADD;}
"sub" {return SUB;}
"mul" {return MUL;}
"mod" {return MOD;}
"inc" {return INC;}
"dec" {return DEC;}
"load" {return LOAD;}
\n {return yytext[0];}
[ \t]+ {;}
. {yyerror("invalid input");}
%%