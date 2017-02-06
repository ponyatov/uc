log.log: src.src ./exe.exe tmp/compiler.pdf
	./exe.exe < src.src > log.log && tail $(TAIL) log.log
C = cpp.cpp ypp.tab.cpp lex.yy.c
H = hpp.hpp ypp.tab.hpp
C = lex.yy.c
H = 
./exe.exe: $(C) $(H)
	$(CXX) -o $@ $(C)
ypp.tab.cpp: ypp.ypp
	bison $<
lex.yy.c: lpp.lpp
	flex $<
	
tmp/compiler.pdf: doc/compiler.dot
	dot -Tpdf -o$@ $<