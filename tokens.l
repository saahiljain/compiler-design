%{
	#define YYSTYPE char*
	#include "y.tab.h"
    #include <stdio.h>
    extern char* yylval;
    extern void yyerror(const char *);
    int fg = 0;
%}
%%
"main"		{yylval = strdup(yytext); return T_MAIN;}
"while"		{yylval = strdup(yytext); return T_WHILE;}
"if"			{yylval = strdup(yytext); return T_IF;}
"else"			{yylval = strdup(yytext); return T_ELSE;}
[A-Za-z][A-Za-z0-9]*	{yylval = strdup(yytext); return T_ID;}
[0-9]+			{yylval = strdup(yytext); return T_NUM;}
"=="				{yylval=strdup(yytext);  return *yytext;}
"<="				{yylval=strdup(yytext);  return *yytext;}
">="				{yylval=strdup(yytext);  return *yytext;}
"!="				{yylval=strdup(yytext);  return *yytext;}
"="				{yylval=strdup(yytext);  return *yytext;}
">"				{yylval=strdup(yytext);  return *yytext;}
"<"				{yylval=strdup(yytext);  return *yytext;}
"+"				{yylval=strdup(yytext);  return *yytext;}
"*"				{yylval=strdup(yytext);  return *yytext;}
"{"				{yylval=strdup(yytext);  return *yytext;}
"}"				{yylval=strdup(yytext);  return *yytext;}
"("				{yylval=strdup(yytext);  return *yytext;}
")"				{yylval=strdup(yytext);  return *yytext;}
";"				{yylval=strdup(yytext);  return *yytext;}
[\n]			{}	
[\t]			{}
%%
