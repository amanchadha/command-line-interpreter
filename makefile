all: shell

shell: 537sh.c
	gcc 537sh.c -o 537sh
	
clean:
	rm -f *.o 537sh
