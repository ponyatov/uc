#ifndef _H_HPP
#define _H_HPP

#include <iostream>
#include <cstdlib>
#include <vector>
#include <map>
using namespace std;

struct Sym {	// universal algebraic symbolic type, struct applies public
	string tag;	// class/type marker, required for token elements
	string val;	// value, string is universal can represent _any_ data

	Sym(string T,string V);	// <T:V> pair constructor
	Sym(string V);			// token constructor

	vector<Sym*> nest;		// \ nest[]ed elements for AST tree
	void push(Sym*o);		// / push new nested element

	map<string,Sym*> attr;	// \ named attributes, you require it


};

extern int yylex();			// \ 

#endif // _H_HPP
