final: program.c
	gcc program.c -o program.exe \
	-I"C:/Program Files/PostgreSQL/16/include" \
	-I"C:/Program Files/PostgreSQL/16/include/internal" \
	-L"C:/Program Files/PostgreSQL/16/lib" \
	-lecpg -lpq

program: program.pgc
	ecpg program.pgc