    %defines %union {
    	struct AST {
    		string name;
    		double value;
    		virtual string dump(int depth=0);
    		vector<Sym*> nest; void push(Sym*);
    	} *node;
    }

    /* tokens name/value must be filled in lexer */
    
    %token <node> SYM NUM EQ ADD SUB MUL DIV POW LP RP
    %type <node> ex	 
    					// precedence down higher
    %right EQ
    %left ADD SUB
    %left MUL DIV
    %right PFX
    
    %%
    REPL : | REPL ex	{ cout << $2->dump() << endl } ;
    
    ex : SYM			{ $$=$1; } ; // token as is
    ex : NUM			{ $$=$1; } ; // token as is
    
    ex : ADD ex %prec PFX {
    	$$=$1; $$->push($2);				// unnary operator AST subtree
    	$$->value = + $2->value;			// + A
    	};
    ex : SUB ex %prec PFX {
    	$$=$1; $$->push($2);				// unnary operator AST subtree
    	$$->value = - $2->value;			// - A
    	};
    
    ex : ex ADD ex		{
    	$$=$2; $$->push($1); $$->push($3);	// build AST subtree
    	$$->value = $1->value + $2->value;	// synth attr without cryptic code
    	} ;
    
    ex : ex MUL ex		{
    	$$=$2; $$->push($1); $$->push($3);	// build AST subtree
    	$$->value = $1->value * $2->value;	// synth attr without cryptic code
    	} ;
