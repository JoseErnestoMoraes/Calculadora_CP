all: aula04.l aula04.y
	flex -i aula04.l
	bison aula04.y
	gcc aula04.tab.c -o compilador -lfl
	./compilador