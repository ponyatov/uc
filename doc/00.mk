log.log: src.src ./exe.exe
	./exe.exe < src.src > log.log && tail $(TAIL) log.log