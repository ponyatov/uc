log.log: src.src ./exe.exe tex
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

tex: tmp/compiler.pdf tmp/files.pdf
	
tmp/%.pdf: doc/%.dot
	dot -Tpdf -o$@ $<