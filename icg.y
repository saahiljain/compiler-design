%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	void yyerror(const char *);
	#define YYSTYPE char*
	FILE *yyin;
	char out[1000];
	int ln = 1, tn = 1;
	char* newLabel();
	char* newTemp();
	char* newLabel100();

%}
%error-verbose
%token T_IF T_ID T_ELSE T_NUM T_WHILE T_MAIN
%%
S1: Main;

S:
	Assig S
	|If S
	|While S
	|
	;			

Assig:
	T_ID '=' E 	';'	{printf("%s = %s\n",$1,$3);}
	;

If:
	T_IF '(' {printf("if ");} C {printf(" go to "); $3 = (char*)malloc(sizeof(char)*2); strcat($3,newLabel()); printf("\ngo to "); strcat($3,newLabel());} ')' '{' {printf("\n"); int i = 0; do{printf("%c",$3[i]); i++;}while($3[i] != 'L'); printf(":");} S {printf("go to "); $6 = (char*)malloc(sizeof(char)*2); strcat($6,newLabel()); printf("\n");} '}' T_ELSE '{' {int i = 0; do{i++;}while($3[i] != 'L'); while(i<strlen($3)){printf("%c",$3[i]); i++;} printf(":");} S '}' {printf("%s:",$6);}
	;

While: T_WHILE '(' {printf("while ");} C {printf(" go to "); $3 = (char*)malloc(sizeof(char)*2); strcat($3,newLabel()); printf("\ngo to "); strcat($3,newLabel());} ')' '{' {printf("\n"); int i = 0; do{printf("%c",$3[i]); i++;}while($3[i] != 'L'); printf(":");} S {printf("go to ");int i =0 ;do{i++;}while($3[i]!='L');while(i<strlen($3)){printf("%c",$3[i]);i++;}; printf("\n");} '}' {int i = 0; do{i++;}while($3[i] != 'L'); while(i<strlen($3)){printf("%c",$3[i]); i++;} printf(":");} S 
	;

Main: T_MAIN '(' ')' {printf("main()"); printf(" go to ");$3 = (char*)malloc(sizeof(char)*2); strcat($3,newLabel());} '{' {printf("\n"); int i = 0; do{printf("%c",$3[i]); i++;}while($3[i] != '!'); printf(":");} S '}'

C:
	E relop E 		{printf("%s %s %s",$1,$2,$3);}
	;

relop:
	'>'				
	|'<'
	|"<="
	|">="
	|"=="
	|"!="			
	;

E:
	X op X		{$$ = (char*)malloc(sizeof(char)*4); strcpy($$,newTemp()); printf(" = %s %s %s\n",$1,$2,$3); }
	|T_NUM				
	|T_ID				
	;
 
op:
	'+'
	|'*'
	|'/'
	|'-'
	;

X:
	T_NUM
	|T_ID
	;	


%%
void yyerror(const char *s)
{
	printf("%s", s);
}
int main(int argc, char* argv[])
{
	yyin = fopen(argv[1], "r"); 
	{printf("START\n");}
	if(!yyparse())
		{printf("END\n");}
	else
		printf("Unsuccessful \n");
	return 0;

	//start
}

char* newLabel()
{
	char *s = (char*)malloc(4*sizeof(char));
	sprintf(s,"L%d",ln);
	printf("%s",s);
	ln++;
	return s;
}

char* newLabel100()
{
	char *s = (char*)malloc(4*sizeof(char));
	sprintf(s,"L%d",ln);
	ln++;
	return s;
}

char* newTemp()
{
	char *s = (char*)malloc(4*sizeof(char));
	sprintf(s,"T%d",tn);
	printf("%s",s);
	tn++;
	return s;
}
