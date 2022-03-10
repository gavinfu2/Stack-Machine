%{
   #include <stdio.h> 
   #include <stdlib.h>

   int sindex=0;
   int yylex(void); 
   int stack[20];      
   void yyerror(const char *);
   
%}

%union{
   int ival;
}
%token <ival> NUMBER
%type <ival> expr
%left '+'
%token ADD
%token SUB
%token MUL
%token MOD
%token INC
%token DEC
%token LOAD
%%

program : lines{
   if (sindex != 1){
      printf("Invalid format\n");
      exit(0);
   }
   else
      printf("%d\n",stack[0]); 
}

lines : lines line {;}
        |line      {;}
;

line    : expr '\n'{;}
        | expr     {;}
        | '\n'     {;}
;
expr : LOAD NUMBER{
   stack[sindex]=$2;
   sindex++;
   int i;
}
        | ADD{
   if (sindex < 2) {
      printf("Invalid format\n");
      exit(0);
   }
   else {
      int a = stack[sindex-1];
      stack[sindex-1]=0;
      sindex--;
      int b = stack[sindex-1];
      stack[sindex-1]=(a+b);
   }
}
        | SUB           {
   if (sindex < 2) {
      printf("Invalid format\n");
      exit(0);
   }
   else {
      int a = stack[sindex-1];
      stack[sindex-1]=0;
      sindex--;
      int b = stack[sindex-1];
      stack[sindex-1]=(a - b);
   }
}
        | MUL           {
   if (sindex < 2) {
      printf("Invalid format\n");
      exit(0);
   }
   else {
      int a = stack[sindex-1];
      stack[sindex-1]=0;
      sindex--;
      int b = stack[sindex-1];
      stack[sindex-1]=(a * b);
   }
}
        | MOD           {
   if (sindex < 2) {
      printf("Invalid format\n");
      exit(0);
   }
   else {
      int a = stack[sindex-1];
      stack[sindex-1]=0;
      sindex--;
      int b = stack[sindex-1];
      stack[sindex-1]=(a % b);    
   }
}
        | INC           {
   if (sindex < 1) {
      printf("Invalid format\n");
      exit(0);
   }
   else {
      int a = stack[sindex-1];
      stack[sindex-1]=a+1;     
   }
}
        | DEC           {
   if (sindex < 1) {
      printf("Invalid format\n");
      exit(0);
   }
   else {
      int a = stack[sindex-1];
      stack[sindex-1]=a-1;
      
   }
}
        ;

%%

void yyerror(const char *message) {
   printf("Invalid format\n");
   exit(0);
}

int main(void) {
   yyparse();
   return 0;
}


/*
%{
    #include <iostream>
    #include <stack>
    using namespace std;

    int yylex(void);
    void yyerror(const char *);

    stack<int> s;
%}
%code provides {}

%union{
    int ival;
}
%token <ival> INTEGER
%token ADD
%token SUB
%token MUL
%token MOD
%token INC
%token DEC
%token LOAD
%type <ival> expr

%%
program : lines         {
                            if (s.size() != 1) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else
                                cout << s.top() << std::endl;
                        }
lines   : lines line    {;}
        | line          {;}
        ;
line    : expr '\n'     {;}
        | expr          {;}
        | '\n'          {;}
        ;

expr    : LOAD INTEGER  {s.push($2);}
        | ADD           {
                            if (s.size() < 2) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop;
                                s.push(a + b);
                            }
                        }
        | SUB           {
                            if (s.size() < 2) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a - b);
                            }
                        }
        | MUL           {
                            if (s.size() < 2) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a * b);
                            }
                        }
        | MOD           {
                            if (s.size() < 2) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a % b);
                            }
                        }
        | INC           {
                            if (s.size() < 1) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                s.push(++a);
                            }
                        }
        | DEC           {
                            if (s.size() < 1) {
                                cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                s.push(--a);
                            }
                        }
        ;

%%

void yyerror(const char *message) {
    cout << "Invalid format" << std::endl;
}

int main(void) {
    yyparse();
    return 0;
}
*/
