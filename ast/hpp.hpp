#ifndef _H_HPP
#define _H_HPP

#include <iostream>
#include <sstream>
#include <cstdlib>
#include <vector>
#include <map>
#include <cmath>
using namespace std;

struct Sym {		// universal algebraic symbolic type, struct applies public
	string tag;			// class/type marker, required for token elements
	string val;			// value, string is universal can represent _any_ data

	Sym(string T,string V);			// <T:V> pair constructor
	Sym(string V);					// token constructor

	vector<Sym*> nest;				// \ nest[]ed elements for AST tree
	Sym* push(Sym*o);				// / push new nested element

	map<string,Sym*> attr;			// \ named attributes, you require it

	virtual string head();			// return "<T:V>" pair repr
	string pad(int);				// pad output of tree elements
	string dump(int depth=0);		// return tree dump
};

struct Num: Sym { Num(string);		// number tokens
	Num(double);					// direct number constructor
	double val; string head(); };
struct Str: Sym { Str(string);		// 'string' tokens
	string head(); };

struct Vector: Sym { Vector(); };	// [vector]
struct Op: Sym { Op(string); };		// operator

typedef Sym*(*FN)(Sym*);					// \ [primitive] function
struct Fn: Sym { Fn(string V, FN F=NULL);
	FN fn; };								// /

								// == lexer interface ==
extern int yylex();				// get next token
extern int yylineno;			// line number
extern char* yytext;			// parsed lexeme (ASCIIZ string)
#define TOC(C,X) { yylval.o = new C(yytext); return X; } // gen.token macro
								// == syntax parser interface ==
extern int yyparse();			// grammar parser
extern void yyerror(string);	// error callback function
#include "ypp.tab.hpp"			// shared lex/yacc token definitions

#endif // _H_HPP
